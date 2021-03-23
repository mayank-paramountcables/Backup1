/*
--------------------------------------------------------------------------------------
Version#     Date                           Author                    Description
--------------------------------------------------------------------------------------
1.0          18-Mar-2020                   Manoj Pandey             Initial Version
--------------------------------------------------------------------------------------
*/
trigger MeetingAttendeesTrigger on Meeting_Attendees__c(after Insert, after Delete) 
{
    Trigger_on_off__c Objtrigger = Trigger_on_off__c.getValues('Meeting Attendees');
    if(Objtrigger.Is_Active__c == true){
        MeetingAttendeesTriggerHandler.onAfterUpdate(trigger.New,trigger.Old,trigger.Oldmap,trigger.isAfter,trigger.isInsert,trigger.isDelete);
    }
}