({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFABank");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Bank_Name_Branch__c == '' || tmpDFAList[indexVar].Bank_Name_Branch__c == null) {
				isValid = false;
				var errors = 'Bank Name Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Account_No__c == '' || tmpDFAList[indexVar].Account_No__c == null) {
				isValid = false;
				var errors = 'Account Number Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Account_Type__c == '' || tmpDFAList[indexVar].Account_Type__c == null) {
				isValid = false;
				var errors = 'Account Type Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].IFSC_Code__c == '' || tmpDFAList[indexVar].IFSC_Code__c == null) {
				isValid = false;
				var errors = 'IFSC Code Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
       
		if(isValid){
			tmpDFAList.push({ attributes: { type: "DFA__c" } });
			component.set("v.lstDFABank",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFABank");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFABank", AllRowsList);
	},
})