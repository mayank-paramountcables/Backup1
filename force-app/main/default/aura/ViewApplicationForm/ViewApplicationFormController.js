({
	doInit : function(component, event, helper) {
		helper.getConstitutionValue(component);
        
	},
	createAppRecord : function(component, event, helper) {
		var selectedValues = component.get("v.selectedProductType");
		//alert('.....selectedValues...'+selectedValues);
		var objDateofB = component.get("v.objWrap.objApp.Date_of_Birth__c");
		var objCPLN = component.get("v.objWrap.objApp.Contact_Person_Last_Name__c");
		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		var yyyy = today.getFullYear();
		today = yyyy + '-' + mm + '-' + dd;
		var IsValid = true;
		if(objDateofB !=null && objDateofB !=undefined){
			var errors = 'Please input valid Date of Birth';
			if(objDateofB > today){
				IsValid = false;
				helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
		if(objDateofB == null || objDateofB ==''){
			IsValid = false;
			var errors = 'Date of Birth Can\'t be Blank';
			helper.displayToastMsg(errors,'error', 'Error!');
		}
		if(objCPLN ==null || objCPLN ==''){
			IsValid = false;
			var errors = 'Last Name Can\'t be Blank';
			helper.displayToastMsg(errors,'error', 'Error!');
		}
		//alert(objDateofB+'..today..'+today)
		if(IsValid)
			helper.createRecord(component,event, helper);
	},
	addNewRow: function(component, event, helper) {
        helper.createObjectData(component, event);
    },
	removeDeletedRow: function(component, event, helper) {
        var index = event.getParam("indexVar");  
        var AllRowsList = component.get("v.objWrap.lstDFA");
        AllRowsList.splice(index, 1);
        component.set("v.objWrap.lstDFA", AllRowsList);
    },
	ClosedAppRecord: function(component, event, helper) {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
		dismissActionPanel.fire();
    },
	handleGenreChange: function (component, event, helper) {
        var selectedValues = event.getParam("value");
        component.set("v.selectedProductType", selectedValues);
    },
})