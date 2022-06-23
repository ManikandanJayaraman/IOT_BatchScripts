# IOT_BatchScripts
This script used at windows machine prerequistie installation aws cli , configuration access key id and secret key configured in windows machine.
* How to execute this script in cmd terminal with the  1 parameter as part this script as "Auto_Cancel_Jobs_stated_Queued_InProgress_With_IOTDevices.bat thingname"
* This script designed on top of aws cli commands as below flow:
  * 1. Get the list of queued jobs for a deviceid and send the cancel job request
  * 2. Get the list of inprogress jobs for a deviceid and send the cancel job request
