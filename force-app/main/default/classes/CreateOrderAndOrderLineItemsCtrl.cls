public with sharing class CreateOrderAndOrderLineItemsCtrl{
    
   
    /**
    * @author: Manoj Pandey
    * @description: This method return Product based on price book
    * @param: 
    * @return: wrap 
    */
    @AuraEnabled
    public static string getProduct(string strRecordId)
    {
        WrappMain objWrap = new WrappMain();
        objWrap.success = true;
        objWrap.strAccountName = '';
        objWrap.strOrderPlacedBy = '';
        try{
            map<Id,decimal> mapExistingProduct = new map<Id,decimal>();
            Id recordId = strRecordId;
            String sObjName = recordId.getSObjectType().getDescribe().getName();
            system.debug('sObjName...'+sObjName);
            if(sObjName == 'Account'){
                list<Account> lstAccounts = [select id,Name from Account where Id=:recordId];
                
                if(lstAccounts.size()>0)
                    objWrap.strAccountName = lstAccounts[0].Name;
            }
            else{
                list<Order__c> lstOrders = [Select id,Name,Discount__c,Order_given_by__c,Retailer_Distributor__c,Retailer_Distributor__r.Name,Total_Amount__c,Total_Number_of_Order_Line_Items__c,Total_Payable_Amount__c,(Select id,Name,Product__c,Order_Value__c,Total__c,Unit_Price__c from Order_Line_Items__r) from Order__c where Id=: recordId];
                
                if(lstOrders.size()>0){
                    objWrap.strAccountName = lstOrders[0].Retailer_Distributor__r.Name;
                    objWrap.strOrderPlacedBy = lstOrders[0].Order_given_by__c;
                    
                    if(lstOrders[0].Order_Line_Items__r != null && lstOrders[0].Order_Line_Items__r.size()>0){
                        for(Order_Line_Item__c objOLI: lstOrders[0].Order_Line_Items__r){
                            mapExistingProduct.put(objOLI.Product__c,objOLI.Order_Value__c);
                        }
                    }
                }
            }            
            objWrap.lstProduct = new List<Productwrap>();
            for(Product__c objProduct: [select id,Name,Type__c,Variant__c from Product__c]){
                Productwrap objPro = new Productwrap();
                objPro.objproduct = objProduct;
                //objPro.OrdervalueAmount = 0;
                
                if(mapExistingProduct.containsKey(objProduct.Id))
                    objPro.OrdervalueAmount = integer.valueof(mapExistingProduct.get(objProduct.Id));
                System.debug('OrdervalueAmount-----------'+objPro.OrdervalueAmount );
                objwrap.lstProduct.add(objPro);
            }
            system.debug('objwrap.lstProduct...'+objwrap.lstProduct.size());
        }catch(Exception e){
            objWrap.success = false;
            objWrap.errorMessage = e.getMessage();
            system.debug('Exception...'+e.getMessage());
        }
            return Json.serialize(objWrap);
    }
    
  
    /**
    * @author: Manoj Pandey
    * @description: This method Create a Order and Order Line Items 
    * @param: id,strWrap,strConId
    * @return: wrap 
    */
    @AuraEnabled
    public static WrappMain CreateOrderAndProduct(string id, string strWrap, string strConId)
    {
        WrappMain objWrap = new WrappMain();
        try{
            system.debug(id+'...StrProductName....'+strWrap+'...strWrap..');
            objWrap.SuccessMessage ='';
            if(id !=null && id !='' && strWrap !=null && strWrap !=''){
                objWrap.success = true;
                objWrap = (WrappMain)JSON.deserialize(strWrap, WrappMain.class);
                system.debug('...objWrap...'+objWrap);
                List<Productwrap> lstProduct = objwrap.lstProduct;
                List<Order_Line_Item__c> lstOrderLI = new List<Order_Line_Item__c>();
                Order__c objOrder = new Order__c();
                map<Id,Order_Line_Item__c> mapExistingProduct = new map<Id,Order_Line_Item__c>();
                Id recordId = id;
                String sObjName = recordId.getSObjectType().getDescribe().getName();
                system.debug('sObjName...'+sObjName);
                if(sObjName == 'Account'){
                    objOrder.Retailer_Distributor__c = id;
                }
                else{
                    objOrder.Id = id;
                    
                    list<Order__c> lstOrders = [Select id,Name,Discount__c,Order_given_by__c,Retailer_Distributor__c,Retailer_Distributor__r.Name,Total_Amount__c,Total_Number_of_Order_Line_Items__c,Total_Payable_Amount__c,(Select id,Name,Product__c,Order_Value__c,Total__c,Unit_Price__c from Order_Line_Items__r) from Order__c where Id=: recordId];
                
                    if(lstOrders.size()>0){
                        
                        if(lstOrders[0].Order_Line_Items__r != null && lstOrders[0].Order_Line_Items__r.size()>0){
                            for(Order_Line_Item__c objOLI: lstOrders[0].Order_Line_Items__r){
                                mapExistingProduct.put(objOLI.Product__c,objOLI);
                            }
                        }
                    }
                }
                if(strConId !=null && strConId !='')
                    objOrder.Order_given_by__c =strConId;
                
                upsert objOrder;
                for(integer i= 0 ; i<lstProduct.size();  i++)
                {
                    
                    
                    System.debug('before test '+lstProduct[i].OrdervalueAmount);
                    if(lstProduct[i].OrdervalueAmount !=null && lstProduct[i].OrdervalueAmount >=0){
                        Order_Line_Item__c objOLI = new Order_Line_Item__c();
                        
                        system.debug(mapExistingProduct.containsKey(lstProduct[i].objproduct.id)+'...mapExistingProduct.containsKey(lstProduct[i].objproduct.id)...'+lstProduct[i].objproduct.id);
                        if(mapExistingProduct.containsKey(lstProduct[i].objproduct.id)){
                            objOLI.Id = mapExistingProduct.get(lstProduct[i].objproduct.id).Id;
                            objOLI.Order_Value__c = lstProduct[i].OrdervalueAmount;
                            objOLI.Product__c = lstProduct[i].objproduct.id;
                            lstOrderLI.add(objOLI);
                        }
                        else{
                            if(lstProduct[i].OrdervalueAmount >0){
                                objOLI.Order__c = objOrder.id;
                                objOLI.Order_Value__c = lstProduct[i].OrdervalueAmount;
                                objOLI.Product__c = lstProduct[i].objproduct.id;
                                lstOrderLI.add(objOLI);
                            }
                        }
                    }
                }
                system.debug(lstOrderLI+'lstOrderLI...'+lstOrderLI.size());
                if(lstOrderLI.size()>0){
                    upsert lstOrderLI;
                }
                objWrap.SuccessMessage = System.Label.Success_Message;
                system.debug('..objWrap.SuccessMessage...'+objWrap.SuccessMessage);
            }
        }catch(Exception e){
            objWrap.success = false;
            objWrap.errorMessage = e.getMessage();
        }
        return objWrap;
    }
    
    Public class WrappMain{
        public boolean success;
        public string errorMessage;
        public string SuccessMessage;
        public string strAccountName;
        public string strOrderPlacedBy;
        public list<Productwrap>lstProduct;
    }
    public class Productwrap{
        @AuraEnabled public Product__c objproduct;
        @AuraEnabled public decimal OrdervalueAmount;
    }  
}