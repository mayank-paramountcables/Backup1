@istest
private class TestClassBirthdayReminderBatch_Schedule {
@istest
    private static void testbatchclass()
    {
        profile p = [SELECt Id from profile WHERE name ='Standard Platform User' ];
        // New Test user For Record owner
      	User us = new  User(Alias='Admin',Email='testuser@orgmail.com',LastName='Testing',Username='standardus@testorg.com',LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',EmailEncodingKey='UTF-8');
		insert us;
        
             
        
        List<Contact> conlist = New list<Contact>();
        // 50 New Test contact records
        for(integer i=0;i<20;i++)
        {
            Contact con =new Contact(LastName = 'Test'+i, Birthdate=system.today().adddays(2), Email ='test@orgmail.com',OwnerId =us.id);
        	conlist.add(con);
            
        }
        System.debug('list size   '+conlist.size());
        
        insert conlist;
        System.runAs(us)
        {
            Test.startTest();
            // Test code for Batch Class
            BatchClassSendingBODEmailReminder batchclass = new BatchClassSendingBODEmailReminder();
            Database.executeBatch(batchclass, 200);
            
            //Test Code For Schedule Class
            ScheduleClassforBirthdayBatchClass scheduleclass = new ScheduleClassforBirthdayBatchClass();
            String sch = '0 30 9 * * ?';
            System.schedule('Test Schedule job', sch, scheduleclass);
            Test.stopTest();
             

        }

        
    }
}