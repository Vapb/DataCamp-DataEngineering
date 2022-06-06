-- Having a look at database information
SELECT table_schema, table_name
FROM information_schema.tables;

-- Having a look at a certain table
SELECT table_schema, table_name
FROM information_schema.tables;

-- Get table names created by users 'public'
SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';

-- Get information about university_professors
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'university_professors';

-- Creating Tables CREATE TABLE
CREATE TABLE professors (
    firstname text,
    lastname text
);

-- Adding Column with Alter TABLE
ALTER TABLE professors
ADD university_shortname text;

-- Alter data from table (column name)
ALTER TABLE affiliations
RENAME COLUMN organisation TO organization;

-- Drop columns
ALTER TABLE affiliations
DROP COLUMN university_shortname;

-- Insert data from one table to another (MIGRATE DATA)
INSERT INTO professors 
SELECT DISTINCT firstname, lastname, university_shortname 
FROM university_professors;

-- Deleting table
DROP TABLE university_professors;