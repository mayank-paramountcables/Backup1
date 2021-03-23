public class MeetingAttendeesTriggerHandler{
    public static void onAfterUpdate(list<Meeting_Attendees__c>TriggerNew,list<Meeting_Attendees__c>TriggerOld, Map<Id,Meeting_Attendees__c> triggeroldMap,boolean isAfter,boolean isInsert,boolean isDelete){
        if(isAfter && isinsert)
            onAfterInsertMeetingAttendees(triggerNew);
        
        if(isAfter && isDelete)
            onAfterDeleteMeetingAttendees(TriggerOld);
    }
    static void onAfterInsertMeetingAttendees(list<Meeting_Attendees__c>TriggerNew){
        map<Id,Decimal> mapCount = new map<Id,Decimal>();
        for(Meeting_Attendees__c objMA:TriggerNew){
            mapCount.put(objMA.Meeting_Event__c,1);
        }
        map<id,Decimal> mapEventQuantities = new map<id,Decimal>();
        map<id,Decimal> mapEventDetails = new map<Id,Decimal>();
        if(mapCount.size()>0){
            
            for(Meeting_Event__c objME :[Select Id,Name,Retailer_Distributor__c from Meeting_Event__c where Id IN : mapCount.keyset()]){
                mapEventQuantities.put(objME.Retailer_Distributor__c,1);
            }
        }
        if(mapEventQuantities.size()>0){
            for(Account objAcc :[Select Id,Name,OwnerId from Account where Id IN :mapEventQuantities.Keyset()]){
                Decimal TotalQuantities =  mapEventQuantities.get(objAcc.Id);
                mapEventDetails.put(objAcc.OwnerId,TotalQuantities);
            }
            List<Returned_Gift_Items__c> lstReturnGI = new List<Returned_Gift_Items__c>();
            for(Returned_Gift_Items__c objRGI :[Select Id,Available_Quantities__c,Returned_Quantities__c,Sales_Rep__c from Returned_Gift_Items__c where Sales_Rep__c IN: mapEventDetails.keySet()]){
                objRGI.Available_Quantities__c = objRGI.Available_Quantities__c - mapEventDetails.get(objRGI.Sales_Rep__c);
                lstReturnGI.add(objRGI);
            }
            if(lstReturnGI.size()>0){
                Update lstReturnGI;
            }
        }
    }
    
    static void onAfterDeleteMeetingAttendees(list<Meeting_Attendees__c>TriggerOld){
        map<Id,Decimal> mapCount = new map<Id,Decimal>();
        for(Meeting_Attendees__c objMA:TriggerOld){
            mapCount.put(objMA.Meeting_Event__c,1);
        }
        map<id,Decimal> mapEventQuantities = new map<id,Decimal>();
        map<id,Decimal> mapEventDetails = new map<Id,Decimal>();
        if(mapCount.size()>0){
            
            for(Meeting_Event__c objME :[Select Id,Name,Retailer_Distributor__c from Meeting_Event__c where Id IN : mapCount.keyset()]){
                mapEventQuantities.put(objME.Retailer_Distributor__c,1);
            }
        }
        if(mapEventQuantities.size()>0){
            for(Account objAcc :[Select Id,Name,OwnerId from Account where Id IN :mapEventQuantities.Keyset()]){
                Decimal TotalQuantities =  mapEventQuantities.get(objAcc.Id);
                mapEventDetails.put(objAcc.OwnerId,TotalQuantities);
            }
            List<Returned_Gift_Items__c> lstReturnGI = new List<Returned_Gift_Items__c>();
            for(Returned_Gift_Items__c objRGI :[Select Id,Available_Quantities__c,Returned_Quantities__c,Sales_Rep__c from Returned_Gift_Items__c where Sales_Rep__c IN: mapEventDetails.keySet()]){
                objRGI.Available_Quantities__c = objRGI.Available_Quantities__c + mapEventDetails.get(objRGI.Sales_Rep__c);
                lstReturnGI.add(objRGI);
            }
            if(lstReturnGI.size()>0){
                Update lstReturnGI;
            }
        }
    }
}