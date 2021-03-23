public class MeetingEventTriggerHandler{
    public static void onAfterUpdate(list<Meeting_Event__c>TriggerNew, Map<Id,Meeting_Event__c> triggeroldMap){
        onAfterUpdateMeetingEvent(triggerNew,triggeroldMap);
    }
    static void onAfterUpdateMeetingEvent(list<Meeting_Event__c>TriggerNew, Map<Id,Meeting_Event__c> triggeroldMap){
        map<id,Decimal> mapEventDetails = new map<Id,Decimal>();
        set<Id> SetOfAccountId = new set<Id>();
        set<Id> SetOfMeetingEventId = new set<Id>();
        //map<id,Decimal> mapEventQuantities = new map<id,Decimal>();
        //map<Id,Returned_Gift_Items__c> mapReturnGiftItems = new map<Id,Returned_Gift_Items__c>();
        for(Meeting_Event__c objME:TriggerNew){
            Id ElectricianRecordTypeId = Schema.SObjectType.Meeting_Event__c.getRecordTypeInfosByName().get('Electrician').getRecordTypeId();
            /*if(objME.Approval_Status__c =='Approved' && triggeroldMap.get(objME.Id).Approval_Status__c != objME.Approval_Status__c && objME.RecordTypeId == ElectricianRecordTypeId){
                if(mapEventQuantities.containskey(objME.Retailer_Distributor__c)){
                    Decimal Quantities = mapEventQuantities.get(objME.Retailer_Distributor__c);
                            
                    mapEventQuantities.put(objME.Retailer_Distributor__c,objME.Total_Quantities__c+Quantities);
                }else{
                    mapEventQuantities.put(objME.Retailer_Distributor__c,objME.Total_Quantities__c);
                }
            }*/
            if(objME.Event_Status__c =='Completed' && triggeroldMap.get(objME.Id).Event_Status__c != objME.Event_Status__c){
                SetOfMeetingEventId.add(objME.id);
            }
            
        }
        
        /*if(mapEventQuantities.size()>0){
            for(Account objAcc :[Select Id,Name,OwnerId from Account where Id IN :mapEventQuantities.Keyset()]){
                Decimal TotalQuantities =  mapEventQuantities.get(objAcc.Id);
                mapEventDetails.put(objAcc.OwnerId,TotalQuantities);
            }
            for(Returned_Gift_Items__c objRGI :[Select Id,Available_Quantities__c,Returned_Quantities__c,Sales_Rep__c from Returned_Gift_Items__c where Sales_Rep__c IN: mapEventDetails.keySet()]){
                objRGI.Available_Quantities__c = objRGI.Available_Quantities__c+mapEventDetails.get(objRGI.Sales_Rep__c);
                mapReturnGiftItems.put(objRGI.Sales_Rep__c,objRGI);
            }
            for(id objId :mapEventDetails.keyset()){
                if(!mapReturnGiftItems.containsKey(objId)){
                    Returned_Gift_Items__c objRI = new Returned_Gift_Items__c();
                    objRI.Sales_Rep__c = objId;
                    objRI.Available_Quantities__c = mapEventDetails.get(objId);
                    mapReturnGiftItems.put(objRI.Sales_Rep__c,objRI);
                }
            }
            if(mapReturnGiftItems.size()>0){
                Upsert mapReturnGiftItems.values();
            }
        }*/
        if(SetOfMeetingEventId.size()>0){
            string strRecordId = string.valueof(SetOfMeetingEventId);
            MeetingEventTriggerHandler.generatePdf(strRecordId);
        }
        
    }
    
    @future(callout = true)
    public static void generatePdf(string strRecordId) 
    {
        strRecordId = strRecordId.replace('{','');
        strRecordId = strRecordId.replace('}','');
        system.debug('strRecordId....!!!'+strRecordId);
        
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        // Calling cutom Email Trmplate for Sending 
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where DeveloperName= 'Send_Event_Report_to_CEO'];
        system.debug('emailTemplate.....'+emailTemplate.HtmlValue);
        DateTime cdt = DateTime.now();
        String monthName = cdt.format('MMMMM');
        string htmlBd = emailTemplate.HtmlValue;
        for(Meeting_Event__c objME : [Select Id,Name,Start_Datetime__c,Distributor__c,Retailer_Distributor__r.Name,No_of_Electricians_to_be_attended__c,Last_meet_with_this_retailer__c,Amount_required_for_meet__c,Actual_Amount_Spent__c,Address__c from Meeting_Event__c where Id = : strRecordId]){
            if(objME.Name !=null && objME.Name !=''){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Name}',objME.Name);
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Name}','');
            }
            
            if(objME.Start_Datetime__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Start_Datetime__c}',String.valueOfGmt(objME.Start_Datetime__c));
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Start_Datetime__c}','');
            }
            
            
            if(objME.Retailer_Distributor__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Retailer_Distributor__c}',objME.Retailer_Distributor__r.Name);
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Retailer_Distributor__c}','');
            }
            
            if(objME.Distributor__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Distributor__c}',objME.Distributor__c);
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Distributor__c}','');
            }
            
            
            if(objME.No_of_Electricians_to_be_attended__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.No_of_Electricians_to_be_attended__c}',String.valueof(objME.No_of_Electricians_to_be_attended__c));
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.No_of_Electricians_to_be_attended__c}','');
            }
            
            if(objME.Last_meet_with_this_retailer__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Last_meet_with_this_retailer__c}',String.valueOfGmt(objME.Last_meet_with_this_retailer__c));
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Last_meet_with_this_retailer__c}','');
            }
            
            
            if(objME.Amount_required_for_meet__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Amount_required_for_meet__c}',string.valueof(objME.Amount_required_for_meet__c));
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Amount_required_for_meet__c}','');
            }
            
            if(objME.Actual_Amount_Spent__c !=null){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Actual_Amount_Spent__c}',string.valueof(objME.Actual_Amount_Spent__c));
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Actual_Amount_Spent__c}','');
            }
            
            if(objME.Address__c !=null && objME.Address__c !=''){
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Address__c}',objME.Address__c);
            }else{
                htmlBd = htmlBd.replace('{!Meeting_Event__c.Address__c}','');
            }
                  
        /*string htmlBody = '<table style="border: 1px solid black; width:100%;"><tr style="text-align:left;"><th style="border-right: 1px solid black;">Electrician Name </th><th style="border-right: 1px solid black;">Electrician Contact No</th><th">Electrician Address</th><th style="border-right: 1px solid black; ">Date of Birth</th></tr>';
    
    
        for (Meeting_Attendees__c objMA :[Select Id,Name,Contact__r.Name,Contact_Address__c,Contact_Number__c,Date_Of_Birth__c from Meeting_Attendees__c where Meeting_Event__c = :strRecordId]) 
        {
            
            if(objMA.Contact__r.Name != null)
            {
                Date d = objMA.Date_Of_Birth__c;
                date dt = date.newInstance(d.year(),d.month(),d.day());
                htmlBody = htmlBody+'<tr style="text-align: left;"><td style="border-right:1px solid black;border-top: 1px solid black;">'+objMA.Contact__r.Name+'</td>'+'<td style="border-right:1px solid black;border-top: 1px solid black;">'+objMA.Contact_Number__c+'</td>'+'<td style="border-right:1px solid black;border-top: 1px solid black;">'+objMA.Contact_Address__c+'</td>'+'<td style="border-top: 1px solid black;">'+d.day()+'/'+d.month()+'/'+d.year()+'</td></tr>';
                htmlBody = htmlBody.replace('null','');
            }
            
        }*/
            
        //htmlBd = htmlBd.replace('#Htmlbody',htmlBody);
        //get VF page report pdf
            blob bodyss;
            if(Test.isRunningTest()){
                bodyss = Blob.valueof('Test is done');  
            }
            else
            {
                
                PageReference pdf = Page.EventInformation;
                pdf.getParameters().put('id',strRecordId);
                // bodyss = pdf.getContentaspdf(); 
                bodyss = pdf.getContent(); 
            }
            List<Messaging.EmailFileAttachment> email_attachments = new List<Messaging.EmailFileAttachment>();  
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(objME.Name+'.pdf');
            efa.setBody(bodyss);
            email_attachments.add(efa);
            
            
            List<string> Toemail = new List<string>();
            string strToadd = System.Label.CEO_Email_Id;
            system.debug('..strToadd..'+strToadd);
            Toemail.add(strToadd);
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setSenderDisplayName('Paramount Team'); 
            message.setReplyTo('no-reply@company.com');
            message.setUseSignature(false); 
            message.setBccSender(false); 
            message.setSaveAsActivity(false);
            message.setSubject(emailTemplate.Subject);
            //htmlBody = htmlBody+'</table>';
            //htmlBd = htmlBd.replace('#Htmlbody',htmlBody);
            message.setHtmlBody(htmlBd);
            message.toAddresses = Toemail;
            message.setFileAttachments(email_attachments);
            mailList.add(message);
            system.debug('message......'+message);
           
        }   
        if(mailList.size()>0){
             Messaging.sendEmail(mailList);
        }
    }
}