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
