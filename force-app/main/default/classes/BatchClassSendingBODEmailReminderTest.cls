@isTest 
public class BatchClassSendingBODEmailReminderTest 
{
    static testMethod void testMethod1() 
    {
        List<contact> lstCon= new List<contact>();
        for(Integer i=0 ;i <200;i++)
        {
            contact objCon = new contact ();
            objCon.LastName ='Name'+i;
            objCon.Birthdate =System.today().addDays(+2);
            objCon.Email ='test'+i+'@gmail.com';
            lstCon.add(objCon);
        }
        for(Integer i=0 ;i <200;i++)
        {
            contact objCon = new contact ();
            objCon.LastName ='Test Name'+i;
            objCon.Birthdate =System.today();
            objCon.Email ='test'+i+'@gmail.com';
            lstCon.add(objCon);
        }
        insert lstCon;
      /*  
        Test.startTest();

            BatchClassSendingBODEmailReminder obj = new BatchClassSendingBODEmailReminder();
            BatchClassSendingBODEmailReminderDaily objD = new BatchClassSendingBODEmailReminderDaily();
            DataBase.executeBatch(obj); 
             DataBase.executeBatch(objD); 
        Test.stopTest();
        System.runAs(us)*/
        {
            Test.startTest();
            // Test code for Batch Class
            BatchClassSendingBODEmailReminder batchclass = new BatchClassSendingBODEmailReminder();
            Database.executeBatch(batchclass, 200);
            
            //Test Code For Schedule Class
            ScheduleClassforDailyBirthdayReminder scheduleclass = new ScheduleClassforDailyBirthdayReminder();
            String sch = '0 30 9 * * ?';
            System.schedule('Test Schedule job', sch, scheduleclass);
            Test.stopTest();
             

        }
        
    }
}