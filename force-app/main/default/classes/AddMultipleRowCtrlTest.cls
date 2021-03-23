@istest
public class AddMultipleRowCtrlTest {
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
        objDFA.Application_Form__c = objApp.id;
        lstDFA.add(objDFA);
        insert lstDFA;
        
        List<string> lstProduct = new List<string>();
        lstProduct.add('90 Mtr Box');
        lstProduct.add('FRLS');
        
        AddMultipleRowCtrl.WrappMain objwrap = new AddMultipleRowCtrl.WrappMain();
        objwrap.success = false;
        AddMultipleRowCtrl.AddNewRow(JSON.serialize(lstDFA));
        AddMultipleRowCtrl.AddNewRow(string.valueof(lstDFA));
        AddMultipleRowCtrl.RemoveRowIndex(JSON.serialize(lstDFA));
        AddMultipleRowCtrl.RemoveRowIndex(string.valueof(lstDFA));
    }
}