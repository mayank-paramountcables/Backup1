@istest
public class CreateApplicationCtrltest {
    /*@istest
    public static void Testmethod1()
    { 
        Leads__c objLead = new Leads__c();
        objLead.First_Name__c= 'Test First Name';
        objLead.Last_Name__c= 'Test Last Name';
        insert objLead;
        
        Application_Form__c objApp =new Application_Form__c();
        objApp.Contact_Person_Last_Name__c = 'Contact Person Last Name';
        objApp.Name_of_Entity__c =objLead.id;
        insert objApp;
        
        list<DFA__c> lstDFA = new list<DFA__c>();
        DFA__c objDFA = new DFA__c();
        objDFA.Application_Form__c = objApp.id;
        lstDFA.add(objDFA);
        insert lstDFA;
        
        CreateApplicationCtrl.WrappMain objwrap = new CreateApplicationCtrl.WrappMain();
        objwrap.errorMessage ='';
        String strwrapobj  = json.serialize(objwrap);
        CreateApplicationCtrl.getConstitutionAndDFA(objApp.Id);
        CreateApplicationCtrl.createApplicationRecord(objLead.Id, strwrapobj, 'objLead.Id');
    }
    @istest
    public static void Testmethod2()
    { 
        Leads__c objLead = new Leads__c();
        objLead.First_Name__c= 'Test First Name';
        objLead.Last_Name__c= 'Test Last Name';
        insert objLead;
        
        Application_Form__c objApp =new Application_Form__c();
        objApp.Contact_Person_Last_Name__c = 'Contact Person Last Name';
        objApp.Name_of_Entity__c =objLead.id;
        insert objApp;
        
        list<DFA__c> lstDFA = new list<DFA__c>();
        DFA__c objDFA = new DFA__c();
        objDFA.Application_Form__c = objApp.id;
        lstDFA.add(objDFA);
        insert lstDFA;
        
        CreateApplicationCtrl.WrappMain objwrap = new CreateApplicationCtrl.WrappMain();
        objwrap.errorMessage ='';
        String strwrapobj  = json.serialize(objwrap);
        CreateApplicationCtrl.getConstitutionAndDFA(null);
        CreateApplicationCtrl.createApplicationRecord(objLead.Id, strwrapobj, '');
    }
    @istest
    public static void Testmethod3()
    { 
        Leads__c objLead = new Leads__c();
        objLead.First_Name__c= 'Test First Name';
        objLead.Last_Name__c= 'Test Last Name';
        insert objLead;
        
        Application_Form__c objApp =new Application_Form__c();
        objApp.Contact_Person_Last_Name__c = 'Contact Person Last Name';
        objApp.Name_of_Entity__c =objLead.id;
        insert objApp;
        
        list<DFA__c> lstDFA = new list<DFA__c>();
        DFA__c objDFA = new DFA__c();
        objDFA.Application_Form__c = objApp.id;
        lstDFA.add(objDFA);
        insert lstDFA;
        
        CreateApplicationCtrl.WrappMain objwrap = new CreateApplicationCtrl.WrappMain();
        objwrap.errorMessage ='';
        String strwrapobj  = json.serialize(objwrap);
        CreateApplicationCtrl.getConstitutionAndDFA(null);
        CreateApplicationCtrl.createApplicationRecord(objLead.Id, strwrapobj, objApp.Id);
    }*/
     @istest
    public static void Testmethod3()
    { 
        Leads__c objLead = new Leads__c();
        objLead.First_Name__c= 'Test First Name';
        objLead.Last_Name__c= 'Test Last Name';
        insert objLead;
        
        list<Application_Form__c> lstStr = new list<Application_Form__c>();
        Application_Form__c objApp =new Application_Form__c();
        objApp.Contact_Person_Last_Name__c = 'Contact Person Last Name';
        objApp.Name_of_Entity__c =objLead.id;
        objApp.Expected_Products_to_be_Ordered__c = '90 Mtr Box';
        lstStr.add(objApp);
        insert lstStr;
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'DFA__c' and Name = 'Products'].Id;
        list<DFA__c> lstDFA = new list<DFA__c>();
        DFA__c objDFA = new DFA__c();
        objDFA.RecordTypeId = strRecordTypeId;
        objDFA.Application_Form__c = objApp.id;
        lstDFA.add(objDFA);
        insert lstDFA;
        List<string> lstProduct = new List<string>();
        lstProduct.add('90 Mtr Box');
        lstProduct.add('FRLS');
        //string strWrap = CreateApplicationCtrl.getConstitutionAndDFA(objLead.Id);
        //String strwrapobj  = json.serialize(strWrap);
        //CreateApplicationCtrl.createApplicationRecord(objLead.Id, strwrapobj, '90 Mtr Box;FRLS');
        
        CreateApplicationCtrl.WrappMain objwrap = new CreateApplicationCtrl.WrappMain();
        objwrap.errorMessage ='';
        objwrap.objApp =objApp;
        objwrap.lstDFA = lstDFA;
        String strwrapobj  = json.serialize(objwrap);
        CreateApplicationCtrl.getConstitutionAndDFA(objApp.Id);
        //CreateApplicationCtrl.createApplicationRecord(objApp.id, strwrapobj, null);
    }
    
    @istest
    public static void Testmethod4()
    { 
        Leads__c objLead = new Leads__c();
        objLead.First_Name__c= 'Test First Name';
        objLead.Last_Name__c= 'Test Last Name';
        insert objLead;
        
        list<Application_Form__c> lstStr = new list<Application_Form__c>();
        Application_Form__c objApp =new Application_Form__c();
        objApp.Contact_Person_Last_Name__c = 'Contact Person Last Name';
        objApp.Name_of_Entity__c =objLead.id;
        objApp.Expected_Products_to_be_Ordered__c = 'FRLS';
        lstStr.add(objApp);
        insert lstStr;
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'DFA__c' and Name = 'Products'].Id;
        list<DFA__c> lstDFA = new list<DFA__c>();
        DFA__c objDFA = new DFA__c();
        objDFA.RecordTypeId = strRecordTypeId;
        objDFA.Application_Form__c = objApp.id;
        objDFA.Name_Father_Name_Address__c = 'Test';
        objDFA.Type__c = 'Partner';
        objDFA.Pan_No__c ='89790DK8';
        objDFA.Aadhar_No__c ='8797990080';
        objDFA.Bank_Name_Branch__c ='Test';
        objDFA.Account_No__c ='8976533568';
        objDFA.Account_Type__c ='Test';
        objDFA.IFSC_Code__c ='ACB123';
        objDFA.Type_of_Business_Place__c ='Godown';
        objDFA.Address__c ='Test';
        objDFA.Year_of_Estl__c ='3';
        objDFA.Business_Place_Type__c ='Owned';
        objDFA.Name_Group_Entities__c ='Test';
        objDFA.Nature_of_Business__c  ='Test';
        objDFA.Relation__c ='Test';
        objDFA.Turnover_lacks__c = 5;
        objDFA.Company_Brand__c ='Test';
        objDFA.Product__c ='product Name';
        objDFA.Experience_Years__c ='4';
        objDFA.Name_of_Dealer__c= 'Dealer Name';
        objDFA.Location__c ='Location';
        objDFA.Sale_to_Dealer_Lacs__c = 56;
        objDFA.Name_Main_Customers__c ='Customers Name';
        objDFA.Nature_of_Business__c ='Business';
        objDFA.Sale_to_Customer_lacs__c = 50;
        lstDFA.add(objDFA);
        insert lstDFA;
        List<string> lstProduct = new List<string>();
        lstProduct.add('90 Mtr Box');
        lstProduct.add('FRLS');
        //string strWrap = CreateApplicationCtrl.getConstitutionAndDFA(objLead.Id);
        //String strwrapobj  = json.serialize(strWrap);
        //CreateApplicationCtrl.createApplicationRecord(objLead.Id, strwrapobj, '90 Mtr Box;FRLS');
        
        CreateApplicationCtrl.WrappMain objwrap = new CreateApplicationCtrl.WrappMain();
        objwrap.errorMessage ='';
        objwrap.objApp =objApp;
        objwrap.lstDFA = lstDFA;
        objwrap.lstDFABankAccount =lstDFA;
        objwrap.lstDFAOtherBusinessPlace =lstDFA;
        objwrap.lstDFAGroupEntities =lstDFA;
        
        objwrap.lstDFAOtherProducts =lstDFA;
        objwrap.lstDFAMainDealers =lstDFA;
        objwrap.lstDFAMainCustomers =lstDFA;
        
        String strwrapobj  = json.serialize(objwrap);
        CreateApplicationCtrl.getConstitutionAndDFA(objLead.Id);
        CreateApplicationCtrl.createApplicationRecord(objApp.id, strwrapobj, null);
    }
}