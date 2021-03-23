Public class LtngCheckInOutControllerlead
{
    @AuraEnabled
    public static String updateRecord (Decimal latitude, Decimal longitude,string strRecordId) {
        string strReturn = '';
        if(strRecordId != null && strRecordId != '' && latitude != null && longitude != null)
        {
            String url = 'http://maps.googleapis.com/maps/api/geocode/json?latlng=' + latitude + ',' + longitude + '&sensor=true';
           
            list<Leads__c> lstAcc = new list<Leads__c>();
            lstAcc = [select Id, Name, Check_In_Location__c, Check_In_Date_Time__c, Check_In_Location__Latitude__s,Check_In_Location__Longitude__s from Leads__c where Id =: strRecordId];
            if(lstAcc.size()>0)
            {
                lstAcc[0].Check_In_Location__Latitude__s = latitude;
                lstAcc[0].Check_In_Location__Longitude__s = longitude;
                lstAcc[0].Check_In_Date_Time__c = system.Now(); 
                update lstAcc[0];
                strReturn = system.label.Successfully_updated;
            }
        }
        return strReturn;
    }
    
 /*   @AuraEnabled
    public static String updateRecordCheckOut (Decimal latitude, Decimal longitude,string strRecordId) {
        string strReturn = '';
        if(strRecordId != null && strRecordId != '' && latitude != null && longitude != null)
        {
            String url = 'http://maps.googleapis.com/maps/api/geocode/json?latlng=' + latitude + ',' + longitude + '&sensor=true';
           
            list<Leads__c> lstAcc = new list<Leads__c>();
            lstAcc = [select Id, Name, Check_Out_Date_Time__c,Check_Out_Location__c,Check_Out_Location__Latitude__s,Check_Out_Location__Longitude__s from Leads__c where Id =: strRecordId];
            if(lstAcc.size()>0)
            {
                lstAcc[0].Check_Out_Location__Latitude__s = latitude;
                lstAcc[0].Check_Out_Location__Longitude__s = longitude;
                lstAcc[0].Check_Out_Date_Time__c = system.Now(); 
                update lstAcc[0];
                strReturn = system.label.Successfully_updated;
            }
        }
        return strReturn; 
    } */
}