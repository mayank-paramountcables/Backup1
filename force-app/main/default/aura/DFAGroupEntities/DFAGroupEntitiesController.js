({
	AddNewRow : function(component, event, helper)
	{
		var isValid = true;
		var tmpDFAList = component.get("v.lstDFAGroupEntities");
		for (var indexVar = 0; indexVar < tmpDFAList.length; indexVar++) {
			if (tmpDFAList[indexVar].Name_Group_Entities__c == '' || tmpDFAList[indexVar].Name_Group_Entities__c == null) {
				isValid = false;
				var errors = 'Name Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Nature_of_Business__c == '' || tmpDFAList[indexVar].Nature_of_Business__c == null) {
				isValid = false;
				var errors = 'Nature of Business Can\'t be Blank';
                helper.displayToastMsg(errors,'error', 'Error!');
			}
			if (tmpDFAList[indexVar].Relation__c == '' || tmpDFAList[indexVar].Relation__c == null) {
				isValid = false;
				var errors = 'Relation Can\'t be Blank';
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
			component.set("v.lstDFAGroupEntities",tmpDFAList);
		}
	},
	removeRow : function(component,event,helper){
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.lstDFAGroupEntities");
        AllRowsList.splice(index, 1);
        component.set("v.lstDFAGroupEntities", AllRowsList);
	},
})