:: This script used at windows machine prerequistie installation aws cli , configuration access key id and secret key configured in windows machine.
:: How to execute this script in cmd terminal with the  1 parameter as part this script as "Auto_Cancel_Jobs_stated_Queued_InProgress_With_IOTDevices.bat thingname"
:: This script designed on top of aws cli commands as below flow:
::  1. Get the list of queued jobs for a deviceid and send the cancel job request
::  2. Get the list of inprogress jobs for a deviceid and send the cancel job request
::  End of Script.
::
::******************************************************************************
::   File Name:           Auto_Cancel_Jobs_stated_Queue_InProgress_With_IOTDevices.bat thingname.bat
::   Description:         Script can be part for Continuous deployment task for IOT devices
::   Revision History
::   --------------------------------------------------------------------------
::   Revision:        0.1
::   Date:            June 23, 2022
::   Revised By:      Manikandan J
::   Description:     *Initial revision
::   --------------------------------------------------------------------------
@echo off
setLocal EnableDelayedExpansion
set thingname=%1
echo ************************************************************************************
echo ******** Get list of Queued jobs for %thingname%     ****
echo ********                   Shoot out the cancellation                          *****
echo ************************************************************************************
aws iot list-job-executions-for-thing --thing-name %thingname% --status QUEUED --query "executionSummaries[*].jobId" --output text > ids.txt
SET /p Jobid1=<ids.txt
set ids=%Jobid1%
:loop
for /f "tokens=1*" %%a in ("%ids%") do (
	echo %%a
	echo Let cancel the iot job %%a
	aws iot cancel-job-execution --job-id %%a --thing-name %thingname% --force
	echo Cancelled jobid %%a
	set ids=%%b
	)
if defined ids goto :loop

echo ************************************************************************************
echo ******** Get list of In-Progress jobs for %thingname%  ****
echo ********                   Shoot out the cancellation                          *****
echo ************************************************************************************
aws iot list-job-executions-for-thing --thing-name %thingname% --status IN_PROGRESS --query "executionSummaries[*].jobId" --output text > ids2.txt
SET /p Jobid2=<ids2.txt
set ids2=%Jobid2%
:loop
for /f "tokens=1*" %%c in ("%ids2%") do (
	echo %%c
	echo Let cancel the iot job %%c
	aws iot cancel-job-execution --job-id %%c --thing-name %thingname% --force
	echo Cancelled jobid %%c
	set ids2=%%d
	)
if defined ids goto :loop