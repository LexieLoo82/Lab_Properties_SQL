DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
id SERIAL4 PRIMARY KEY,
address VARCHAR(255),
year INT8,
beds INT8,
build VARCHAR(255)
);
