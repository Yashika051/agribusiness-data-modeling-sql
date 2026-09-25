create database agribusiness_week1;
use agribusiness_week1;

create table crop_production_raw (
    state_name varchar(100),
    district_name varchar(100),
    crop_year int,
    season varchar(100),
    crop varchar(150),
    area decimal(15,2),
    production decimal(18,2)
);
desc crop_production_raw;

alter table crop_production_raw
modify production varchar(50);

alter table crop_production_raw
modify area varchar(50);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/crop_production.csv'
into table crop_production_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select count(*) as row_count
from crop_production_raw;


select *
from crop_production_raw
limit 10;

select
    count(*) as total_rows,
    sum(state_name is null or state_name = '') as missing_state,
    sum(district_name is null or district_name = '') as missing_district,
    sum(crop_year is null or crop_year = '') as missing_crop_year,
    sum(season is null or season = '') as missing_season,
    sum(crop is null or crop = '') as missing_crop,
    sum(area is null or area = '') as missing_area,
    sum(production is null or production = '') as missing_production
from crop_production_raw;

select
    count(*) as missing_production,
    sum(area = '') as missing_area_too,
    sum(area <> '') as area_available
from crop_production_raw
where production = '';

select
    count(*) as total_rows,
    count(distinct state_name, district_name, crop_year, season, crop, area, production) as unique_rows
from crop_production_raw;

select
    season,
    count(*) as row_count
from crop_production_raw
group by season
order by season;

select
    season,
    char_length(season) as character_length,
    length(season) as byte_length,
    count(*) as row_count
from crop_production_raw
group by season, char_length(season), length(season)
order by season;

select
    crop,
    char_length(crop) as character_length,
    count(*) as row_count
from crop_production_raw
group by crop, char_length(crop)
order by crop
limit 20;


select
    count(*) as rows_with_trailing_spaces
from crop_production_raw
where crop <> trim(crop);

select
    count(*) as state_rows_with_whitespace
from crop_production_raw
where state_name <> trim(state_name);

select
    count(*) as district_rows_with_whitespace
from crop_production_raw
where district_name <> trim(district_name);

select
    count(*) as total_area_values,
    sum(area = '') as blank_area,
    sum(area regexp '^[0-9]+(\.[0-9]+)?$') as numeric_area,
    sum(area <> '' and area not regexp '^[0-9]+(\.[0-9]+)?$') as invalid_area
from crop_production_raw;


select distinct area
from crop_production_raw
where area <> ''
  and area not regexp '^[0-9]+(\.[0-9]+)?$';
  
  select
    count(*) as total_production_values,
    sum(production = '') as blank_production,
    sum(production regexp '^[0-9]+(\.[0-9]+)?$') as numeric_production,
    sum(production <> '' and production not regexp '^[0-9]+(\.[0-9]+)?$') as invalid_production
from crop_production_raw;


select
    count(*) as total_production_values,
    sum(production = '') as blank_production,
    sum(production regexp '^[0-9]+(\.[0-9]+)?$') as numeric_production,
    sum(production <> '' and production not regexp '^[0-9]+(\.[0-9]+)?$') as invalid_production
from crop_production_raw;


select distinct production
from crop_production_raw
where production <> ''
  and production not regexp '^[0-9]+(\.[0-9]+)?$'
limit 30;

select
    season,
    count(*) as missing_production
from crop_production_raw
where production = ''
group by season
order by missing_production desc;


select
    count(*) as missing_production,
    sum(area = '') as missing_area_too,
    sum(area <> '') as area_available
from crop_production_raw
where production = '';

select
    crop_year,
    count(*) as missing_production
from crop_production_raw
where production = ''
group by crop_year
order by crop_year;


select
    min(crop_year) as earliest_year,
    max(crop_year) as latest_year,
    count(distinct crop_year) as unique_years
from crop_production_raw;



create table crop_production_cleaned (
    state_name varchar(100),
    district_name varchar(100),
    crop_year int,
    season varchar(50),
    crop varchar(150),
    area decimal(15,2),
    production decimal(18,2)
);




insert into crop_production_cleaned (
    state_name,
    district_name,
    crop_year,
    season,
    crop,
    area,
    production
)
select
    trim(state_name),
    trim(district_name),
    crop_year,
    trim(season),
    trim(crop),
    nullif(trim(area), ''),
    nullif(trim(production), '')
from crop_production_raw;



select
    (select count(*) from crop_production_raw) as raw_rows,
    (select count(*) from crop_production_cleaned) as cleaned_rows;
    
    select count(*) as cleaned_rows
from crop_production_cleaned;

select count(*) as cleaned_rows
from crop_production_cleaned;

truncate table crop_production_cleaned;
    
    select
    count(*) as missing_production
from crop_production_cleaned
where production is null;


select
    sum(state_name <> trim(state_name)) as state_whitespace,
    sum(season <> trim(season)) as season_whitespace,
    sum(crop <> trim(crop)) as crop_whitespace
from crop_production_cleaned;



select
    count(*) as total_rows,
    count(area) as area_values,
    count(production) as production_values
from crop_production_cleaned;


select
    count(distinct state_name) as states,
    count(distinct district_name) as districts,
    count(distinct crop_year) as years,
    count(distinct season) as seasons,
    count(distinct crop) as crops
from crop_production_cleaned;


insert into crop_production_cleaned (
    state_name,
    district_name,
    crop_year,
    season,
    crop,
    area,
    production
)
select
    trim(state_name),
    trim(district_name),
    crop_year,
    trim(season),
    trim(crop),
    nullif(trim(area), ''),
    nullif(trim(production), '')
from crop_production_raw;

select count(*) as cleaned_rows
from crop_production_cleaned;


select count(*) as raw_rows
from crop_production_raw;
-- Check distribution of missing production values by season

select
    season,
    count(*) as missing_production
from crop_production_raw
where production = ''
group by season
order by missing_production desc;


-- Check whether area is available when production is missing

select
    count(*) as missing_production,
    sum(area = '') as missing_area_too,
    sum(area <> '') as area_available
from crop_production_raw
where production = '';



-- =====================================================
-- 4.2 DUPLICATE RECORD CHECK
-- =====================================================
-- Check whether any complete records appear more than once.

select
    count(*) as total_rows,
    count(distinct state_name, district_name, crop_year, season, crop, area, production) as unique_rows
from crop_production_raw;


-- =====================================================
-- 4.3 TEXT FORMATTING CHECK
-- =====================================================
-- Check for leading or trailing spaces in crop names.

select
    count(*) as rows_with_trailing_spaces
from crop_production_raw
where crop <> trim(crop);

select
    count(*) as state_rows_with_whitespace
from crop_production_raw
where state_name <> trim(state_name);

select
    count(*) as district_rows_with_whitespace
from crop_production_raw
where district_name <> trim(district_name);

select
    season,
    char_length(season) as character_length,
    length(season) as byte_length,
    count(*) as row_count
from crop_production_raw
group by season, char_length(season), length(season)
order by season;


truncate table crop_production_cleaned;




-- =====================================================
-- 4.4 NUMERIC DATA AND YEAR VALIDATION
-- =====================================================

-- Check the year range

select
    min(crop_year) as earliest_year,
    max(crop_year) as latest_year,
    count(distinct crop_year) as unique_years
from crop_production_raw;


-- Check area formatting

select
    count(*) as total_area_values,
    sum(area = '') as blank_area,
    sum(area regexp '^[0-9]+(\.[0-9]+)?$') as numeric_area,
    sum(area <> '' and area not regexp '^[0-9]+(\.[0-9]+)?$') as non_standard_area
from crop_production_raw;


-- Check production formatting

select
    count(*) as total_production_values,
    sum(production = '') as blank_production,
    sum(production regexp '^[0-9]+(\.[0-9]+)?$') as numeric_production,
    sum(production <> '' and production not regexp '^[0-9]+(\.[0-9]+)?$') as non_standard_production
from crop_production_raw;



-- =====================================================
-- 5. CLEANED TABLE CREATION
-- =====================================================
-- The cleaned table stores the standardized version of
-- the raw dataset.
-- The raw table is kept unchanged for reference.

create table crop_production_cleaned (
    state_name varchar(100),
    district_name varchar(100),
    crop_year int,
    season varchar(50),
    crop varchar(150),
    area decimal(15,2),
    production decimal(18,2)
);



-- 5.1 DATA CLEANING AND PRELIMINARY TRANSFORMATION
-- Remove unnecessary leading and trailing spaces from text fields.
-- Convert blank area and production values to NULL.
-- The target table's decimal columns automatically convert
-- valid numeric text values into numeric data types.
-- Missing production values are kept as NULL rather than
-- being changed to zero.

insert into crop_production_cleaned (
    state_name,
    district_name,
    crop_year,
    season,
    crop,
    area,
    production
)
select
    trim(state_name),
    trim(district_name),
    crop_year,
    trim(season),
    trim(crop),
    nullif(trim(area), ''),
    nullif(trim(production), '')
from crop_production_raw;




select count(*) as raw_rows
from crop_production_raw;


truncate table crop_production_cleaned;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/crop_production.csv'
into table crop_production_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;


select count(*) as cleaned_rows
from crop_production_cleaned;


insert into crop_production_cleaned (
    state_name,
    district_name,
    crop_year,
    season,
    crop,
    area,
    production
)
select
    trim(state_name),
    trim(district_name),
    crop_year,
    trim(season),
    trim(crop),
    nullif(trim(area), ''),
    nullif(trim(production), '')
from crop_production_raw;

truncate table crop_production_raw;















select count(*) as cleaned_rows
from crop_production_cleaned;

