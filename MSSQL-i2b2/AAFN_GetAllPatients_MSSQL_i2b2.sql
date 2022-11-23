--##############################################################################
--##############################################################################
--### AIM-AHEAD Federated Network Data Extraction
--### Script: GetAllPatients
--### Date: November 21, 2022
--### Database: Microsoft SQL Server
--### Data Model: i2b2
--### Created By: Griffin Weber (weber@hms.harvard.edu)
--##############################################################################
--##############################################################################


-- Get the list of patients who match the criteria for the sampling group AllPatientsSince2017
insert into dbo.AimAhead_AllPatients (sampling_group, patient_num, added_date)
	select 'AllPatientsSince2017', patient_num, GetDate()
		from (
			select distinct patient_num
			from dbo.visit_dimension
			where inout_cd not in ('@')
				and start_date >= '2017-01-01'
		) t
		where patient_num not in (
			select patient_num
			from dbo.AimAhead_AllPatients
			where sampling_group='AllPatientsSince2017'
		);


-- Get the list of patients who match the criteria for the sampling group AdmittedSince2017
insert into dbo.AimAhead_AllPatients (sampling_group, patient_num, added_date)
	select 'AdmittedSince2017', patient_num, GetDate()
		from (
			select distinct patient_num
			from dbo.visit_dimension v
				inner join dbo.AimAhead_CodeMappings m
					on upper(v.inout_cd)=m.local_code and m.concept_type='AA-VISIT' and m.concept_code='Inpatient'
			where start_date >= '2017-01-01'
		) t
		where patient_num not in (
			select patient_num
			from dbo.AimAhead_AllPatients
			where sampling_group='AdmittedSince2017'
		);
