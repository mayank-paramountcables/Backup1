({
	doInit : function(component, event, helper) {
		helper.getRecord(component);
	},
	CreateOrder : function(component, event, helper) {
		var ProdList = component.get('v.objWrap.lstProduct');
		var IsAvailableProd = false;
		var IsProduct = true;
		if(ProdList.length >0){
			for(var i=0; i<ProdList.length; i++){
                //alert('ProdList[i].OrdervalueAmount'+ProdList[i].OrdervalueAmount);
				if(ProdList[i].OrdervalueAmount > 0 && ProdList[i].OrdervalueAmount !=null){
					IsAvailableProd = true;
				}
				if(ProdList[i].OrdervalueAmount < 0 && ProdList[i].OrdervalueAmount !=null){
					IsProduct = false;
				}
			}
		}
		if(IsAvailableProd && IsProduct)
			helper.CreateOrder(component, event, helper);
		else
		{
			    var toastEvent = $A.get("e.force:showToast");
				toastEvent.setParams({
					"title": 'Errors',
					"type": 'error',
					duration: "10000",
					"message": 'Order value can not be less the zero.'
				});
				toastEvent.fire();
		}
	},
    CancelOrder : function(component, event, helper) {
		//window.location.href='/lightning/r/Account/'+component.get("v.recordId")+'/view'
		
		var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
	},
})