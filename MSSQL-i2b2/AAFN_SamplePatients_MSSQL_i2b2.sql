--##############################################################################
--##############################################################################
--### AIM-AHEAD Federated Network Data Extraction
--### Script: SamplePatients
--### Date: November 21, 2022
--### Database: Microsoft SQL Server
--### Data Model: i2b2
--### Created By: Griffin Weber (weber@hms.harvard.edu)
--##############################################################################
--##############################################################################


-- Randomly select patients for each active sampling group.
insert into dbo.AimAhead_SamplingGroupPatients(sampling_group, patient_num, sampled_date)
	select p.sampling_group, p.patient_num, GetDate()
	from (
		select *, row_number() over (partition by sampling_group order by newid()) random_sort_order
		from dbo.AimAhead_AllPatients
	) p inner join dbo.AimAhead_SamplingGroups g
		on p.sampling_group=g.sampling_group
	where g.is_active='Y' and p.random_sort_order<=g.initial_sample_size;

-- Get a distinct list of patients across all sampling groups.
insert into dbo.AimAhead_SampledPatients (patient_num)
	select distinct patient_num
	from dbo.AimAhead_SamplingGroupPatients;

-- Save the current date to know when sampling was last run.
update dbo.AimAhead_SamplingGroups
	set last_sampled_date=GetDate()
	where is_active='Y';
