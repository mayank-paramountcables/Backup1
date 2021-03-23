({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFA");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Name_Father_Name_Address__c == '' || tmpDFAList[indexVar].Name_Father_Name_Address__c == null) {
				isValid = false;
				var errors = 'Name Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Type__c == '--None--' || tmpDFAList[indexVar].Type__c == null) {
				isValid = false;
				var errors = 'Type Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Pan_No__c == '' || tmpDFAList[indexVar].Pan_No__c == null) {
				isValid = false;
				var errors = 'Pan Number Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Aadhar_No__c == '' || tmpDFAList[indexVar].Aadhar_No__c == null) {
				isValid = false;
				var errors = 'Aadhar Number Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
		}
       
		if(isValid){
			tmpDFAList.push({ attributes: { type: "DFA__c" } });
			component.set("v.lstDFA",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFA");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFA", AllRowsList);
	},
})