/*
--------------------------------------------------------------------------------------
Version#     Date                           Author                    Description
--------------------------------------------------------------------------------------
1.0          18-Mar-2020                   Manoj Pandey             Initial Version
--------------------------------------------------------------------------------------
*/
trigger MeetingEventTrigger on Meeting_Event__c(after update) 
{
    MeetingEventTriggerHandler.onAfterUpdate(trigger.New,trigger.Oldmap);
}