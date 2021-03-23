@istest
public class clsConvertLeadtest {
    @istest
    public static void convertLead()
    {
         User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'Gupta',
            Email = 'nitish.kumar@cairnindia.com',
            Username = 'nitish.kumar2-mtoe@force.com.uat' + System.currentTimeMillis(),
            CompanyName = 'Vedanta',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u; 
        
        Leads__c objLead = new Leads__c();
        objLead.Name = 'Test Lead';
        objLead.First_Name__c = 'Test First Name';
        objLead.Last_Name__c ='Test Last Name';
        objLead.Approval_Status__c ='Draft';
        insert objLead;
        System.runAs(u){
            clsConvertLead.convertLead(objLead.id);
            objLead.Approval_Status__c ='Approved';
            update objLead;
            clsConvertLead.convertLead(objLead.id);
        }
    }
}