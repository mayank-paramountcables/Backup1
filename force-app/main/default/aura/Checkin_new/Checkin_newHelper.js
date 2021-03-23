({
    getCurrentPosition: function(component){
        let self = this;
        let options = {
            enableHighAccuracy: true
        };
        
        function success(position) {
            component.set('v.curLatitude', position.coords.latitude);
            component.set('v.curLongitude', position.coords.longitude);
            component.set('v.isBtnDisabled', 'false');
            self.plotMap(component);
        }
        
        function error() {
            $A.get("e.force:closeQuickAction").fire();
            self.handleToast("error", "Error", "Check your browser\'s permission to track your location.");
        }
        
        if (!navigator.geolocation) {
            $A.get("e.force:closeQuickAction").fire();
            self.handleToast("error", "Error", "Geolocation is not supported by your browser");
        } else {
            navigator.geolocation.getCurrentPosition(success, error, options);
        }
    },
    plotMap: function(component){
        let curLatitude  = component.get('v.curLatitude');
        let curLongitude = component.get('v.curLongitude');
        let markers = [];
        
        markers.push({
            location: {
                Latitude: curLatitude,
                Longitude: curLongitude
            }
        });
        
        component.set('v.mapMarkers', markers);
    },
   getLastOpenVisitId: function(component){
        let action = component.get("c.getLastOpenVisitId");
        
        action.setParams({ 
            sObjectName: component.get("v.sObjectName"),
            recordId: component.get("v.recordId")
        });
        
        action.setCallback(this, function(a) {
            if (a.getState() === "SUCCESS") {
                let lastOpenVisitId = a.getReturnValue();
                component.set('v.lastOpenVisitId', lastOpenVisitId);
            }
            else {
                $A.get("e.force:closeQuickAction").fire();
                this.handleToast("error", "Error", "Something bad happened when getting the last open visit record\'s id");
            }
        });
        $A.enqueueAction(action);
    },
    upsertRecord: function(component){
        let action = component.get("c.upsertRecord");
        
        action.setParams({ 
            sObjectName: component.get("v.sObjectName"),
            recordId: component.get("v.recordId"),
            curLatitude: component.get("v.curLatitude"),
            curLongitude: component.get("v.curLongitude"),
            lastOpenVisitId: component.get("v.lastOpenVisitId")
        });
        
        action.setCallback(this, function(a) {
            if (a.getState() === "SUCCESS") {
         //       if(component.get("v.lastOpenVisitId") === null){
                    //check-in
                	$A.get("e.force:closeQuickAction").fire();
                    this.handleToast("success", "Done", "You have successfully checked-in!");
                    $A.get('e.force:refreshView').fire();
                }//else{
                    //check-out
              //      let upsertedVisitId = a.getReturnValue()
          //          this.navigateToVisit(component, upsertedVisitId);
           //     }
          //  }
            else {
				$A.get("e.force:closeQuickAction").fire();
                this.handleToast("error", "Error", "Something bad happened when upserting");
            }
        });
        $A.enqueueAction(action);
    },
 /*   navigateToVisit: function(component, upsertedVisitId){
        let pageReference = {
            type: "standard__recordPage",
            attributes: {
                recordId: upsertedVisitId,
                actionName: "view"
            }
        };
        let navService = component.find("navService");
		this.handleToast("success", "Done", "You have successfully checked-out!");
        navService.navigate(pageReference);
    },*/
    handleToast: function(type, title, message) {
        let showToast = $A.get("e.force:showToast");
        
        showToast.setParams({
            "mode": "dismissible",
            "type": type,
            "title": title,
            "message": message
        });    
        
        showToast.fire();
    }
})