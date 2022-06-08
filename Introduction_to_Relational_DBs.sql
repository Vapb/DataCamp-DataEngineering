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

-- Casting
SELECT transaction_date, amount + CAST(fee as INT) AS net_amount 
FROM transactions;

-- Change Type of column after created
ALTER TABLE professors 
ALTER COLUMN firstname 
TYPE varchar(16);

-- Convert the values in firstname to a max. of 16 characters
ALTER TABLE professors 
ALTER COLUMN firstname 
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16);

-- ADD NOT NULL CONSTRAINT
ALTER TABLE professors
ALTER COLUMN firstname
SET NOT NULL;

-- ADD UNIQUE CONSTRAINT
ALTER TABLE universities
ADD CONSTRAINT university_shortname_unq UNIQUE(university_shortname);

-- ADD PRIMARY KEY CONSTRAINT
ALTER TABLE organizations
ADD CONSTRAINT organization_pk PRIMARY KEY (id);

-- ADD SERIAL ID COLUMN
ALTER TABLE professors 
ADD COLUMN id serial;

-- ADD FOREING KEY
ALTER TABLE professors 
ADD CONSTRAINT professors_fkey FOREIGN KEY (university_id) REFERENCES universities (id);

-- Other Example to populate tablecolumn
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;