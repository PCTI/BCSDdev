/*
 *  This code is adapted from the work of Michael Nachbaur
 *  by Simon Madine of The Angry Robot Zombie Factory
 *  2010-05-04
 *  MIT licensed
 */

/**
 * This class exposes the ability to take a Screenshot to JavaScript
 * @constructor
 */
function Screenshot() {
}

/**
 * Save the screenshot to the user's Photo Library
 */
Screenshot.prototype.saveScreenshot = function() {
    Cordova.exec(null, null,"Screenshot","saveScreenshot",[]);
};

Cordova.addConstructor(function()
                        {
                        if(!window.plugins)
                        {
                        window.plugins = {};
                        }
                        window.plugins.screenShot = new Screenshot();
                        });