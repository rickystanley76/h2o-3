CREATE TABLE test_table_empty(
    year INT,
    note STRING
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE test_table_part_empty(
    month INT,
    day INT,
    fractal FLOAT,
    note STRING
) 
PARTITIONED BY (year INT)
STORED AS TEXTFILE;
ALTER TABLE test_table_part_empty ADD PARTITION (year=2017);
ALTER TABLE test_table_part_empty ADD PARTITION (year=2018);

CREATE TABLE test_table_normal(
    year INT,
    month INT,
    day INT,
    fractal FLOAT,
    note STRING
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

INSERT INTO test_table_normal VALUES 
    (2019, 01, 20, 1234.12345544, "ROW CSV 1"),
    (2020, 02, 21, 5432.12345544, "ROW CSV 2"),
    (2021, 03, 22, 1111,          "ROW CSV 3");

CREATE TABLE test_table_multi_format(
    month INT,
    day INT,
    fractal FLOAT,
    note STRING
) 
PARTITIONED BY (year INT)
STORED AS TEXTFILE;

ALTER TABLE test_table_multi_format ADD PARTITION (year=2017);
INSERT INTO test_table_multi_format PARTITION (year=2017) VALUES (1, 1,  1234.12344, "MULTI ROW TEXT");

ALTER TABLE test_table_multi_format ADD PARTITION (year=2018);
LOAD DATA LOCAL INPATH '/opt/hive-scripts/01_2018.csv' INTO TABLE test_table_multi_format PARTITION (year=2018);
ALTER TABLE test_table_multi_format PARTITION (year=2018) SET SERDEPROPERTIES ('field.delim' = ',');

ALTER TABLE test_table_multi_format ADD PARTITION (year=2020);
LOAD DATA LOCAL INPATH '/opt/hive-scripts/01_2020.parquet' INTO TABLE test_table_multi_format PARTITION (year=2020);
ALTER TABLE test_table_multi_format PARTITION (year=2020) SET FILEFORMAT PARQUET;

CREATE TABLE test_table_multi_key(
    day INT,
    fractal FLOAT,
    note STRING
) 
PARTITIONED BY (year STRING, month INT)
STORED AS TEXTFILE;

ALTER TABLE test_table_multi_key ADD PARTITION (year=2017, month=01);
INSERT INTO test_table_multi_key PARTITION (year=2017, month=01) VALUES (1,  11.12345, "2017-01-1");
INSERT INTO test_table_multi_key PARTITION (year=2017, month=01) VALUES (2,  11.12345, "2017-01-2");

ALTER TABLE test_table_multi_key ADD PARTITION (year=2017, month=02);
INSERT INTO test_table_multi_key PARTITION (year=2017, month=02) VALUES (1,  22.12345, "2017-02-1");
INSERT INTO test_table_multi_key PARTITION (year=2017, month=02) VALUES (2,  22.12345, "2017-02-2");
INSERT INTO test_table_multi_key PARTITION (year=2017, month=02) VALUES (3,  22.12345, "2017-02-3");
