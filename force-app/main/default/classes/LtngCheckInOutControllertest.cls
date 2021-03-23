@istest
public class LtngCheckInOutControllertest {
    @istest
    public static void getAllProduct()
    {
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';
        insert objAcc;
        Decimal latitude =28.563442;
        Decimal longitude =77.251998;
        LtngCheckInOutController.updateRecord(latitude,longitude,objAcc.id);
        LtngCheckInOutController.updateRecordCheckOut(latitude,longitude,objAcc.id);
    }
}