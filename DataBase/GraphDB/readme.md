# Graph Databases — From Zero in 30 Minutes

> Notes on graph DBs, why they beat JOINs, the data model, and the RDF → RDFS → Ontology ladder. With examples.

---

## 1. A Graph DB Is Two Things Stacked Together

When people say "graph database," they actually mean two separate layers:

| Layer | What it is | Why it matters |
|---|---|---|
| **Storage** | How the data physically sits on disk | *Native* graph storage keeps nodes and relationships pointing directly at each other. Non-native DBs bolt a graph model on top of a regular DB — usually slower. |
| **Processing engine** | The part that walks from node to node following relationships | The gold standard is **index-free adjacency**: each node *directly knows its neighbors* instead of looking them up in a giant index every time. |

**One-liner:** storage = where data lives, engine = how it moves through connections.

---

## 2. The Power of Graph: Performance, Flexibility, Agility

- **Performance** — Traversing relationships stays fast even as data grows, because you're just following pointers from one node to the next. (This is the big one — see JOINs below.)
- **Flexibility** — No rigid schema. Add new node types, relationship types, or properties on the fly without rebuilding tables.
- **Agility** — Because of that flexibility, your model evolves *with* your app. Requirements change? Add the new relationship. No painful migrations.

---

## 3 & 4. SQL vs NoSQL, and Why JOINs Are the Headache

This is the heart of it.

**In a relational (SQL) database, relationships aren't really stored** — they're *computed at query time* using JOINs. Want "friends of friends"? The DB matches foreign keys across tables, row by row.

For small data, fine. But with big data, every JOIN forces a scan-and-match across huge tables. Stack a few together (friends → of friends → of friends) and the cost **explodes roughly multiplicatively**.

**A graph database flips this.** The relationship is stored as a *first-class thing*, not computed. "Friends of friends" becomes: stand on a node → walk the `FRIEND` edges → walk again. Cost depends on how many connections you actually *touch*, not on how big the whole DB is.

### The example, both ways

**SQL — pay at read time:**
```sql
-- friends of friends of Alice
SELECT f2.name
FROM users u
JOIN friendships fr1 ON fr1.user_id   = u.id
JOIN users f1         ON f1.id         = fr1.friend_id
JOIN friendships fr2  ON fr2.user_id   = f1.id
JOIN users f2         ON f2.id         = fr2.friend_id
WHERE u.name = 'Alice';
-- 3 tables joined, scales with table size
```

**Graph (Cypher) — pay once at write time, traverse cheaply forever:**
```cypher
MATCH (alice:Person {name:'Alice'})-[:FRIEND]->()-[:FRIEND]->(fof:Person)
RETURN fof.name
-- just two hops along stored edges
```

> **Slogan:** In SQL, relationships cost you at *read* time. In a graph, you pay once at *write* time and traversals stay cheap forever.
>
> "SQL vs NoSQL only differs by the relationship" — the *data* isn't that different; what changes is **how relationships are treated**. SQL = join later. Graph = store the connection directly.

---

## 5. The Building Blocks: Nodes, Labels, Properties, Relationships

The actual data model has four pieces:

| Piece | What it is | Example |
|---|---|---|
| **Node** | A thing / entity | a person, a movie |
| **Label** | The *type* of a node | `:Person`, `:Movie` |
| **Property** | Key-value data on a node or relationship | `name: 'Messi'`, `since: 2021` |
| **Relationship** | A typed, directed connection between nodes | `(:Person)-[:OWNS]->(:Club)` |

### Picture it

```
 (:Person {name:'Messi'})  ──[:PLAYS_FOR {since:2021}]──▶  (:Club {name:'Inter Miami'})
        │
        └──[:WON]──▶  (:Award {name:'Ballon dOr', count:8})
```

### Build it in Cypher

```cypher
// create two nodes and a relationship in one line
CREATE (m:Person {name:'Messi', born:1987})
CREATE (c:Club   {name:'Inter Miami'})
CREATE (m)-[:PLAYS_FOR {since:2021}]->(c);
```

- `Person` / `Club` = **labels**
- `name`, `born`, `since` = **properties**
- `PLAYS_FOR` = **relationship** (note the direction `->`)

---

## 6. RDF — Resource Description Framework

A way to describe things using **triples**:

```
Subject  →  Predicate  →  Object       (this is a Triple)
Pizza    →  madeIn      →  Italy
```

So instead of writing "Messi owns Real Madrid" as a sentence, an RDF store holds the fact:

```
(Messi, owns, Real Madrid)
```

> ⚠️ **RDF only stores facts — it doesn't know whether they're correct.** The triple above is stored happily even though it's wrong. RDF has no rules; it just records.

---

## 7. RDFS — RDF Schema (adds the rules)

RDFS sits on top of RDF and adds **rules** so facts can be validated.

Example: define `Person`, `Animal`, `Food`, `Vehicle`. Then add a rule: *only Persons can like Food.*

```
✅  Person  likes  Food     (allowed)
❌  Vehicle likes  Food     (now flagged as wrong)
```

RDFS gives you these tools:

| Concept | Meaning | Example |
|---|---|---|
| **Class** | A category of things | `Food`, `Person` |
| **Subclass** | A more specific class | `Pizza` is a subclass of `Food` |
| **Domain** | What kind of subject a property applies to | `likes` has domain `Person` |
| **Range** | What kind of object a property points to | `likes` has range `Food` |

So `likes` going from `Person` (domain) to `Food` (range) is valid; anything else breaks the rule.

---

## 8. Ontology — The Full Knowledge Model

An ontology is a **complete model of knowledge about a domain**:

```
Ontology = Data + Classes + Relationships + Rules + Logic + Reasoning
```

Components:

- **Classes** — categories (`Person`, `Food`)
- **Individuals** — actual instances (`Messi`, `Pizza`)
- **Properties** — the relationships/attributes (`likes`, `madeIn`)
- **Restrictions** — constraints (e.g. "a Pizza must have ≥1 topping")
- **Inference** — deriving *new* facts from existing ones

**The step up from RDFS is reasoning.** If the ontology knows `Pizza ⊆ Food` and `Person likes Food`, and you state `Messi likes Pizza`, it can *infer* facts you never typed — that's the payoff.

**Ladder summary:**

```
RDF      → just facts (triples), no judgment
RDFS     → facts + rules (classes, domain, range)
Ontology → facts + rules + logic + reasoning (infers new knowledge)
```

---

## 9. Plugins & Connectors — Getting Data In (APOC)

Once the model exists, you use **plugins and connectors** for better visualization and for importing data from external locations. In Neo4j that's **APOC** (Awesome Procedures On Cypher).

Example — batch-import students from a CSV, 1000 rows at a time:

```cypher
CALL apoc.periodic.iterate(
  "CALL apoc.load.csv('file:///students.csv') YIELD map RETURN map",
  "CREATE (:Student {name: map.name})",
  {batchSize: 1000}
)
```

- `apoc.load.csv` — reads the file
- `apoc.periodic.iterate` — processes it in batches so you don't blow up memory
- `batchSize` — rows committed per chunk

---

## 10. ETL Pipeline vs Direct Import

Instead of importing/visualizing **directly**, use an **ETL pipeline** (Extract → Transform → Load) so the flow is **maintained and repeatable across the server**.

```
   Source(s)            ETL Pipeline                  Graph DB
 ┌──────────┐      ┌────────────────────┐         ┌────────────┐
 │ CSV / API │ ──▶ │ Extract → Transform │  ──▶    │   Neo4j    │
 │ DB / logs │      │        → Load       │         │  (graph)   │
 └──────────┘      └────────────────────┘         └────────────┘
```

**Why a pipeline beats a one-off load:** it's repeatable, scheduled, monitored, and survives across server runs — instead of being a manual import you re-do by hand every time the data changes.

---

### TL;DR

1. Graph DB = **storage** + **traversal engine** (index-free adjacency).
2. Wins on **performance, flexibility, agility**.
3. SQL computes relationships with JOINs (costly at read time); graphs *store* them (cheap forever).
4. Model = **nodes, labels, properties, relationships**.
5. **RDF** = facts → **RDFS** = facts + rules → **Ontology** = + logic + reasoning.
6. **APOC** imports data; an **ETL pipeline** keeps that import maintainable across the server.
