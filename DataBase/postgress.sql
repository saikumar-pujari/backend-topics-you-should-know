-- ============================================
-- POSTGRESQL REFERENCE NOTES
-- ============================================

-- ---------- psql META-COMMANDS (not SQL, only work inside psql CLI) ----------
-- \l                      list all databases
-- \c <database_name>      connect to a database
-- Ctrl+L                  clear screen (psql CLI only)
-- \dt                     list all tables in current DB
-- \d <table_name>         describe table (show columns)
-- \r                      reset/clear current query buffer
-- \q                      quit psql
-- \di                     list all index
-- \di+ <index_name>       gives a description about that index
--\dx                      for extensions
--\x on                     extentend display is on;
-- ============================================================
-- 3-Level Architecture
-- ============================================================
-- 1) Physical 
-- 2) Logical
-- 3) Views ( create or replace view as ())

-- =====================================================
-- Sub Query is like having another table and taking data from it
-- CTE is like Sub Query but can be reused many times
-- Views store only query no data similar to CTE
-- CTAS stores Data also with query so faster than Views
-- temporwary tables are stored only for that spefic session only new session leads to deletion of the table just use # before the name (INTO #<table_name>).similar to CTAS

-- =============================================================
-- index in postgress does not differneate as cluster or non-cluster by default its a non-cluster

-- ---------- DDL: CREATE USER & GRANT PRIVILEGES ----------
CREATE USER sai WITH PASSWORD 'mypassword';

GRANT ALL PRIVILEGES ON DATABASE company TO sai;


-- ---------- DB HIERARCHY (conceptual, not SQL) ----------
-- server -> DB (multiple) -> schema (multiple) -> table -> columns -> rows (data)
-- row -> primary key -> data (key-value pairs)


-- ---------- SQL COMMAND CATEGORIES ----------
-- DDL  (Data Definition Language)  -> CREATE, ALTER, DROP
-- DML  (Data Manipulation Language) -> INSERT, UPDATE, DELETE
-- DQL  (Data Query Language)        -> SELECT


-- ---------- USEFUL FUNCTIONS ----------
-- Generate a range of numbers
SELECT generate_series(1, 100);


-- ---------- GROUP BY / HAVING / WHERE ----------
-- WHERE   -> filters rows BEFORE aggregation
-- HAVING  -> filters groups AFTER aggregation (used with GROUP BY)

-- Example:
-- SELECT department, COUNT(*) 
-- FROM employees
-- WHERE status = 'active'        -- filter before grouping
-- GROUP BY department
-- HAVING COUNT(*) > 5;           -- filter after grouping

-- PostgreSQL Logical Execution Order
    -- 1. WITH (CTEs)
    -- 2. FROM
    -- 3. JOIN
    -- 4. WHERE
    -- 5. GROUP BY
    -- 6. Aggregate Functions (SUM, AVG, COUNT...)
    -- 7. HAVING
    -- 8. WINDOW Functions (OVER())
    -- 9. SELECT
    -- 10. DISTINCT
    -- 11. UNION / INTERSECT / EXCEPT
    -- 12. ORDER BY
    -- 13. LIMIT / OFFSET / FETCH

-- IN THE CTE for the postgres when we want to use recurive CTE we need to mention RECURSIVE also.
-- SUB Query vs CTE always depends on the choice of data we need but we can reuse the CTE not the SUB Query.

-- ===========================================
--       INDEXS
-- ===========================================
-- In postgresql we normal use index simailr to the SQL index additionally we also use Materaial Index which stores Data in the disk rather than in memory!

CREATE MATERIALIZED VIEW student_subject_mv AS
SELECT
    s.name,
    sub.course
FROM studentlist s
JOIN subject sub
ON s.id=sub.student_id;

-- We also need to refersh this table every time we add data in other table
REFRESH MATERIALIZED VIEW student_subject_mv;

-- To add a comment for the index 
comment on index student_subject_mv is 'This Table shows the details for the course and students list'


--==============================================
--               USER AND PERMISSIONS
--==============================================
create role intern login password 'saikumar';
create user sai with password 'saikumar';
ALTER USER sai WITH SUPERUSER;
ALTER USER sai WITH NOSUPERUSER;
ALTER USER sai WITH PASSWORD 'newpassword';
ALTER ROLE sai RENAME TO saikumar;

DROP USER sai;
set role developer; --switch to dev role
reset role; --back to original role

GRANT senior_dev TO JR_dev; --jr inherit all permission from senior

--\du           list all users and their roles
GRANT CONNECT ON DATABASE <DB_name> TO developer; -- to connect to a DB ONLY
GRANT CREATE ON DATABASE <DB_name> TO developer; --allows to create schemna in DB ONLY
GRANT TEMP ON DATABASE <DB_name> TO developer; --allows dev to create temp tables only
GRANT CREATE,USAGE ON SCHEMA public TO sai; --allows to create,select in a new role for Tables
GRANT SELECT ON studentlist TO developer; --dev can only read data from table studentlisy
GRANT SELECT,INSERT,REFERENCES  ON studentlist TO developer; --read and write
GRANT SELECT,INSERT,UPDATE ON studentlist TO developer; --read ,write amd update
GRANT ALL ON studentlist TO developer; --all permissions in the table
GRANT ALL ON ALL TABLES IN SCHEMA public TO sai; --grants permission to all existing DB for the user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO sai;

GRANT SELECT(name) ON employee TO developer; -- can only read the name column
GRANT SELECT(age) ON employee TO developer;-- can only read the age column
GRANT SELECT ON studentlist, subject TO sai; --multiple DB connections
GRANT INSERT ON studentlist TO writer;

REVOKE SELECT ON studentlist FROM sai; --removes the select privilages
REVOKE ALL ON studentlist FROM sai; --removes all privilages

--=================================================
--      SEARCH IN DB
--=================================================
-- ts_vector:normalise the vector or only keeps the distinct words(lexemes)
generate always as(to_tsvector('english',coalesce('title','')||''||coalesce(body,'')))stored;
SELECT to_tsvector('english','PostgreSQL is an advanced relational database');

-- ts_query 
SELECT to_tsquery('english','database');
SELECT to_tsquery('english','machine & learning');
SELECT websearch_to_tsquery('english','postgresql OR django');

SELECT * FROM articles WHERE to_tsvector('english',content) @@ to_tsquery('english','database'); --uses both the ts_vector and ts_query (title || ' ' || category || ' ' || content)[Multiple columns]
SELECT * FROM articles WHERE to_tsvector('english', title || ' ' || content) @@ plainto_tsquery('english', 'postgresql database'); --can take 2 words without 
SELECT * FROM articles WHERE to_tsvector('english', title || ' ' || content) @@ websearch_to_tsquery('english', 'postgresql database'); --can take 2 words without better to use it
--diff between the to_tsquery and websearch_to_tsquery is websearch can find 2 words without and in it and normal to_tsquery requires & to find 2 words
SELECT * FROM articles WHERE to_tsvector('english',content) @@ websearch_to_tsquery('english','database postgresql'); --BOTH ARE EQUAL
SELECT * FROM articles WHERE to_tsvector('english',content) @@ to_tsquery('english','database & postgresql'); --BOTH ARE EQUAL

-- ts_rank
SELECT title,ts_rank(to_tsvector('english',content),to_tsquery('english','postgresql'),'MaxWords=10, MinWords=5') AS rank FROM articles WHERE to_tsvector('english',content)@@to_tsquery('english','postgresql') ORDER BY rank DESC;
--ts_rank takes both ts_tsvector & ts_tsvector for its ranking and gives a rank with most revalent text 

--Headline
select title,ts_headline('english',content,to_tsquery('english','postgresql')) from articles where to_tsvector('english',content)@@to_tsquery('english
','postgresql'); --highlightes the specifc word we are searching for!
-- 'MaxWords=10, MinWords=5'

SELECT title,
    ts_rank(to_tsvector('english', title || ' ' || content),websearch_to_tsquery('english', 'postgresql indexing')) AS rank, 
    ts_headline('english', content, websearch_to_tsquery('english', 'postgresql indexing')) AS preview 
    FROM articles 
    WHERE
    to_tsvector('english', title || ' ' || content)
    @@
    websearch_to_tsquery('english', 'postgresql indexing')
    ORDER BY rank DESC;

-- SET Weights
SELECT
    title,
    ts_rank(setweight(to_tsvector('english', title),'A')
    ||
    setweight(to_tsvector('english', content),'B'),
    plainto_tsquery('english','postgresql')
    ) AS rank
    FROM articles
    WHERE
    (
    setweight(to_tsvector('english', title),'A')
    ||
    setweight(to_tsvector('english', content),'B')
    )
    @@
    plainto_tsquery('english','postgresql')
    ORDER BY rank DESC;
-- PRODUCTION LEVEL CODE

SELECT
    title,
    ts_rank(
    setweight(to_tsvector('english',title),'A')
    ||
    setweight(to_tsvector('english',category),'B')
    ||
    setweight(to_tsvector('english',content),'C'),
    
    plainto_tsquery('english','postgresql')
    ) AS rank
    FROM articles
    WHERE
    (
    setweight(to_tsvector('english',title),'A')
    ||
    setweight(to_tsvector('english',category),'B')
    ||
    setweight(to_tsvector('english',content),'C')
    )
    @@
    plainto_tsquery('english','postgresql')
    ORDER BY rank DESC;
--GIN(Generate inverted index):Generalized Inverted Index
-- it basically works as keeps a track of all words and store them by group
ALTER TABLE articles
ADD COLUMN search_vector TSVECTOR
GENERATED ALWAYS AS
(
    setweight(to_tsvector('english',coalesce(title,'')),'A')
    ||
    setweight(to_tsvector('english',coalesce(category,'')),'B')
    ||
    setweight(to_tsvector('english',coalesce(content,'')),'C')
) STORED;
-- then this
Create index sai on articles USING GIN(search_vector);
--then to check
EXPLAIN SELECT * FROM articles
WHERE search_vector @@ plainto_tsquery('postgresql');

--other Search option for indexing
CREATE INDEX idx_search ON articles USING GIST(search_vector);
-- use GIST for specfic reasons only and its faster from insert/delete/updation

-- pg-trgm
CREATE EXTENSION pg_trgm;
SELECT * FROM books WHERE title % 'Postgres';
-- always remeber to keep a threshold value for the serach
CREATE INDEX idx_books_title_trgm ON books USING GIN(title gin_trgm_ops); --with GIN we need to use this extension for larger DB indexes

--=====================================================================================================================================
-- full code for full text serach in postgresql

CREATE TABLE articles(id SERIAL PRIMARY KEY,title TEXT,content TEXT);
insert into articles(title,content)values();

--step:1 create a search_vector colums
ALTER TABLE articles
ADD COLUMN search_vector TSVECTOR
GENERATED ALWAYS AS (
    to_tsvector('english',title || ' ' || content)
) STORED;

--step 2:create a index on search_vector using the GIN
CREATE INDEX idx_articles_fts ON articles USING GIN(search_vector);

--step 3:Trigram index if not exists
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_articles_title_trgm ON articles USING GIN(title gin_trgm_ops);

--step 4:check
--normal postgresql
SELECT * FROM articles WHERE search_vector @@ plainto_tsquery('english','PostgreSQL');
--trigram typo check
SELECT * FROM articles WHERE title % 'PostgrSQL' ORDER BY title <-> 'PostgrSQL';

--full text
SELECT
id,
title,
ts_rank(search_vector, plainto_tsquery('english','Python')) AS rank
FROM articles
WHERE search_vector @@ plainto_tsquery('english','Python');
--typo check only
SELECT id,title, similarity(title,'Python') AS score FROM articles WHERE title % 'Python';

-- BOTH
SELECT id,title,
    ts_rank(search_vector,plainto_tsquery('english', 'PostgrSQL')) AS rank,
    similarity(title, 'PostgrSQL') AS sim
FROM articles
WHERE search_vector @@ plainto_tsquery('english', 'PostgrSQL')OR title % 'PostgrSQL'
ORDER BY (ts_rank(search_vector,plainto_tsquery('english', 'PostgrSQL')) * 2) + similarity(title, 'PostgrSQL') DESC;
--=====================================================================================================================================

-- ============================================
-- DJANGO COMMANDS (reference only, NOT SQL)
-- Use these from the terminal, not inside psql
-- ============================================

-- Reverse-engineer existing DB tables into Django models:
-- python manage.py inspectdb

-- Save the generated models directly into your app:
-- python manage.py inspectdb > app/models.py

-- Inside each generated model, mark it as unmanaged by Django migrations:
-- class Meta:
--     managed = False

-- Then apply migrations as usual:
-- python manage.py migrate
