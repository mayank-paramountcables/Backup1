@isTest
public class MeetingEventTriggerHandlerTest
{
    static testMethod void testmethod1()
    {
        Id AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();

        Account objAcc = new Account();
        objAcc.Name ='Test Account';
        objAcc.recordtypeid =AccountRecordTypeId;
        insert objAcc;
        Id ElectricianRecordTypeId = Schema.SObjectType.Meeting_Event__c.getRecordTypeInfosByName().get('Electrician').getRecordTypeId();

        Meeting_Event__c objME = new Meeting_Event__c ();
        objME.Start_Datetime__c = system.now();
        objME.Approval_Status__c ='Draft';
        objME.Retailer_Distributor__c = objAcc.id;
        objME.recordtypeid =ElectricianRecordTypeId;
        objME.Event_Status__c ='Planned';
        insert objME;
        objME.Approval_Status__c ='Approved';
        objME.Event_Status__c ='Completed';
        objME.Actual_Amount_Spent__c =50;
        update objME;
    }
}