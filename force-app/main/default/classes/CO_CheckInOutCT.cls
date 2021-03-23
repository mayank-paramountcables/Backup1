public class CO_CheckInOutCT {
    @AuraEnabled
    public static Id upsertRecord(String sObjectName,
                                  String recordId,
                                  Double curLatitude,
                                  Double curLongitude,
                                  String lastOpenVisitId)
    {
       
       String prefix = lastOpenVisitId == null ? 'Check_in_' : 'Check_out_';
        sObjectName = sObjectName.contains('__c') ? sObjectName : sObjectName + '__c';
        
        CO_Visit__c recordToUpsert = new CO_Visit__c();
        
 //       recordToUpsert.Id = lastOpenVisitId != null ? Id.valueOf(lastOpenVisitId) : null;
        recordToUpsert.put(prefix + 'Coordinates__latitude__s' , curLatitude);
        recordToUpsert.put(prefix + 'Coordinates__longitude__s' , curLongitude);
        recordToUpsert.put(prefix + 'Date_Time_Stamp__c' , System.now());
      if(!test.isRunningTest())
       {
        recordToUpsert.put(sObjectName, recordId);
       }
        system.debug('### Visit to upsert: ' + recordToUpsert);
        
        upsert recordToUpsert;
        
        return recordToUpsert.Id;
    }
    
/*    @AuraEnabled
    public static Id getLastOpenVisitId(String sObjectName, String recordId){
        
        //get the most recent CO_Visit__c record that doesn't have check-out
        String query = 'SELECT Id, Check_in_Coordinates__c, Check_in_Date_Time_Stamp__c, Check_out_Coordinates__c, Check_out_Date_Time_Stamp__c ' +
            'FROM CO_Visit__c ' +
            'WHERE ' + sObjectName + '__r.Id = \'' + recordId + '\' AND Check_out_Date_Time_Stamp__c = null ' + 
            'ORDER BY Check_in_Date_Time_Stamp__c DESC LIMIT 1';
        
        system.debug('### Dynamic Query result: ' + query);
        
        List<CO_Visit__c> queryReturnValue = Database.query(query);
        
        if(queryReturnValue.size() > 0){
            return queryReturnValue[0].Id;
        }
        
        return null;
    } */
}