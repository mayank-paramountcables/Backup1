public with sharing class CreateApplicationCtrl{
    
   /**
    * @author: Manoj Pandey
    * @description: This method Return Constitution type and DFA
    * @param:  
    * @return: string 
    */
    @AuraEnabled
    public static string getConstitutionAndDFA(string strRecordId)
    {
        WrappMain objWrap = new WrappMain();
        try{
            
            objWrap.success = true;
            objWrap.objApp = new Application_Form__c();
            objWrap.lstConstitution = new List<String>();
            objWrap.lstType = new List<String>();
            objWrap.lstTypeofBusinessPlace = new List<String>();
            objWrap.lstBusinessPlaceType = new List<String>();
            objWrap.lstProductType = new List<string>();
            
            objWrap.lstDFA = new List<DFA__c>();
             objWrap.lstDFABankAccount = new List<DFA__c>();
            objWrap.lstDFAGroupEntities = new List<DFA__c>();
            objWrap.lstDFAMainCustomers = new List<DFA__c>();
            objWrap.lstDFAMainDealers = new List<DFA__c>();
            objWrap.lstDFAOtherBusinessPlace = new List<DFA__c>();
            objWrap.lstDFAOtherProducts = new List<DFA__c>();
           
            String sObjName ='';
            if(strRecordId !=null && strRecordId !=''){
                Id recordId = strRecordId;
                sObjName = recordId.getSObjectType().getDescribe().getName();
                system.debug('sObjName...'+sObjName);
            }
            List<Application_Form__c> lstApplication = new List<Application_Form__c>();
            List<DFA__c> lstDFARecord = new List<DFA__c>();
            if(sObjName == 'Application_Form__c'){
                DescribeSObjectResult describeResult = Application_Form__c.getSObjectType().getDescribe();     
                List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
                String query =  ' SELECT ' + String.join( fieldNames, ',' ) + ' FROM Application_Form__c Where id =: strRecordId ';
                system.debug('...query...'+query);
                lstApplication = Database.query( query );
                string strDFARecordId;
                if(lstApplication != null && lstApplication.size() > 0){
                    objWrap.objApp = lstApplication[0]; 
                    strDFARecordId = objWrap.objApp.id;
                    system.debug('...strDFARecordId....'+strDFARecordId);
                    DescribeSObjectResult describeDFAResult = DFA__c.getSObjectType().getDescribe();     
                    List<String> fieldDFANames = new List<String>( describeDFAResult.fields.getMap().keySet() );
                    String queryDFA =  ' SELECT ' + String.join( fieldDFANames, ',' ) + ',RecordType.Name FROM DFA__c Where Application_Form__c =:strDFARecordId';
                    system.debug('...query...'+queryDFA);
                    lstDFARecord = Database.query( queryDFA );
                    if(lstDFARecord.size()>0){
                        for(DFA__c objDFA : lstDFARecord){
                            if(objDFA.RecordType.Name =='Particulars'){
                                objWrap.lstDFA.add(objDFA);
                            }
                            if(objDFA.RecordType.Name =='Bank Account'){
                                objWrap.lstDFABankAccount.add(objDFA);
                            }
                            if(objDFA.RecordType.Name =='Other Business Place'){
                                objWrap.lstDFAOtherBusinessPlace.add(objDFA);
                            }
                            if(objDFA.RecordType.Name =='Group Entities'){
                                objWrap.lstDFAGroupEntities.add(objDFA);
                            }
                            if(objDFA.RecordType.Name =='Products'){
                                objWrap.lstDFAOtherProducts.add(objDFA);
                            }
                            if(objDFA.RecordType.Name =='Main Dealers'){
                                objWrap.lstDFAMainDealers.add(objDFA);
                            }
                            if(objDFA.RecordType.Name =='Main Customers'){
                                objWrap.lstDFAMainCustomers.add(objDFA);
                            }
                        }
                    }
                    if(objWrap.lstDFA.size()== 0){
                        objWrap.lstDFA.add(new DFA__c());
                    }
                    if(objWrap.lstDFABankAccount.size()== 0){
                        objWrap.lstDFABankAccount.add(new DFA__c());
                    }
                    if(objWrap.lstDFAGroupEntities.size()== 0){
                        objWrap.lstDFAGroupEntities.add(new DFA__c());
                    }
                    if(objWrap.lstDFAMainCustomers.size()== 0){
                        objWrap.lstDFAMainCustomers.add(new DFA__c());
                    }
                    if(objWrap.lstDFAMainDealers.size()== 0){
                        objWrap.lstDFAMainDealers.add(new DFA__c());
                    }
                    if(objWrap.lstDFAOtherBusinessPlace.size()== 0){
                        objWrap.lstDFAOtherBusinessPlace.add(new DFA__c());
                    }
                    if(objWrap.lstDFAOtherProducts.size()== 0){
                        objWrap.lstDFAOtherProducts.add(new DFA__c());
                    }
                }
            }
            else{
                objWrap.lstDFA.add(new DFA__c());
                objWrap.lstDFABankAccount.add(new DFA__c());
                objWrap.lstDFAGroupEntities.add(new DFA__c());
                objWrap.lstDFAMainCustomers.add(new DFA__c());
                objWrap.lstDFAMainDealers.add(new DFA__c());
                objWrap.lstDFAOtherBusinessPlace.add(new DFA__c());
                objWrap.lstDFAOtherProducts.add(new DFA__c());
            }
            
            
            List<String> options = new List<String>();
            Schema.DescribeFieldResult fieldResult = Application_Form__c.Constitution__c.getDescribe();
            List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
            if(objWrap.objApp.Constitution__c ==null || objWrap.objApp.Constitution__c =='')
                options.add('--None--');
            
            for (Schema.PicklistEntry p: pList) {
                options.add(p.getLabel());
            }
            objWrap.lstConstitution =options;
             
            List<String> lstoptionsType = new List<String>();
            Schema.DescribeFieldResult fieldTypeResult = DFA__c.Type__c.getDescribe();
            List<Schema.PicklistEntry> ListType = fieldTypeResult.getPicklistValues();
            lstoptionsType.add('--None--');
            for (Schema.PicklistEntry p: ListType) {
                lstoptionsType.add(p.getLabel());
            }
            
            objWrap.lstType = lstoptionsType;
            
            
            List<String> lstoptionsTypeofBusinessPlace = new List<String>();
            Schema.DescribeFieldResult fieldTypeResultBP = DFA__c.Type_of_Business_Place__c.getDescribe();
            List<Schema.PicklistEntry> ListTypeofBP = fieldTypeResultBP.getPicklistValues();
            lstoptionsTypeofBusinessPlace.add('--None--');
            for (Schema.PicklistEntry p: ListTypeofBP) {
                lstoptionsTypeofBusinessPlace.add(p.getLabel());
            }
            
            objWrap.lstTypeofBusinessPlace = lstoptionsTypeofBusinessPlace;
            
            List<String> lstoptionsBusinessPlaceType = new List<String>();
            Schema.DescribeFieldResult fieldTypeResultBPT = DFA__c.Business_Place_Type__c.getDescribe();
            List<Schema.PicklistEntry> ListTypeofBPT = fieldTypeResultBPT.getPicklistValues();
            lstoptionsBusinessPlaceType.add('--None--');
            for (Schema.PicklistEntry p: ListTypeofBPT) {
                lstoptionsBusinessPlaceType.add(p.getLabel());
            }
            
            objWrap.lstBusinessPlaceType = lstoptionsBusinessPlaceType;
            
            
            List<String> lstoptionsProductType = new List<String>();
            Schema.DescribeFieldResult fieldTypeProductT = Application_Form__c.Expected_Products_to_be_Ordered__c.getDescribe();
            List<Schema.PicklistEntry> ListProductT = fieldTypeProductT.getPicklistValues();
            for (Schema.PicklistEntry p: ListProductT) {
                lstoptionsProductType.add(p.getLabel());
            }
            objWrap.lstProductType = lstoptionsProductType;
            system.debug('===='+objWrap.lstProductType);
            objWrap.success = true;
                        
        }catch(Exception e){
            objWrap.success = false;
            objWrap.errorMessage = e.getMessage();
        }
        return Json.serialize(objWrap);
    }
   
    /**
    * @author: Manoj Pandey
    * @description: This method Create record
    * @param: Id and Wrapper
    * @return: string 
    */
    @AuraEnabled
    public static string createApplicationRecord(string strRecordId, string strWrap, string strProductType)
    {
        WrappMain objWrap = new WrappMain();
        objWrap.success = true;
        try{
            if(strRecordId !=null && strRecordId !='' && strWrap !=null && strWrap !=''){
                List<DFA__c> lstDFA = new List<DFA__c>();
                objWrap =(WrappMain)Json.deserialize(strWrap, WrappMain.class);
                string strproduct ='';
                if(strProductType !=null && strProductType !=''){
                    list<string> lstString = (List<string>)JSON.deserialize(strProductType, List<string>.class);
                    for(string strvalue :lstString){
                        if(strproduct == null || strproduct =='')
                            strproduct = strvalue;
                        
                        else
                            strproduct = strproduct+';'+strvalue;
                    }
                }
                string sObjName ='';
                Id recordId = strRecordId;
                sObjName = recordId.getSObjectType().getDescribe().getName();
               
               Application_Form__c objApp = new Application_Form__c();
                if(sObjName =='Leads__c'){
                    objApp = objWrap.objApp;
                    objApp.Name_of_Entity__c = strRecordId;
                    if(strproduct !=null && strproduct !=''){
                        objApp.Expected_Products_to_be_Ordered__c = strproduct;
                    }
                    Insert objApp;
                    objWrap.strAppId = objApp.Id;
                }
                if(sObjName == 'Application_Form__c'){
                    objApp = objWrap.objApp;
                    if(strproduct !=null && strproduct !=''){
                        objApp.Expected_Products_to_be_Ordered__c = strproduct;
                    }
                    update objApp;
                    objWrap.strAppId = objApp.Id;
                }
                for(DFA__c objDFA : objWrap.lstDFA){
                    if(objDFA.Name_Father_Name_Address__c !='' && objDFA.Name_Father_Name_Address__c !=null && objDFA.Type__c !='--None--' && objDFA.Type__c !=null && objDFA.Pan_No__c !=null && objDFA.Pan_No__c !='' && objDFA.Aadhar_No__c !='' && objDFA.Aadhar_No__c !=null){
                        DFA__c objD = new DFA__c();
                        objD = objDFA;
                        objD.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Particulars').getRecordTypeId();
                        if(objDFA.Application_Form__c ==null)
                            objD.Application_Form__c = objApp.id;
                        
                        lstDFA.add(objD);
                    }
                }
                
                for(DFA__c objDFA : objWrap.lstDFABankAccount){
                    if(objDFA.Bank_Name_Branch__c !='' && objDFA.Bank_Name_Branch__c !=null && objDFA.Account_No__c !='' && objDFA.Account_No__c !=null && objDFA.Account_Type__c !=null && objDFA.Account_Type__c !='' && objDFA.IFSC_Code__c  !='' && objDFA.IFSC_Code__c !=null){
                        DFA__c objDFABA = new DFA__c();
                        objDFABA = objDFA;
                        objDFABA.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Bank Account').getRecordTypeId();
                        if(objDFA.Application_Form__c ==null)
                            objDFABA.Application_Form__c = objApp.id;
                        
                        lstDFA.add(objDFABA);
                    }
                }
                
                for(DFA__c objDFABP : objWrap.lstDFAOtherBusinessPlace){
                    if(objDFABP.Type_of_Business_Place__c !='--None--' && objDFABP.Type_of_Business_Place__c !=null && objDFABP.Address__c !='' && objDFABP.Address__c !=null && objDFABP.Year_of_Estl__c !=null && objDFABP.Year_of_Estl__c !='' && objDFABP.Business_Place_Type__c  !='--None--' && objDFABP.Business_Place_Type__c !=null){
                        DFA__c objDFBP = new DFA__c();
                        objDFBP = objDFABP;
                        objDFBP.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Other Business Place').getRecordTypeId();
                        if(objDFABP.Application_Form__c ==null)
                            objDFBP.Application_Form__c = objApp.id;
                        
                        lstDFA.add(objDFBP);
                    }
                }
                
                for(DFA__c objDFABP : objWrap.lstDFAGroupEntities){
                    if(objDFABP.Name_Group_Entities__c !='' && objDFABP.Name_Group_Entities__c !=null && objDFABP.Nature_of_Business__c !='' && objDFABP.Nature_of_Business__c !=null && objDFABP.Relation__c !=null && objDFABP.Relation__c !='' && objDFABP.Turnover_lacks__c !=null){
                        DFA__c objDFABPE = new DFA__c();
                        objDFABPE = objDFABP;
                        objDFABPE.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Group Entities').getRecordTypeId();
                        if(objDFABP.Application_Form__c ==null)
                            objDFABPE.Application_Form__c = objApp.id;
                        
                        lstDFA.add(objDFABPE);
                    }
                }
                
                for(DFA__c objDFABP : objWrap.lstDFAOtherProducts){
                    if(objDFABP.Company_Brand__c !='' && objDFABP.Company_Brand__c !=null && objDFABP.Product__c !='' && objDFABP.Product__c !=null && objDFABP.Experience_Years__c !=null && objDFABP.Experience_Years__c !='' && objDFABP.Turnover_lacks__c !=null){
                        DFA__c objDFAOP = new DFA__c();
                        objDFAOP = objDFABP;
                        objDFAOP.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Products').getRecordTypeId();
                        if(objDFABP.Application_Form__c ==null)
                            objDFAOP.Application_Form__c = objApp.id;
                        
                        lstDFA.add(objDFAOP);
                    }
                }
                
                for(DFA__c objDFABP : objWrap.lstDFAMainDealers){
                    if(objDFABP.Name_of_Dealer__c !='' && objDFABP.Name_of_Dealer__c !=null && objDFABP.Product__c !='' && objDFABP.Product__c !=null && objDFABP.Location__c !=null && objDFABP.Location__c !='' && objDFABP.Sale_to_Dealer_Lacs__c !=null){
                        DFA__c objDFAMD = new DFA__c();
                        objDFAMD = objDFABP;
                        objDFAMD.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Main Dealers').getRecordTypeId();
                        if(objDFABP.Application_Form__c ==null)
                            objDFAMD.Application_Form__c = objApp.id;
                    
                        lstDFA.add(objDFAMD);
                    }
                }
                
                system.debug(objWrap.lstDFAMainCustomers.size()+'....objWrap.lstDFAMainCustomers'+objWrap.lstDFAMainCustomers);
                for(DFA__c objDFABP : objWrap.lstDFAMainCustomers){
                    system.debug(objDFABP.Name_Main_Customers__c+'..objDFABP.Name_Main_Customers__c...'+objDFABP.Nature_of_Business__c+'...objDFABP.Product__c..'+objDFABP.Product__c+'..objDFABP.Sale_to_Customer_lacs__c..'+objDFABP.Sale_to_Customer_lacs__c);
                    if(objDFABP.Name_Main_Customers__c !='' && objDFABP.Name_Main_Customers__c !=null && objDFABP.Nature_of_Business__c !='' && objDFABP.Nature_of_Business__c !=null && objDFABP.Product__c !='' && objDFABP.Product__c !=null && objDFABP.Sale_to_Customer_lacs__c !=null){
                        DFA__c objDFAMC = new DFA__c();
                        objDFAMC = objDFABP;
                        objDFAMC.RecordTypeId = Schema.SObjectType.DFA__c.getRecordTypeInfosByName().get('Main Customers').getRecordTypeId();
                        if(objDFABP.Application_Form__c ==null)
                            objDFAMC.Application_Form__c = objApp.id;
                        
                        lstDFA.add(objDFAMC);
                    }
                }
                
                if(lstDFA.size()>0){
                    upsert lstDFA;
                }
            }
        }
        catch(DmlException DML) {
            objWrap.success = false;
            objWrap.errorMessage = DML.getDmlMessage(0);
        }
        catch(Exception e){
            objWrap.success = false;
            objWrap.errorMessage = e.getMessage();
        }
        return Json.serialize(objWrap);
    }
    Public class WrappMain{
        public boolean success;
        public string errorMessage;
        public string SuccessMessage;
        public string strAppId;
        public Application_Form__c objApp;
        public List<String> lstConstitution;
        public List<String> lstType;
        public List<string> lstTypeofBusinessPlace;
        public List<string> lstBusinessPlaceType;
        public List<string> lstProductType;
        public list<DFA__c>lstDFA;
        public list<DFA__c>lstDFABankAccount;
        public list<DFA__c>lstDFAGroupEntities;
        public list<DFA__c>lstDFAMainCustomers;
        public list<DFA__c>lstDFAMainDealers;
        public list<DFA__c>lstDFAOtherBusinessPlace;
        public list<DFA__c>lstDFAOtherProducts;
    }
}