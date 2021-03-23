global class BatchClassSendingBODEmailReminder Implements Database.Batchable<sObject> {
    
    
    global Database.QueryLocator start(Database.BatchableContext bc )
    { 
        String query;
        Date today = System.today();
        Date dateAfterTwoDay = today.addDays(2);
        System.debug('date---  '+dateAfterTwoDay);
        
          // Query for calling record of employee who's birthday are coming in next 2 days
          
        query = 'Select id,FirstName,LastName ,Birthdate,email,Phone, Ownerid,Owner.Email  from contact  WHERE DAY_IN_MONTH(Birthdate) = ' + 
                      dateAfterTwoDay.day() +  ' AND CALENDAR_MONTH(Birthdate) = ' + dateAfterTwoDay.month();

        System.debug('query---  '+query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc,List<contact> conlist )
    {
         System.debug('conlist---  '+conlist);
        // Select Ceo Email And store it in list
        List<user> uslist =  [SELECT Id, email,Userrole.Name FROM user WHERE Userrole.Name = 'CEO'];
        List<string> ceoemail = new List<string>();
        
        if(uslist != Null)
        {
             for(user us :uslist)
             {
                ceoemail.add(us.email);
             }  
        }
        
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        // Calling cutom Email Trmplate for Sending 
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where DeveloperName= 'List_of_Birthday_notification_to_CEO'];
        system.debug('emailTemplate.....'+emailTemplate.HtmlValue);
        DateTime cdt = DateTime.now();
        String monthName = cdt.format('MMMMM');
        string htmlBd = emailTemplate.HtmlValue;
        string htmlBody = '<h2>Upcoming Birthday List</h2></br><h3>'+'Month:-'+monthName+'</h3><table style="border: 1px solid black; width:100%;"><tr style="text-align:left;"><th style="border-right: 1px solid black;">Customer Name</th><th style="border-right: 1px solid black;">Date of Birth</th><th style="border-right: 1px solid black;">Email</th><th style="border-right: 1px solid black; ">Mobile</th><th">Record Link</th></tr>';
        
        
        for (Contact con :conlist) 
        {
            
            string fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' +con.Id;
            system.debug('fullRecordURL......'+fullRecordURL);
            if(con.Birthdate != null && ((con.FirstName != null & con.FirstName != '') || (con.LastName != null && con.LastName != '') || (con.Email != null && con.Email != '') || (con.Phone != null && con.Phone != '')))
            {
               Date d = con.Birthdate;
                date dt = date.newInstance(d.year(),d.month(),d.day());
                htmlBody = htmlBody+'<tr style="text-align: left;"><td style="border-right:1px solid black;border-top: 1px solid black;">'+con.FirstName+' '+con.LastName+'</td>'+'<td style="border-right:1px solid black;border-top: 1px solid black;">'+d.day()+'/'+d.month()+'/'+d.year()+'</td>'+'<td style="border-right:1px solid black;border-top: 1px solid black;">'+con.Email+'</td>'+'<td style="border-right:1px solid black;border-top: 1px solid black;">'+con.Phone+'</td>'+'<td style="border-top: 1px solid black;">'+'<a href='+fullRecordURL+'>'+'Click here!'+'</a>'+'</td></tr>';
                htmlBody = htmlBody.replace('null','');
            }
            
        }
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        //  message.setTargetObjectId(ceoID);
            message.setSenderDisplayName('Paramount Team'); 
            message.setReplyTo('no-reply@company.com');
            message.setUseSignature(false); 
            message.setBccSender(false); 
            message.setSaveAsActivity(false);
            message.setSubject(emailTemplate.Subject);
            htmlBody = htmlBody+'</table>';
            htmlBd = htmlBd.replace('#Htmlbody',htmlBody);
            message.setHtmlBody(htmlBd);
            message.toAddresses = ceoemail;// = new String2[]{'manoj@cccinfotech.com'};
            mailList.add(message);
            system.debug('message......'+message);
            
        // Sending Email
        Messaging.sendEmail(mailList);
    }

    global void finish(Database.BatchableContext BC){}

}