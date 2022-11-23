# FederatedNetworkDataExtraction

AIM-AHEAD Federated Network (AAFN)

SQL code to generate LocalPatientData.csv and SharedAggregateData.csv files

View the presentation AimAheadFederatedNetworkOverview.pptx for a description of the files.

The MSSQL-i2b2 folder contains scripts for Microsoft SQL Server and the i2b2 data model.

Run the scripts in this order:
1) AAFN_CreateTables.sql
2) AAFN_InsertCodeMappingsData.sql
3) AAFN_InsertSamplingGroupsData.sql
4) AAFN_GetAllPatients.sql
5) AAFN_SamplePatients.sql
6) AAFN_GetPatientData.sql

Save the table AimAhead_LocalPatientData to a CSV file named LocalPatientData.csv.
*** NEVER SHARE THIS FILE ***

Save the table AimAhead_SharedAggregateData to a CSV file named SharedAggregateData.csv.
*** Send this file to the AIM-AHEAD Infrastructure Core ***
