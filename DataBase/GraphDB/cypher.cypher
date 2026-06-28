
CREATE 
(russell:PLAYER{name:"Russell Westbrook", age: 33, number: 0, height: 1.91, weight: 91}),
(lebron:PLAYER{name:"LeBron James", age: 36, number: 6, height: 2.06, weight: 113}),
(anthony:PLAYER{name:"Anthony Davis", age: 28, number: 23, height: 2.08, weight: 115}),
(ja:PLAYER{name:"Ja Morant", age: 22, number: 12, height: 1.91, weight: 79}),
(luka:PLAYER{name:"Luka Doncic", age: 22, number: 77, height: 2.01, weight: 104}),
(kristaps:PLAYER{name:"Kristaps Porzingis", age: 26, number: 6, height: 2.21, weight: 109}),
(kevin:PLAYER{name:"Kevin Durant", age: 33, number: 7, height: 2.08, weight: 109}),
(james:PLAYER{name:"James Harden", age: 32, number: 13, height: 1.96, weight: 100}),
(giannis:PLAYER{name:"Giannis Antetokounmpo", age: 26, number: 34, height: 2.11, weight: 110}),
(khris:PLAYER{name:"Khris Middleton", age: 30, number: 22, height: 2.01, weight: 100}),	
(joel:PLAYER{name:"Joel Embiid", age: 27, number: 21, height: 2.13, weight: 127}),	
(tobias:PLAYER{name:"Tobias Harris", age: 29, number: 22, height: 2.03, weight: 100}),

(frank:COACH{name: "Frank Vogel"}),
(taylor:COACH{name: "Taylor Jenkins"}),
(jason:COACH{name: "Jason Kidd"}),
(steve:COACH{name: "Steve Nash"}),
(mike:COACH{name: "Mike Budenholzer"}),
(doc:COACH{name: "Doc Rivers"}),
(stan:COACH{name: "Stan Van Gundy"}),

(lakers:TEAM{name:"LA Lakers"}),
(memphis:TEAM{name:"Memphis Grizzlies"}),
(mavericks:TEAM{name:"Dallas Mavericks"}),
(nets:TEAM{name:"Brooklyn Nets"}),
(bucks:TEAM{name:"Milwaukee Bucks"}),
(sixers:TEAM{name:"Philadelphia 76ers"}),
 
(lebron)-[:TEAMMATES]-> (russell),
(lebron)<-[:TEAMMATES]- (russell),
(lebron)-[:TEAMMATES]-> (anthony),
(lebron)<-[:TEAMMATES]- (anthony),
(russell)-[:TEAMMATES]-> (anthony),
(russell)<-[:TEAMMATES]- (anthony),
(luka)-[:TEAMMATES]-> (kristaps),
(luka)<-[:TEAMMATES]- (kristaps),
(kevin)-[:TEAMMATES]-> (james),
(kevin)<-[:TEAMMATES]- (james),
(giannis)-[:TEAMMATES]-> (khris),
(giannis)<-[:TEAMMATES]- (khris),
(joel)-[:TEAMMATES]-> (tobias),
(joel)<-[:TEAMMATES]- (tobias),

(frank)-[:COACHES]->(lebron),
(frank)-[:COACHES]->(anthony),
(frank)-[:COACHES]->(russell),
(taylor)-[:COACHES]->(ja),
(jason)-[:COACHES]->(luka),
(jason)-[:COACHES]->(kristaps),
(steve)-[:COACHES]->(kevin),
(steve)-[:COACHES]->(james),
(mike)-[:COACHES]->(giannis),
(mike)-[:COACHES]->(khris),
(doc)-[:COACHES]->(tobias),
(doc)-[:COACHES]->(joel),

(lebron)-[:PLAYS_FOR {salary: 40000000}]-> (lakers),
(russell)-[:PLAYS_FOR {salary: 33000000}]-> (lakers),
(anthony)-[:PLAYS_FOR {salary: 38000000}]-> (lakers),
(ja)-[:PLAYS_FOR {salary: 8000000}]-> (memphis),
(luka)-[:PLAYS_FOR {salary: 50000000}]-> (mavericks),
(kristaps)-[:PLAYS_FOR {salary: 26000000}]-> (mavericks),
(kevin)-[:PLAYS_FOR {salary: 45000000}]-> (nets),
(james)-[:PLAYS_FOR{salary: 4200000}]-> (nets),
(giannis)-[:PLAYS_FOR {salary: 47000000}]-> (bucks),
(khris)-[:PLAYS_FOR {salary: 43000000}]-> (bucks),
(joel)-[:PLAYS_FOR {salary: 4000000}]-> (sixers),
(tobias)-[:PLAYS_FOR {salary: 4000000}]-> (sixers),

(frank)-[:COACHES_FOR]->(lakers),
(taylor)-[:COACHES_FOR]->(memphis),
(jason)-[:COACHES_FOR]->(mavericks),
(steve)-[:COACHES_FOR]->(nets),
(mike)-[:COACHES_FOR]->(bucks),
(doc)-[:COACHES_FOR]->(sixers),


(lebron)-[:PLAYED_AGAINST {minutes: 38, points: 32, assists: 6, rebounds: 6, turnovers: 2}]-> (memphis),
(russell)-[:PLAYED_AGAINST {minutes: 29, points: 16, assists: 12, rebounds: 11, turnovers: 16}]-> (memphis),
(anthony)-[:PLAYED_AGAINST {minutes: 36, points: 27, assists: 2, rebounds: 8, turnovers: 1}]-> (memphis),
(ja)-[:PLAYED_AGAINST {minutes: 43, points: 42, assists: 7, rebounds: 8, turnovers: 4}]-> (lakers),

(lebron)-[:PLAYED_AGAINST {minutes: 23, points: 25, assists: 12, rebounds: 3, turnovers: 0}]-> (memphis),
(russell)-[:PLAYED_AGAINST {minutes: 20, points: 11, assists: 10, rebounds: 3, turnovers: 8}]-> (memphis),
(anthony)-[:PLAYED_AGAINST {minutes: 30, points: 22, assists: 2, rebounds: 8, turnovers: 1}]-> (memphis),
(ja)-[:PLAYED_AGAINST {minutes: 35, points: 35, assists: 3, rebounds: 4, turnovers: 2}]-> (lakers),

(lebron)-[:PLAYED_AGAINST {minutes: 32, points: 18, assists: 3, rebounds: 6, turnovers: 1}]-> (nets),
(russell)-[:PLAYED_AGAINST {minutes: 26, points: 26, assists: 11, rebounds: 13, turnovers: 6}]-> (nets),
(anthony)-[:PLAYED_AGAINST {minutes: 30, points: 26, assists: 7, rebounds: 18, turnovers: 3}]-> (nets),
(kevin)-[:PLAYED_AGAINST {minutes: 43, points: 45, assists: 5, rebounds: 8, turnovers: 2}]-> (lakers),
(james)-[:PLAYED_AGAINST {minutes: 46, points: 35, assists: 13, rebounds: 4, turnovers: 7}]-> (lakers),

(kevin)-[:PLAYED_AGAINST {minutes: 34, points: 37, assists: 2, rebounds: 12, turnovers: 1}]-> (memphis),
(james)-[:PLAYED_AGAINST {minutes: 46, points: 35, assists: 13, rebounds: 4, turnovers: 7}]-> (memphis),
(ja)-[:PLAYED_AGAINST {minutes: 26, points: 32, assists: 13, rebounds: 6, turnovers: 2}]-> (nets),


(luka)-[:PLAYED_AGAINST {minutes: 44, points: 23, assists: 7, rebounds: 13, turnovers: 8}]-> (bucks),
(kristaps)-[:PLAYED_AGAINST {minutes: 24, points: 16, assists: 2, rebounds: 12, turnovers: 0}]-> (bucks),
(giannis)-[:PLAYED_AGAINST {minutes: 33, points: 26, assists: 16, rebounds: 18, turnovers: 5}]-> (mavericks),
(khris)-[:PLAYED_AGAINST {minutes: 46, points: 35, assists: 3, rebounds: 4, turnovers: 3}]-> (mavericks),

(luka)-[:PLAYED_AGAINST {minutes: 33, points: 28, assists: 6, rebounds: 3, turnovers: 3}]-> (sixers),
(kristaps)-[:PLAYED_AGAINST {minutes: 24, points: 18, assists: 4, rebounds: 11, turnovers: 1}]-> (sixers),
(joel)-[:PLAYED_AGAINST {minutes: 25, points: 29, assists: 7, rebounds: 22, turnovers: 2}]-> (mavericks),
(tobias)-[:PLAYED_AGAINST {minutes: 34, points: 18, assists: 13, rebounds: 4, turnovers: 0}]-> (mavericks),

(giannis)-[:PLAYED_AGAINST {minutes: 45, points: 36, assists: 5, rebounds: 12, turnovers: 3}]-> (sixers),
(khris)-[:PLAYED_AGAINST {minutes: 35, points: 22, assists: 5, rebounds: 6, turnovers: 0}]-> (sixers),
(joel)-[:PLAYED_AGAINST {minutes: 33, points: 23, assists: 3, rebounds: 10, turnovers: 3}]-> (bucks),
(tobias)-[:PLAYED_AGAINST {minutes: 38, points: 23, assists: 4, rebounds: 5, turnovers: 1}]-> (bucks),

(kevin)-[:PLAYED_AGAINST {minutes: 29, points: 28, assists: 6, rebounds: 8, turnovers: 0}]-> (mavericks),
(james)-[:PLAYED_AGAINST {minutes: 35, points: 17, assists: 10, rebounds: 8, turnovers: 5}]-> (mavericks),
(luka)-[:PLAYED_AGAINST {minutes: 37, points: 35, assists: 6, rebounds: 11, turnovers: 4}]-> (nets),
(kristaps)-[:PLAYED_AGAINST {minutes: 34, points: 27, assists: 4, rebounds: 8, turnovers: 0}]-> (nets),

(lebron)-[:PLAYED_AGAINST {minutes: 32, points: 27, assists: 12, rebounds: 10, turnovers: 4}]-> (sixers),
(russell)-[:PLAYED_AGAINST {minutes: 25, points: 19, assists: 9, rebounds: 14, turnovers: 5}]-> (sixers),
(anthony)-[:PLAYED_AGAINST {minutes: 32, points: 22, assists: 7, rebounds: 12, turnovers: 2}]-> (sixers),
(joel)-[:PLAYED_AGAINST {minutes: 36, points: 36, assists: 7, rebounds: 12, turnovers: 0}]-> (lakers),
(tobias)-[:PLAYED_AGAINST {minutes: 32, points: 22, assists: 1, rebounds: 7, turnovers: 0}]-> (lakers);

////////////////////////////////////////////////////////////
// ================ Querying For Nodes ================== //
////////////////////////////////////////////////////////////

// All nodes //
MATCH (n) RETURN n

// All nodes with specific label //
MATCH (player:PLAYER) RETURN player

// Properies //
MATCH (player:PLAYER) RETURN player.name, player.height

////////////////////////////////////////////////////////////
// =============== Filtering For Nodes ================== //
////////////////////////////////////////////////////////////

// Nodes where name is LeBron James //
MATCH (player:PLAYER) 
WHERE player.name = "LeBron James"
RETURN player

// Nodes where name is LeBron James //
MATCH (player:PLAYER {name: "LeBron James"}) 
RETURN player

// Nodes where name is not LeBron James
MATCH (player:PLAYER) 
WHERE player.name <> "LeBron James"
RETURN player

// Nodes where height is greater than or equal to 2
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player

// Nodes where height is less than 2
MATCH (player:PLAYER) 
WHERE player.height < 2
RETURN player

// Nodes with a BMI larger than 25
MATCH (player:PLAYER) 
WHERE (player.weight / (player.height * player.height)) > 25
RETURN player

// Nodes with a BMI not larger than 25
MATCH (player:PLAYER) 
WHERE NOT (player.weight / (player.height * player.height)) > 25
RETURN player

// Nodes with a weight larger than 100 and a height smaller than 2
MATCH (player:PLAYER) 
WHERE player.weight >= 100 AND player.height <= 2
RETURN player

// Nodes with height greater than 2.1 or weight greater than 120
MATCH (player:PLAYER) 
WHERE player.weight >= 120 OR player.height >= 2.1
RETURN player

// Limit
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player
LIMIT 3

// Skip
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player
SKIP 1
LIMIT 3

// Orderby
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player
SKIP 1
ORDER BY player.height DESC
LIMIT 3


// Query for multiple nodes
MATCH (coach:COACH), (player:PLAYER)
RETURN coach, player


////////////////////////////////////////////////////////////
// ============== Querying Relationships ================ //
////////////////////////////////////////////////////////////

// GET ALL LAKER PLAYERS //
MATCH (player:PLAYER) - [:PLAYS_FOR] -> (team:TEAM)
WHERE team.name = "LA Lakers"
RETURN player, team 

// GET ALL LAKER OR MAVERICKS PLAYERS //
MATCH (player:PLAYER) - [:PLAYS_FOR] -> (team:TEAM)
WHERE team.name = "LA Lakers" OR team.name = team.name = "Dallas Mavericks"
RETURN player, team 

// GET ALL PLAYERS THAT MAKE MORE THE 35M //
MATCH (player:PLAYER) - [contract :PLAYS_FOR] -> (team:TEAM)
WHERE contract.salary >= 35000000
RETURN player

// GET ALL OF LEBRONS TEAMMATES THAT MAKE MORE THAN 40M //
MATCH (lebron:PLAYER {name: "LeBron James"}) - [:TEAMMATES] -> (teammate:PLAYER)
MATCH (teammate) - [contract:PLAYS_FOR] -> (:TEAM)
WHERE contract.salary >= 40000000
RETURN teammate

////////////////////////////////////////////////////////////
// ==================== Aggregates ====================== //
////////////////////////////////////////////////////////////

// GET PLAYERS AND NUMBER OF GAMES PLAYED //
MATCH (player:PLAYER) - [gamePlayed:PLAYED_AGAINST] - (team:TEAM)
RETURN player.name, COUNT(gamePlayed)

// GET PLAYERS AND POINTS PER GAME //
MATCH (player:PLAYER) - [gamePlayed:PLAYED_AGAINST] - (team:TEAM)
RETURN player.name, AVG(gamePlayed.points)


// GET HIGHEST SCORING PLAYER IN THE LAKERS //
MATCH (player:PLAYER) - [:PLAYS_FOR] - (:TEAM {name: "LA Lakers"})
MATCH (player) - [gamePlayed:PLAYED_AGAINST] - (:TEAM)
RETURN player.name, AVG(gamePlayed.points) AS ppg
ORDER BY ppg DESC
LIMIT 1

// Deleting a Node (Not going to work)
MATCH(ja {name: "Ja Morant"})
DELETE ja

// Delete node and relationships
MATCH(ja {name: "Ja Morant"})
DETACH DELETE ja

// Delete relationship
MATCH(joel {name: "Joel Embiid"}) - [rel:PLAYS_FOR] -> (:TEAM)
DELETE rel

CREATE (lebron:PLAYER:COACH:GENERAL_MANAGER { name: "LeBron James", height: 2.01 })

CREATE (lebron:PLAYER:COACH:GENERAL_MANAGER { name: "LeBron James", height: 2.01 }) - [:PLAYS_FOR {salary: 40000000}] -> (:TEAM {name: "LA Lakers"})

CREATE (lebron:PLAYER:COACH:GENERAL_MANAGER { name: "LeBron James", height: 2.01 })
CREATE (:TEAM {name: "LA Lakers"})

MATCH (lebron:PLAYER {name: "LeBron James"}), (lakers:TEAM {name: "LA Lakers"})
CREATE (lebron) - [:PLAYS_FOR] -> (lakers)

MATCH (n) 
WHERE ID(n) = 3
SET n.age = 24, n.height = 2.02
RETURN n

MATCH (lebron)
WHERE ID(n) = 3
SET lebron:REF
RETURN lebron

MATCH (lebron {name: "LeBron James"}) - [contract:PLAYS_FOR] -> (:TEAM)
SET contract.salary = 60000000

MATCH (lebron)
WHERE ID(n) = 3
REMOVE lebron:REF
RETURN lebron

MATCH (lebron)
WHERE ID(n) = 3
REMOVE lebron.age
RETURN lebron

//IF EXISTS ADD OR CREATE
MERGE (player:PLayer {name:"LeBron James"})
SET p.age = 42;

//add a relationship if exists
MATCH (a:Player {name:"LeBrown James"}),
      (b:Player {name:"Ja Morant"})
MERGE (a)-[:Enemy]->(b);
