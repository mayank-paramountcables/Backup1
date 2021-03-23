({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFAProducts");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Company_Brand__c == '' || tmpDFAList[indexVar].Company_Brand__c == null) {
				isValid = false;
				var errors = 'Company/Brand Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Product__c == '' || tmpDFAList[indexVar].Product__c == null) {
				isValid = false;
				var errors = 'Product of Business Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Experience_Years__c == '' || tmpDFAList[indexVar].Experience_Years__c == null) {
				isValid = false;
				var errors = 'Experience Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Turnover_lacks__c == '' || tmpDFAList[indexVar].Turnover_lacks__c == null) {
				isValid = false;
				var errors = 'Turnover Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
       
		if(isValid){
			tmpDFAList.push({ attributes: { type: "DFA__c" } });
			component.set("v.lstDFAProducts",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFAProducts");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFAProducts", AllRowsList);
	},
})