({
	getRecord : function(component) {
		component.set("v.showSpinner",true);
        var action = component.get("c.getProduct"); 
		action.setParams({
			"strRecordId" : component.get("v.recordId")
		});
        action.setCallback(this, function(response) {
            var state = response.getState(); 
			//alert(state+'...state...'+JSON.parse(response.getReturnValue()).success);
            if (state === "SUCCESS"  && JSON.parse(response.getReturnValue()).success) {
				let obj = JSON.parse(response.getReturnValue());
                component.set("v.objWrap", obj);
				component.set("v.strContact",JSON.parse(response.getReturnValue()).strOrderPlacedBy);
				component.set("v.strAccountName",JSON.parse(response.getReturnValue()).strAccountName);
            }else if (state === "ERROR") {
                var errors = response.getError();
                this.displayToastMsg(errors,'error', 'Error!');
            }
			else if (!JSON.parse(response.getReturnValue()).success) {
				this.displayToastMsg(JSON.parse(response.getReturnValue()).errorMessage,'error', 'Error!');
				//component.set("v.ErrorMessage",JSON.parse(response.getReturnValue()).message);
            }
            component.set("v.showSpinner",false);
        }); 
        $A.enqueueAction(action);
	},
	CreateOrder : function(component, event, helper) {
		component.set("v.showSpinner",true);
        var action = component.get("c.CreateOrderAndProduct"); 
        action.setParams({
			"id" : component.get("v.recordId"),
			"strWrap" : JSON.stringify(component.get("v.objWrap")),
			"strConId" : component.get("v.strContact")
		});
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            if (state === "SUCCESS") {
				var obj = response.getReturnValue();
                if(obj.errorMessage){
                    this.displayToastMsg(obj.errorMessage,'error', 'Error!');
                }else{
					this.displayToastMsg($A.get("$Label.c.Success_Message"),'Success', 'Success!');
					window.location.href='/lightning/r/Account/'+component.get("v.recordId")+'/view'
                    //component.set("v.objWrap", obj);
                }
            }else if (state === "ERROR") {
                var errors = response.getError();
                this.displayToastMsg(errors,'error', 'Error!');
            }
            component.set("v.showSpinner",false);
        }); 
        $A.enqueueAction(action);
	},
	displayToastMsg : function(err, type, title) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": type,
            duration: "10000",
            "message": err
        });
        toastEvent.fire();
    },
})