--##############################################################################
--##############################################################################
--### AIM-AHEAD Federated Network Data Extraction
--### Script: InsertCodeMappingsData
--### Date: November 21, 2022
--### Database: Microsoft SQL Server
--### Data Model: i2b2
--### Created By: Griffin Weber (weber@hms.harvard.edu)
--##############################################################################
--##############################################################################


-- Concept prefixes
insert into dbo.AimAhead_CodeMappings (concept_type, concept_code, local_code, local_table, local_field, units, scale_factor, concept_code_name, local_code_name)
	values ('AA-PREFIX', 'DIAG-ICD9', 'DIAG|ICD9:', 'observation_fact', 'concept_cd', null, null, 'Prefix for DIAG-ICD9 codes', '@')
		, ('AA-PREFIX', 'DIAG-ICD10', 'DIAG|ICD10:', 'observation_fact', 'concept_cd', null, null, 'Prefix for DIAG-ICD10 codes', '@')

-- Demographics
insert into dbo.AimAhead_CodeMappings (concept_type, concept_code, local_code, local_table, local_field, units, scale_factor, concept_code_name, local_code_name)
	values ('AA-DEM', 'Sex:Female', 'F', 'patient_dimension', 'sex_cd', null, null, 'Female', 'F')
		, ('AA-DEM', 'Sex:Female', 'FEMALE', 'patient_dimension', 'sex_cd', null, null, 'Female', 'FEMALE')
		, ('AA-DEM', 'Sex:Male', 'M', 'patient_dimension', 'sex_cd', null, null, 'Male', 'M')
		, ('AA-DEM', 'Sex:Male', 'MALE', 'patient_dimension', 'sex_cd', null, null, 'Male', 'FEMALE')

-- Visit types
insert into dbo.AimAhead_CodeMappings (concept_type, concept_code, local_code, local_table, local_field, units, scale_factor, concept_code_name, local_code_name)
	values ('AA-VISIT', 'Inpatient', 'I', 'visit_dimension', 'inout_cd', null, null, 'Inpatient visit', 'I')
		, ('AA-VISIT', 'Inpatient', 'IN', 'visit_dimension', 'inout_cd', null, null, 'Inpatient visit', 'IN')
		, ('AA-VISIT', 'Inpatient', 'INPATIENT', 'visit_dimension', 'inout_cd', null, null, 'Inpatient visit', 'INPATIENT')
		, ('AA-VISIT', 'Inpatient', 'IN_PATIENT', 'visit_dimension', 'inout_cd', null, null, 'Inpatient visit', 'IN_PATIENT')
		, ('AA-VISIT', 'ED', 'E', 'visit_dimension', 'inout_cd', null, null, 'Emergency room visit', 'E')
		, ('AA-VISIT', 'ED', 'ED', 'visit_dimension', 'inout_cd', null, null, 'Emergency room visit', 'ED')
		, ('AA-VISIT', 'ED', 'ER', 'visit_dimension', 'inout_cd', null, null, 'Emergency room visit', 'ER')
		, ('AA-VISIT', 'ED', 'EMERGENCY', 'visit_dimension', 'inout_cd', null, null, 'Emergency room visit', 'EMERGENCY')
		, ('AA-VISIT', 'ICU', 'ICU', 'visit_dimension', 'location_cd', null, null, 'ICU visit', 'ICU')

-- Laboratory tests
insert into dbo.AimAhead_CodeMappings (concept_type, concept_code, local_code, local_table, local_field, units, scale_factor, concept_code_name, local_code_name)
	select '4CE-LAB-LOINC' concept_type, concept_code, local_code, 'observation_fact', 'concept_cd', units, scale_factor, concept_code_name, (
			select max(c_name) from ont.i2b2 o where o.c_basecode = t.local_code and o.c_synonym_cd='N'
		) local_code_name
	from (
		select null concept_code, null local_code, null units, null scale_factor, null concept_code_name where 1=0
		union all select '1742-6','LAB|LOINC:1742-6','U/L',1,'alanine aminotransferase (ALT)'
		union all select '1751-7','LAB|LOINC:1751-7','g/dL',1,'albumin'
		union all select '1920-8','LAB|LOINC:1920-8','U/L',1,'aspartate aminotransferase (AST)'
		union all select '1975-2','LAB|LOINC:1975-2','mg/dL',1,'total bilirubin'
		union all select '1988-5','LAB|LOINC:1988-5','mg/L',1,'C-reactive protein (CRP) (Normal Sensitivity)'
		union all select '2019-8','LAB|LOINC:2019-8','mmHg',1,'PaCO2'
		union all select '2160-0','LAB|LOINC:2160-0','mg/dL',1,'creatinine'
		union all select '2276-4','LAB|LOINC:2276-4','ng/mL',1,'Ferritin'
		union all select '2532-0','LAB|LOINC:2532-0','U/L',1,'lactate dehydrogenase (LDH)'
		union all select '2703-7','LAB|LOINC:2703-7','mmHg',1,'PaO2'
		union all select '3255-7','LAB|LOINC:3255-7','mg/dL',1,'Fibrinogen'
		union all select '33959-8','LAB|LOINC:33959-8','ng/mL',1,'procalcitonin'
		union all select '34714-6','LAB|LOINC:34714-6','DEFAULT',1,'INR'
		union all select '48065-7','LAB|LOINC:48065-7','ng/mL{FEU}',1,'D-dimer (FEU)'
		union all select '48066-5','LAB|LOINC:48066-5','ng/mL{DDU}',1,'D-dimer (DDU)'
		union all select '49563-0','LAB|LOINC:49563-0','ng/mL',1,'cardiac troponin (High Sensitivity)'
		union all select '5902-2','LAB|LOINC:5902-2','s',1,'prothrombin time (PT)'
		union all select '6598-7','LAB|LOINC:6598-7','ug/L',1,'cardiac troponin (Normal Sensitivity)'
		union all select '6690-2','LAB|LOINC:6690-2','10*3/uL',1,'white blood cell count (Leukocytes)'
		union all select '731-0','LAB|LOINC:731-0','10*3/uL',1,'lymphocyte count'
		union all select '751-8','LAB|LOINC:751-8','10*3/uL',1,'neutrophil count'
		union all select '777-3','LAB|LOINC:777-3','10*3/uL',1,'platelet count'
		union all select '4548-4','LAB|LOINC:4548-4','%',1,'hemoglobin A1c'
	) t
