({
	doInit: function(component, event, helper) {
        helper.getCurrentPosition(component);
   //     helper.getLastOpenVisitId(component);
	},
    handleConfirm: function(component, event, helper){
        helper.upsertRecord(component);
    },
    handleCancel: function(component, event, helper){
        $A.get("e.force:closeQuickAction").fire();
    }
})