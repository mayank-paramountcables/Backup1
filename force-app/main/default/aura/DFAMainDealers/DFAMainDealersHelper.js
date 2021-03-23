({
    displayToastMsg : function(err, type, title) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": type,
            duration: "5000",
            "message": err
        });
        toastEvent.fire();
    }
})