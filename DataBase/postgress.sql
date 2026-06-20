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
