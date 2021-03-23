public class EventInformationController
 {
    public String strEventId {get;set;}
    public List<Meeting_Attendees__c> lstMeetingAttendees {get;set;}
    public Meeting_Event__c objMeeting {get;set;}
    public DateTime dtdatetime {get;set;}
    public boolean isElectricianRecordType {get;set;}
    public EventInformationController(ApexPages.StandardController controller)
    {
        try
        {
            lstMeetingAttendees = new List<Meeting_Attendees__c>();
            objMeeting = new Meeting_Event__c();
            strEventId =System.currentPageReference().getParameters().get('id');
            if(strEventId !=null && strEventId !=''){
                Id ElectricianRecordTypeId = Schema.SObjectType.Meeting_Event__c.getRecordTypeInfosByName().get('Electrician').getRecordTypeId();
                
                
                List<Meeting_Event__c> lstMeetingEvent = new List<Meeting_Event__c>();
                
                lstMeetingEvent = [Select Id,Name,Start_Datetime__c,Distributor__c,Retailer_Distributor__r.Name,No_of_Electricians_to_be_attended__c,Last_meet_with_this_retailer__c,Amount_required_for_meet__c,Actual_Amount_Spent__c,Address__c,RecordTypeId from Meeting_Event__c where Id = : strEventId];
                if(lstMeetingEvent.size()>0){
                    
                    if(lstMeetingEvent[0].Start_Datetime__c !=null ){
                        //User currentUser = [Select TimeZoneSidKey from User where id =: USerInfo.getUserId()];
                        TimeZone tz = UserInfo.getTimeZone();
                        System.debug('Display name: ' + tz.getDisplayName());
                        System.debug('ID: ' + tz.getID());
                        Integer gettime = tz.getOffset(DateTime.newInstance(2012,10,23,12,0,0));
                        // During daylight saving time for the America/Los_Angeles time zone
                        System.debug('Offset: ' + tz.getOffset(DateTime.newInstance(2012,10,23,12,0,0)));
                        // Not during daylight saving time for the America/Los_Angeles time zone
                        System.debug('Offset: ' + tz.getOffset(DateTime.newInstance(2012,11,23,12,0,0)));
                        System.debug('String format: ' + tz.toString());
                        Integer mins = gettime / 60000;
                        System.debug('mins... ' + mins);
                        
                        lstMeetingEvent[0].Start_Datetime__c = lstMeetingEvent[0].Start_Datetime__c.addMinutes(mins);
                                            
                    }
                    
                    if(lstMeetingEvent[0].Last_meet_with_this_retailer__c !=null ){
                        //User currentUser = [Select TimeZoneSidKey from User where id =: USerInfo.getUserId()];
                        TimeZone tz = UserInfo.getTimeZone();
                        System.debug('Display name: ' + tz.getDisplayName());
                        System.debug('ID: ' + tz.getID());
                        Integer gettime = tz.getOffset(DateTime.newInstance(2012,10,23,12,0,0));
                        // During daylight saving time for the America/Los_Angeles time zone
                        System.debug('Offset: ' + tz.getOffset(DateTime.newInstance(2012,10,23,12,0,0)));
                        // Not during daylight saving time for the America/Los_Angeles time zone
                        System.debug('Offset: ' + tz.getOffset(DateTime.newInstance(2012,11,23,12,0,0)));
                        System.debug('String format: ' + tz.toString());
                        Integer mins = gettime / 60000;
                        System.debug('mins... ' + mins);
                        
                        dtdatetime = lstMeetingEvent[0].Last_meet_with_this_retailer__c;
                        dtdatetime = dtdatetime.addMinutes(mins);               
                    }
                    
                    objMeeting = lstMeetingEvent[0];
                    if(objMeeting.RecordTypeId == ElectricianRecordTypeId){
                        isElectricianRecordType = true;
                    }else{
                        isElectricianRecordType = false;
                    }
                }
                
                lstMeetingAttendees = [Select Id,Name,Contact__r.Name,Contact__r.Account.Name,Contact_Address__c,Contact_Number__c,Date_Of_Birth__c from Meeting_Attendees__c where Meeting_Event__c =:strEventId];
            }
        }
        catch(exception e)
        {
            system.debug('exception.....'+e);
        }
    }
 }