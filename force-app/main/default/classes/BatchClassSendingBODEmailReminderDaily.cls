global class BatchClassSendingBODEmailReminderDaily Implements Database.Batchable<sObject> {
    
    
    global Database.QueryLocator start(Database.BatchableContext bc )
    { 
        String query;
        Date today = System.today();
        Date dateAfterTwoDay = today.addDays(2);
        
          // Query for calling record of employee who's birthday are coming in next 2 days
          
        query = 'Select id,FirstName,LastName ,Birthdate,email,Phone, Ownerid,Owner.Email  from contact  WHERE Birthdate = Today And email != null';
        system.debug('query.....'+query);
        // +   dateAfterTwoDay.day() +  ' AND CALENDAR_MONTH(Birthdate) = ' + dateAfterTwoDay.month();
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc,List<contact> conlist )
    {
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        // Calling cutom Email Trmplate for Sending 
        EmailTemplate emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where DeveloperName= 'Birthday_Email'];
        
        
        
        for (Contact con :conlist)
        {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId(con.Id);
            message.setSenderDisplayName('Paramount Team'); 
            message.setReplyTo('no-reply@company.com');
            message.setTemplateId(emailTemplates.Id);
            message.setUseSignature(false); 
            message.setBccSender(false); 
            message.setSaveAsActivity(false);
           
          //  message.toAddresses = ceoemail;// = new String2[]{'manoj@cccinfotech.com'};
            mailList.add(message);
            system.debug('message......'+message);
        }
        // Sending Email
        Messaging.sendEmail(mailList);
    }

    global void finish(Database.BatchableContext BC){}

}