({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFAMainCustomers");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Name_Main_Customers__c == '' || tmpDFAList[indexVar].Name_Main_Customers__c == null) {
				isValid = false;
				var errors = 'Customers Name Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Nature_of_Business__c == '' || tmpDFAList[indexVar].Nature_of_Business__c == null) {
				isValid = false;
				var errors = 'Nature of Business Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Product__c == '' || tmpDFAList[indexVar].Product__c == null) {
				isValid = false;
				var errors = 'Product Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Sale_to_Customer_lacs__c == '' || tmpDFAList[indexVar].Sale_to_Customer_lacs__c == null) {
				isValid = false;
				var errors = 'Sale to Customer Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
       
		if(isValid){
			tmpDFAList.push({ attributes: { type: "DFA__c" } });
			component.set("v.lstDFAMainCustomers",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFAMainCustomers");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFAMainCustomers", AllRowsList);
	},
})