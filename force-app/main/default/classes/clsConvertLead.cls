public class clsConvertLead
{ 
    @AuraEnabled
    public static mainWrapper wrapmain {get;set;}
    
    @AuraEnabled
    public static string convertLead(string strRecordid)
    {
        Savepoint sp = Database.setSavepoint();
        try{
            system.debug('strRecordid....'+strRecordid);
            wrapmain = new mainWrapper();
            wrapmain.recordTypeName = '';
            
            SObjectType schemaType = Schema.getGlobalDescribe().get('Leads__c');
            Map<String, SObjectField> fields = schemaType.getDescribe().fields.getMap();
            
            List<String> accessableFields = new List<String>();
            for (String field : fields.keySet())
                if(fields.get(field).getDescribe().isAccessible() && fields.get(field).getDescribe().isUpdateable() && fields.get(field).getDescribe().isCreateable()) {
                    accessableFields.add(field.trim());                 
                }
            
            String query = ' SELECT ' + String.join( accessableFields, ',') +',(select Id,Name from Accounts__r), RecordType.DeveloperName,RecordType.Name'+' '+ 'FROM Leads__c Where id =: strRecordid limit 1';   
            System.debug('@@query!!!!'+query);
            wrapmain.objlead = Database.query(query);
            if(wrapmain.objlead.RecordType.DeveloperName != null && wrapmain.objlead.RecordType.DeveloperName != '')
            {
                wrapmain.recordTypeName = wrapmain.objlead.RecordType.DeveloperName;
                system.debug('recordTypeName.....'+wrapmain.recordTypeName);
            }
            Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(wrapmain.recordTypeName).getRecordTypeId();
            if(wrapmain.objlead!= null)
            {
                if(wrapmain.objlead.Accounts__r.size()>0)
                {
                    if(wrapmain.objlead.Accounts__r[0] != null && wrapmain.objlead.Accounts__r[0].Name != null && wrapmain.objlead.Accounts__r[0].Name != '' && wrapmain.objlead.Accounts__r[0].Id != null)
                    {
                        wrapmain.objAcc = wrapmain.objlead.Accounts__r[0];
                        system.debug('...wrapmain.objAcc.Id...'+wrapmain.objAcc.Id);
                        list<Contact> lstCon = new list<Contact>();
                        lstCon = [Select Id, Name,FirstName,LastName, AccountId from Contact where AccountId =: wrapmain.objAcc.Id];
                        if(lstCon.size()>0)
                        {
                            wrapmain.objCon = lstCon[0];
                        }
                        wrapmain.errorMSG = system.Label.Lead_Converted_Error;
                    }
                }
                else if(wrapmain.objlead.Approval_Status__c == 'Approved' || wrapmain.objlead.RecordType.Name =='Retailer')
                {
                    Account objAcc = new Account();
                    objAcc.Name = wrapmain.objlead.Name;
                    objAcc.RecordTypeId = devRecordTypeId;
                    objAcc.BillingStreet = wrapmain.objlead.Street__c;
                    objAcc.BillingCity = wrapmain.objlead.City__c;
                    objAcc.BillingState = wrapmain.objlead.State__c;
                    objAcc.BillingPostalCode = wrapmain.objlead.Postal_Code__c;
                    objAcc.BillingCountry = wrapmain.objlead.Country__c;
                    objAcc.Distributor_Dealer__c = wrapmain.objlead.Distributor_Dealer__c;
                    objAcc.Lead__c = wrapmain.objlead.Id; 
                    insert objAcc;
                    
                    Contact objCon = new Contact();
                    objCon.FirstName = wrapmain.objlead.First_Name__c;
                    objCon.LastName = wrapmain.objlead.Last_Name__c;
                    objCon.Email = wrapmain.objlead.Email__c;
                    objCon.MobilePhone = wrapmain.objlead.Contact_Number__c;
                    objCon.AccountId = objAcc.Id;
                    objCon.Birthdate = wrapmain.objlead.Date_of_Birth__c;
                    objCon.Type__c = 'Customer';
                    
                    objCon.MailingStreet = wrapmain.objlead.Street__c;
                    objCon.MailingCity = wrapmain.objlead.City__c;
                    objCon.MailingState = wrapmain.objlead.State__c;
                    objCon.MailingCountry = wrapmain.objlead.Country__c;
                    objCon.MailingPostalCode = wrapmain.objlead.Postal_Code__c;
                    //objCon.Contact_Address__c = wrapmain.objlead.Street__c +' '+wrapmain.objlead.City__c+' '+wrapmain.objlead.State__c+' '+wrapmain.objlead.Country__c+' '+wrapmain.objlead.Postal_Code__c;
                    if(wrapmain.objlead.Last_Name__c != null && wrapmain.objlead.Last_Name__c != '')
                        insert objCon;
                    
                    wrapmain.objCon = objCon;
                    wrapmain.objAcc = objAcc;
                    
                    system.debug('....wrapmain.objlead..'+wrapmain.objlead.OwnerId+'...'+UserInfo.getUserId());
                    if(wrapmain.objlead.OwnerId != UserInfo.getUserId())
                    {
                         AccountShare objaccShare = new AccountShare();
                         objaccShare.AccountAccessLevel = 'edit';
                         objaccShare.OpportunityAccessLevel = 'None';
                         objaccShare.AccountId= wrapmain.objAcc.Id;
                         if(wrapmain.objlead.OwnerId != null)
                            objaccShare.UserOrGroupId = wrapmain.objlead.OwnerId;
                        objaccShare.RowCause = Schema.AccountShare.RowCause.Manual;
                        system.debug('...objaccShare..'+objaccShare);
                        insert objaccShare;
                    }
                    
                    wrapmain.objlead.Is_Converted__c = true;
                    update wrapmain.objlead;
                    wrapmain.successMSG = system.label.Successfully_Converted_Lead;
                }
                else
                {
                    wrapmain.errorMSG = system.label.Lead_Status_Check;
                }
            }
        }
       
         catch(Exception ex){
             Database.RollBack(sp);
            wrapmain.errorMSG = ex.getMessage();
        }
        system.debug('wrapmain---'+wrapmain);    
        return Json.serialize(wrapmain); 
    }
    
    public class mainWrapper
    { 
        public Leads__c objlead {get;set;}
        public string errorMSG {get;set;}
        public string successMSG {get;set;}
        public Account objAcc {get;set;}
        public Contact objCon {get;set;}
        public string recordTypeName;
        
    }
    
}