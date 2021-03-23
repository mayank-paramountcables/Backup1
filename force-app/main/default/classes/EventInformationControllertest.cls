@istest
public class EventInformationControllertest {
    @istest
    public static void method()
    {
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
        
        Meeting_Attendees__c objMA = new Meeting_Attendees__c();
        objMA.Contact__c = objcon.id;
        objMA.Meeting_Event__c = objME.id;
        insert objMA;
        
        PageReference pageRef = Page.EventInformation;
        pageRef.getParameters().put('id', String.valueOf(objME.Id));
        Test.setCurrentPage(pageRef);
        //ApexPages.StandardSetController sc = new ApexPages.StandardSetController(objME);
        EventInformationController objEC = new EventInformationController(new ApexPages.StandardController(objME));
    }
}