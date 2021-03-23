({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFAMainDealers");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Name_of_Dealer__c == '' || tmpDFAList[indexVar].Name_of_Dealer__c == null) {
				isValid = false;
				var errors = 'Dealer Name Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Product__c == '' || tmpDFAList[indexVar].Product__c == null) {
				isValid = false;
				var errors = 'Product of Business Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Location__c == '' || tmpDFAList[indexVar].Location__c == null) {
				isValid = false;
				var errors = 'Location Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Sale_to_Dealer_Lacs__c == '' || tmpDFAList[indexVar].Sale_to_Dealer_Lacs__c == null) {
				isValid = false;
				var errors = 'Sale to Dealer Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
       
		if(isValid){
			tmpDFAList.push({ attributes: { type: "DFA__c" } });
			component.set("v.lstDFAMainDealers",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFAMainDealers");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFAMainDealers", AllRowsList);
	},
})