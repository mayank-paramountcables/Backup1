@istest
public class ViewApplicationCtrlTest {
	@istest
     public static void Testmethod1()
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
        objDFA.Application_Form__c = lstStr[0].id;
        objDFA.Type_of_Business_Place__c = 'Godown';
        objDFA.Address__c = 'Address';
         objDFA.Year_of_Estl__c = '2002';
         objDFA.Business_Place_Type__c = 'Rented';
        lstDFA.add(objDFA);
        insert lstDFA;
        
        list<string> producttype = new list<string>();
        producttype.add('90 Mtr Box');
        string strWarapMain = ViewApplicationCtrl.getConstitutionAndDFA(lstStr[0].id);
        
        ViewApplicationCtrl.createApplicationRecord(lstStr[0].id,strWarapMain,JSON.serialize(producttype));
        ViewApplicationCtrl.createApplicationRecord(lstStr[0].id,strWarapMain,JSON.serialize(producttype));
        ViewApplicationCtrl.WrappMain objwrap = new ViewApplicationCtrl.WrappMain();
       
        string strWarapMains = ViewApplicationCtrl.getConstitutionAndDFA(objLead.id);
       	objwrap=(ViewApplicationCtrl.WrappMain)Json.deserialize(strWarapMains, ViewApplicationCtrl.WrappMain.class);
        objwrap.lstDFAOtherBusinessPlace = lstDFA;
        ViewApplicationCtrl.createApplicationRecord(objLead.id,JSON.serialize(objwrap),JSON.serialize(producttype));
        
    } 
}