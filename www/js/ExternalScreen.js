var PGExternalScreen = {
    
setupScreenConnectionNotificationHandlers: function (success, fail) {
    return Cordova.exec(success, fail, "PGExternalScreen", "setupScreenConnectionNotificationHandlers", []);
},
    
loadHTMLResource: function (url, success, fail) {
    return Cordova.exec(success, fail, "PGExternalScreen", "loadHTMLResource", [url]);
},
    
loadHTML: function (url, success, fail) {
    return Cordova.exec(success, fail, "PGExternalScreen", "loadHTML", [url]);
},
    
invokeJavaScript: function (scriptString, success, fail) {
    return Cordova.exec(success, fail, "PGExternalScreen", "invokeJavaScript", [scriptString]);
},
    
checkExternalScreenAvailable: function (success, fail) {
    return Cordova.exec(success, fail, "PGExternalScreen", "checkExternalScreenAvailable", []);
}
    
    
};