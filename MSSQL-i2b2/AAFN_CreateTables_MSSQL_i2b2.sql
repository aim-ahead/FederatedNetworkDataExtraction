--##############################################################################
--##############################################################################
--### AIM-AHEAD Federated Network Data Extraction
--### Script: CreateTables
--### Date: November 21, 2022
--### Database: Microsoft SQL Server
--### Data Model: i2b2
--### Created By: Griffin Weber (weber@hms.harvard.edu)
--##############################################################################
--##############################################################################


-- Drop existing tables.

if OBJECT_ID(N'dbo.AimAhead_AllPatients', N'U') is not null drop table dbo.AimAhead_AllPatients;
if OBJECT_ID(N'dbo.AimAhead_SamplingGroups', N'U') is not null drop table dbo.AimAhead_SamplingGroups;
if OBJECT_ID(N'dbo.AimAhead_SamplingGroupPatients', N'U') is not null drop table dbo.AimAhead_SamplingGroupPatients;
if OBJECT_ID(N'dbo.AimAhead_SampledPatients', N'U') is not null drop table dbo.AimAhead_SampledPatients;
if OBJECT_ID(N'dbo.AimAhead_CodeMappings', N'U') is not null drop table dbo.AimAhead_CodeMappings;
if OBJECT_ID(N'dbo.AimAhead_LocalPatientData', N'U') is not null drop table dbo.AimAhead_LocalPatientData;
if OBJECT_ID(N'dbo.AimAhead_SharedAggregateData', N'U') is not null drop table dbo.AimAhead_SharedAggregateData;


-- Create new tables.

create table dbo.AimAhead_AllPatients (
	sampling_group varchar(50) not null,
	patient_num int not null,
	added_date datetime not null,
	removed_date datetime
);

create table dbo.AimAhead_SamplingGroups (
	sampling_group varchar(50) not null,
	initial_sample_size int not null,
	is_active char(1) not null,
	last_sampled_date datetime,
	group_desc varchar(1000)
);

create table dbo.AimAhead_SamplingGroupPatients (
	sampling_group varchar(50) not null,
	patient_num int not null,
	sampled_date datetime
);

create table dbo.AimAhead_SampledPatients (
	patient_num int not null
);

create table dbo.AimAhead_CodeMappings (
	map_id int identity(1,1) not null,
	concept_type varchar(50) not null,
	concept_code varchar(50) not null,
	local_code varchar(50) not null,
	local_table varchar(100),
	local_field varchar(100),
	units varchar(50),
	scale_factor float,
	concept_code_name varchar(1000),
	local_code_name varchar(1000)
);

create table dbo.AimAhead_LocalPatientData (
	row_id bigint identity(1,1) not null,
	site_id varchar(50) not null,
	patient_num int not null,
	concept_type varchar(50) not null,
	concept_code varchar(50) not null,
	start_date datetime not null,
	end_date datetime not null,
	value_num numeric(18,5) not null,
	value_char varchar(max) not null,
	value_units varchar(50) not null,
	local_code_name varchar(1000) not null
);

create table dbo.AimAhead_SharedAggregateData (
	site_id varchar(50) not null,
	concept_type varchar(50) not null,
	concept_code varchar(50) not null,
	units varchar(50) not null,
	num_patients int not null,
	num_records int not null,
	min_start_date datetime not null,
	max_start_date datetime not null,
	min_value_num numeric(18,5) not null,
	max_value_num numeric(18,5) not null,
	mean_value_num numeric(18,5) not null,
	stdev_value_num numeric(18,5) not null,
	count_distinct_value_char int not null,
	max_local_code_name varchar(1000) not null
);


-- Add primary keys and indexes.

alter table dbo.AimAhead_AllPatients add primary key (sampling_group, patient_num);
alter table dbo.AimAhead_SamplingGroups add primary key (sampling_group);
alter table dbo.AimAhead_SamplingGroupPatients add primary key (sampling_group, patient_num);
alter table dbo.AimAhead_SampledPatients add primary key (patient_num);
alter table dbo.AimAhead_CodeMappings add primary key (map_id);
alter table dbo.AimAhead_LocalPatientData add primary key (row_id);
alter table dbo.AimAhead_SharedAggregateData add primary key (site_id, concept_type, concept_code, units);

create nonclustered index idx_patient_concept on dbo.AimAhead_LocalPatientData (patient_num, concept_type, concept_code, site_id);
create nonclustered index idx_concept_patient on dbo.AimAhead_LocalPatientData (concept_type, concept_code, patient_num, site_id);

create nonclustered index idx_concept_to_local on dbo.AimAhead_CodeMappings (concept_type, concept_code, local_code);



