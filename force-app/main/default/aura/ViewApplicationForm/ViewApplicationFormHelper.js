({
    getConstitutionValue : function(component, event, helper) {
        component.set("v.showSpinner",true);
        
        var action = component.get("c.getConstitutionAndDFA"); 
        action.setParams({
            strRecordId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            //alert(JSON.parse(response.getReturnValue()).success+'.....'+state);
            if (state === "SUCCESS" && JSON.parse(response.getReturnValue()).success) {
                //alert('.....'+JSON.parse(response.getReturnValue()).lstProductType);
                component.set("v.TypeConstitution", JSON.parse(response.getReturnValue()).lstConstitution);
                component.set("v.lstType", JSON.parse(response.getReturnValue()).lstType);
                component.set("v.lstTypeofBusinessPlace", JSON.parse(response.getReturnValue()).lstTypeofBusinessPlace);
                component.set("v.lstBusinessPlaceType", JSON.parse(response.getReturnValue()).lstBusinessPlaceType);
                var result = JSON.parse(response.getReturnValue()).lstProductType;
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                //alert('result.....'+result);
                var Prod1 = JSON.parse(response.getReturnValue()).objApp.Expected_Products_to_be_Ordered__c;
                //alert('Prod1.....'+Prod1);
                if(Prod1 != undefined){
                    var splt = Prod1.split(';');
                    component.set("v.selectedProductType", splt);
                }
                //alert('splt.....'+splt);
                
                component.set("v.lstProductType",plValues);
                component.set("v.objWrap", JSON.parse(response.getReturnValue()));
                // var strvalue = component.get("v.objWrap");
                //var mulSelect = strvalue.Expected_Products_to_be_Ordered__c.split(';');
                //component.set("v.selectedProductType",'test');
            }else if (state === "ERROR") {
                var errors = response.getError();
                this.displayToastMsg(errors,'error', 'Error!');
            }
                else if (!JSON.parse(response.getReturnValue()).success) {
                    this.displayToastMsg(JSON.parse(response.getReturnValue()).errorMessage,'error', 'Error!');
                }
            component.set("v.showSpinner",false);
        }); 
        $A.enqueueAction(action);
    },
    
    createRecord : function(component,event, helper) {
        component.set("v.showSpinner",true);
        
        var action = component.get("c.createApplicationRecord"); 
        action.setParams({
            strRecordId : component.get("v.recordId"),
            strWrap : JSON.stringify(component.get("v.objWrap")),
            strProductType : JSON.stringify(component.get("v.selectedProductType"))
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            //alert(JSON.parse(response.getReturnValue()).success+'..state..'+state);
            //alert(JSON.parse(response.getReturnValue()).strAppId+'..objWrap.strAppId..');
            component.set("v.atrAppId",JSON.parse(response.getReturnValue()).strAppId);
            
            if (state === "SUCCESS"  && JSON.parse(response.getReturnValue()).success) {
                //let obj = JSON.parse(response.getReturnValue());
                //component.set("v.objWrap", obj);
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
                dismissActionPanel.fire();
                //$A.get('e.force:refreshView').fire();
                var AppId = JSON.parse(response.getReturnValue()).strAppId;
                window.location.replace('/lightning/r/Application_Form__c/'+AppId+'/view');
                //this.gotoURL(component, event, helper);
            }else if (state === "ERROR") {
                var errors = response.getError();
                this.displayToastMsg(errors,'error', 'Error!');
            }
                else if (!JSON.parse(response.getReturnValue()).success) {
                    this.displayToastMsg(JSON.parse(response.getReturnValue()).errorMessage,'error', 'Error!');
                }
            component.set("v.showSpinner",false);
        }); 
        $A.enqueueAction(action);
    },
    displayToastMsg : function(err, type, title) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": type,
            duration: "10000",
            "message": err
        });
        toastEvent.fire();
    },
    gotoURL : function (component, event, helper) {
    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": "https://www.google.com/"
    });
    urlEvent.fire();
    },
    
})