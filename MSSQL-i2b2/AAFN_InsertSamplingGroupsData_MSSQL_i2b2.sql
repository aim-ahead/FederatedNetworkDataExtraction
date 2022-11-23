--##############################################################################
--##############################################################################
--### AIM-AHEAD Federated Network Data Extraction
--### Script: InsertSamplingGroupsData
--### Date: November 21, 2022
--### Database: Microsoft SQL Server
--### Data Model: i2b2
--### Created By: Griffin Weber (weber@hms.harvard.edu)
--##############################################################################
--##############################################################################


-- Define the sampling groups.
insert into dbo.AimAhead_SamplingGroups (sampling_group, initial_sample_size, is_active, group_desc)
	values ('AllPatientsSince2017', 10000, 'Y', 'All patients with any type of visit since Jan 1, 2017');

insert into dbo.AimAhead_SamplingGroups (sampling_group, initial_sample_size, is_active, group_desc)
	values ('AdmittedSince2017', 10000, 'Y', 'All patients with an inpatient visit since Jan 1, 2017');

