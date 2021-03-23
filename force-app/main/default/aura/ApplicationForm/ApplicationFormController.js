({
	doInit : function(component, event, helper) {
		helper.getConstitutionValue(component);
        
	},
	createAppRecord : function(component, event, helper) {
		var selectedValues = component.get("v.selectedProductType");
		//alert('.....selectedValues...'+selectedValues);
		var objDateofB = component.get("v.objWrap.objApp.Date_of_Birth__c");
		var objCPLN = component.get("v.objWrap.objApp.Contact_Person_Last_Name__c");
		var Mobilenumber = component.get("v.objWrap.objApp.Mobile_No__c");
		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		var yyyy = today.getFullYear();
		today = yyyy + '-' + mm + '-' + dd;
		var IsValid = true;
		if(objDateofB !=null && objDateofB !=undefined){
			var errors = 'Date of Birth Can\'t be future Date.';
			if(objDateofB > today){
				IsValid = false;
				helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
		if(objDateofB == null || objDateofB ==''){
			IsValid = false;
			var errors = 'Date of Birth Can\'t be Blank.';
			helper.displayToastMsg(errors,'error', 'Error!');
		}
		if(objCPLN ==null || objCPLN ==''){
			IsValid = false;
			var errors = 'Contact Person Last Name Can\'t be Blank.';
			helper.displayToastMsg(errors,'error', 'Error!');
		}
		
        var emailFieldValue = component.get("v.objWrap.objApp.Email_Id__c");
        var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;  
		if(emailFieldValue !=null && emailFieldValue !=''){   
            if(emailFieldValue.match(regExpEmailformat)){
				IsValid = true;
			}else
			{
				IsValid = false;
				var errors = 'Please Enter a Valid Email Address.';
				helper.displayToastMsg(errors,'error', 'Error!');
			}
        }
		
		if(Mobilenumber !=null && Mobilenumber !=''){
			var mob = /^[1-9]{1}[0-9]{9}$/;
			//alert('..!'+mob.test(Mobilenumber));
			if (mob.test(Mobilenumber) == false) {
				IsValid = false;
				var errors = 'Please enter valid mobile number.';
				helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
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
	/*onCheckPan: function(component, event, helper) {
		component.set("v.objWrap.objApp.Copy_of_PAN__c",component.get("v.objWrap.objApp.Copy_of_PAN__c"));
    },
	onCheckKYC: function(component, event, helper) {
		var isChecked = component.find("KYCCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.KYC_of_Business_Entity__c",component.get("v.objWrap.objApp.KYC_of_Business_Entity__c"));
    },
	onCheckKYCDirector: function(component, event, helper) {
		var isChecked = component.find("KYCDirectorCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.KYC_of_Prop_Partner_Director__c",isChecked);
    },
	onCheckTINRC: function(component, event, helper) {
		var isChecked = component.find("TINRCCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.Copy_of_TIN_RC_GST_Reg__c",isChecked);
    },
	onCheckBankStatement: function(component, event, helper) {
		var isChecked = component.find("BankStatementCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.Copy_of_Bank_Statement__c",isChecked);
    },
	onCheckITR: function(component, event, helper) {
		var isChecked = component.find("ITRCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.Copy_of_ITR__c",isChecked);
    },
	onCheckSecurityCheque: function(component, event, helper) {
		var isChecked = component.find("SecurityChequeCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.Security_Cheque_along_with_covering_lett__c",isChecked);
    },
	onChecklastyrbalance: function(component, event, helper) {
		var isChecked = component.find("lastyrbalanceCheckBox").get("v.checked");
		component.set("v.objWrap.objApp.Copy_of_last_2_yr_balance_sheet_self_att__c",isChecked);
    },*/
	handleGenreChange: function (component, event, helper) {
        var selectedValues = event.getParam("value");
        component.set("v.selectedProductType", selectedValues);
    },
})