@istest
public class CreateOrderAndOrderLineItemsCtrltest {
    @istest
    public static void getAllProduct()
    {   
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';
        insert objAcc;
        Contact objcon = new contact();
        objcon.LastName = 'Test contact';
        objcon.AccountId = objAcc.Id;
        insert objcon;
        
        Product__c objProduct = new Product__c();
        objProduct.Name = 'Test Product';
        insert objProduct;
        
        Order__c objOrder = new Order__c();
        objOrder.Retailer_Distributor__c = objAcc.id;
        objOrder.Order_given_by__c = 'Contact Name';
        insert objOrder;
        
        List<Order_Line_Item__c> lstOLI = new List<Order_Line_Item__c>();
        Order_Line_Item__c objOLI = new Order_Line_Item__c();
        objOLI.Order__c = objOrder.id;
        objOLI.Order_Value__c=20000;
        objOLI.Product__c =objProduct.id;
        objOLI.Unit_Price__c = 2000;
        objOLI.Quantity__c = 2;
        lstOLI.add(objOLI);
        
        Order_Line_Item__c objOLI2 = new Order_Line_Item__c();
        objOLI2.Order__c = objOrder.id;
        objOLI2.Product__c =objProduct.id;
        objOLI2.Order_Value__c=20000;
        objOLI2.Unit_Price__c = 2000;
        objOLI2.Quantity__c = 2;
        lstOLI.add(objOLI2);
        
        Order_Line_Item__c objOLI3 = new Order_Line_Item__c();
        objOLI3.Order__c = objOrder.id;
        objOLI3.Product__c =objProduct.id;
        objOLI3.Order_Value__c=50000;
        objOLI3.Unit_Price__c = 2000;
        objOLI3.Quantity__c = 2;
        lstOLI.add(objOLI3);
        
        insert lstOLI;
        
        list<CreateOrderAndOrderLineItemsCtrl.Productwrap> lstProduct = new list<CreateOrderAndOrderLineItemsCtrl.Productwrap>();
        CreateOrderAndOrderLineItemsCtrl.Productwrap wrapPro = new CreateOrderAndOrderLineItemsCtrl.Productwrap();
        wrapPro.objproduct = objProduct;
        wrapPro.objproduct = objProduct;
        wrapPro.objproduct = objProduct;
        // wrapPro.Numberofproduct =5;
        lstProduct.add(wrapPro);
        
        CreateOrderAndOrderLineItemsCtrl.WrappMain objwrap = new CreateOrderAndOrderLineItemsCtrl.WrappMain();
        objwrap.errorMessage ='';
        objwrap.lstProduct = lstProduct;
        String strwrapobj  = json.serialize(objwrap);
        CreateOrderAndOrderLineItemsCtrl.getProduct(objAcc.id);
        CreateOrderAndOrderLineItemsCtrl.getProduct(objOrder.id);
        CreateOrderAndOrderLineItemsCtrl.CreateOrderAndProduct(objAcc.id,strwrapobj,objcon.id);
        CreateOrderAndOrderLineItemsCtrl.CreateOrderAndProduct(objOrder.id,strwrapobj,objcon.id);
    }
    
      @istest
    public static void getAllProducterror()
    {   
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';
        insert objAcc;
        Contact objcon = new contact();
        objcon.LastName = 'Test contact';
        objcon.AccountId = objAcc.Id;
        insert objcon;
        
        Product__c objProduct = new Product__c();
        objProduct.Name = 'Test Product';
        insert objProduct;
      
        
        Order__c objOrder = new Order__c();
        objOrder.Retailer_Distributor__c = objAcc.id;
        objOrder.Order_given_by__c = 'Contact Name';
        insert objOrder;
        
        List<Order_Line_Item__c> lstOLI = new List<Order_Line_Item__c>();
        Order_Line_Item__c objOLI = new Order_Line_Item__c();
        objOLI.Order__c = objOrder.id;
        
        objOLI.Quantity__c = 2;
        lstOLI.add(objOLI);
        insert lstOLI;
        
        list<CreateOrderAndOrderLineItemsCtrl.Productwrap> lstProduct = new list<CreateOrderAndOrderLineItemsCtrl.Productwrap>();
        CreateOrderAndOrderLineItemsCtrl.Productwrap wrapPro = new CreateOrderAndOrderLineItemsCtrl.Productwrap();
        wrapPro.objproduct = objProduct;
        wrapPro.objproduct = objProduct;
        // wrapPro.Numberofproduct =5;
        lstProduct.add(wrapPro);
        
        CreateOrderAndOrderLineItemsCtrl.WrappMain objwrap = new CreateOrderAndOrderLineItemsCtrl.WrappMain();
        objwrap.errorMessage ='';
        objwrap.lstProduct = lstProduct;
        String strwrapobj =json.serialize(objwrap);
        CreateOrderAndOrderLineItemsCtrl.getProduct('');
        CreateOrderAndOrderLineItemsCtrl.getProduct('');
  		CreateOrderAndOrderLineItemsCtrl.CreateOrderAndProduct('0011m000008Oud3AAC',strwrapobj,'0031m000007JtbGAAS');
        CreateOrderAndOrderLineItemsCtrl.CreateOrderAndProduct('a0E1m0000009UjYEAU',strwrapobj,'0031m000007JtfGAAS');
    }
    
     @istest
    public static void getAllProduct3()
    {   
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';
        insert objAcc;
        Contact objcon = new contact();
        objcon.LastName = 'Test contact';
        objcon.AccountId = objAcc.Id;
        insert objcon;
        
        Product__c objProduct = new Product__c();
        objProduct.Name = 'Test Product';
        insert objProduct;
        
        Order__c objOrder = new Order__c();
        objOrder.Retailer_Distributor__c = objAcc.id;
        objOrder.Order_given_by__c = 'Contact Name';
        insert objOrder;
        
        List<Order_Line_Item__c> lstOLI = new List<Order_Line_Item__c>();
        Order_Line_Item__c objOLI = new Order_Line_Item__c();
        objOLI.Order__c = objOrder.id;
        objOLI.Order_Value__c=20000;
        objOLI.Product__c =objProduct.id;
        objOLI.Unit_Price__c = 2000;
        objOLI.Quantity__c = 2;
        lstOLI.add(objOLI);
        
        Order_Line_Item__c objOLI2 = new Order_Line_Item__c();
        objOLI2.Order__c = objOrder.id;
        objOLI2.Product__c =objProduct.id;
        objOLI2.Order_Value__c=20000;
        objOLI2.Unit_Price__c = 2000;
        objOLI2.Quantity__c = 2;
        lstOLI.add(objOLI2);
        
        Order_Line_Item__c objOLI3 = new Order_Line_Item__c();
        objOLI3.Order__c = objOrder.id;
        objOLI3.Product__c =objProduct.id;
        objOLI3.Order_Value__c=50000;
        objOLI3.Unit_Price__c = 2000;
        objOLI3.Quantity__c = 2;
        lstOLI.add(objOLI3);
        
        insert lstOLI;
        
        list<CreateOrderAndOrderLineItemsCtrl.Productwrap> lstProduct = new list<CreateOrderAndOrderLineItemsCtrl.Productwrap>();
        CreateOrderAndOrderLineItemsCtrl.Productwrap wrapPro = new CreateOrderAndOrderLineItemsCtrl.Productwrap();
        wrapPro.objproduct = objProduct;
        lstProduct.add(wrapPro);
		CreateOrderAndOrderLineItemsCtrl.Productwrap wrapPro2 = new CreateOrderAndOrderLineItemsCtrl.Productwrap();
        wrapPro2.objproduct = objProduct;
        // wrapPro.Numberofproduct =5;
        lstProduct.add(wrapPro2);
        
        CreateOrderAndOrderLineItemsCtrl.WrappMain objwrap = new CreateOrderAndOrderLineItemsCtrl.WrappMain();
        objwrap.errorMessage ='';
        objwrap.lstProduct = lstProduct;
        String strwrapobj  = json.serialize(objwrap);
        CreateOrderAndOrderLineItemsCtrl.getProduct(objAcc.id);
        CreateOrderAndOrderLineItemsCtrl.getProduct(objOrder.id);
        CreateOrderAndOrderLineItemsCtrl.CreateOrderAndProduct(objAcc.id,strwrapobj,objcon.id);
        CreateOrderAndOrderLineItemsCtrl.CreateOrderAndProduct(objOrder.id,strwrapobj,objcon.id);
    }
    
}