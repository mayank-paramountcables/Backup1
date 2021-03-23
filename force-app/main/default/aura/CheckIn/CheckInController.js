({
	checkGeoLocation : function(component, event, helper) {
        component.set("v.showSpinner",true);
    if (navigator.geolocation) {
        
        navigator.geolocation.getCurrentPosition(function(position) {
            var lat = position.coords.latitude;
            var lon = position.coords.longitude;
            var action = component.get("c.updateRecord");
            action.setParams({
                "latitude": lat,
                "longitude": lon,
                "strRecordId":component.get("v.recordId")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    //alert('....');
                    component.set("v.showSpinner",false);
                    var location = response.getReturnValue();
                    var toastEvent = $A.get("e.force:showToast");
                    var staticLabel = $A.get("$Label.c.Successfully_updated");
                    toastEvent.setParams({
                        title : 'Success',
                        message: staticLabel,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                    $A.get('e.force:refreshView').fire();
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire(); 
                    
                }
            });
            $A.enqueueAction(action);
        });
    } else {
        component.set("v.showSpinner",false);
        console.log('Your browser does not support GeoLocation');
       
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error',
            message: 'Your browser does not support GeoLocation.',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
         $A.get('e.force:refreshView').fire();
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire(); 
    }
}
})