({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFAOther");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Type_of_Business_Place__c == '--None--' || tmpDFAList[indexVar].Type_of_Business_Place__c == null) {
				isValid = false;
				var errors = 'Type Godown/Shop Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Address__c == '' || tmpDFAList[indexVar].Address__c == null) {
				isValid = false;
				var errors = 'Address Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Year_of_Estl__c == '' || tmpDFAList[indexVar].Year_of_Estl__c == null) {
				isValid = false;
				var errors = 'Year of Estl Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Business_Place_Type__c == '--None--' || tmpDFAList[indexVar].Business_Place_Type__c == null) {
				isValid = false;
				var errors = 'Owner/Rented Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
       
		if(isValid){
			tmpDFAList.push({ attributes: { type: "DFA__c" } });
			component.set("v.lstDFAOther",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFAOther");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFAOther", AllRowsList);
	},
})