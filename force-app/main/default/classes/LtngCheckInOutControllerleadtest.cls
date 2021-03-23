@istest
public class LtngCheckInOutControllerleadtest {
    @istest
    public static void getAllProduct()
    {
        Leads__c objAcc = new Leads__c();
        objAcc.First_Name__c = 'Test';
        objAcc.Last_Name__c = 'Lead';
        insert objAcc;
        Decimal latitude =28.563442;
        Decimal longitude =77.251998;
        LtngCheckInOutControllerlead.updateRecord(latitude,longitude,objAcc.id);
       // LtngCheckInOutControllerlead.updateRecordCheckOut(latitude,longitude,objAcc.id);
    }
}