@isTest
public class MeetingAttendeesTriggerHandlerTest
{
    static testMethod void testmethod1()
    {
        Trigger_on_off__c cs = new Trigger_on_off__c();
        cs.Name='Meeting Attendees';
        cs.Is_Active__c = true;
        insert cs;
        Id AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();

        Account objAcc = new Account();
        objAcc.Name ='Test Account';
        objAcc.recordtypeid =AccountRecordTypeId;
        insert objAcc;
        Id ElectricianRecordTypeId = Schema.SObjectType.Meeting_Event__c.getRecordTypeInfosByName().get('Electrician').getRecordTypeId();
        
        Contact objcon = new Contact();
        objcon.LastName= 'Test Contact';
        objcon.AccountId= objAcc.id;
        insert objcon;
        
        Meeting_Event__c objME = new Meeting_Event__c ();
        objME.Start_Datetime__c = system.now();
        objME.Approval_Status__c ='Draft';
        objME.Retailer_Distributor__c = objAcc.id;
        objME.recordtypeid =ElectricianRecordTypeId;
        objME.Event_Status__c ='Planned';
        insert objME;
        /*objME.Approval_Status__c ='Approved';
        objME.Event_Status__c ='Completed';
        objME.Actual_Amount_Spent__c =50;
        update objME;*/
        
        Meeting_Attendees__c objMA = new Meeting_Attendees__c();
        objMA.Contact__c = objcon.id;
        objMA.Meeting_Event__c = objME.id;
        insert objMA;
        //Test.startTest();
        List<Meeting_Attendees__c> lstMeetingAttendees = [SELECT Id, IsDeleted FROM Meeting_Attendees__c WHERE Id = :objMA.id];
        delete lstMeetingAttendees;
        //Test.stopTest();
    }
}