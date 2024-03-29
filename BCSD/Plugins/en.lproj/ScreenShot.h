//
//  Screenshot.h
//
//  Created by Simon Madine on 29/04/2010.
//  Copyright 2010 The Angry Robot Zombie Factory.
//  MIT licensed
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Cordova/CDV.h>
@interface Screenshot : CDVPlugin {
}

- (void)saveScreenshot:(NSArray*)arguments withDict:(NSDictionary*)options;
//- (void)saveScreenshotAsFile:(NSArray*)arguments withDict:(NSDictionary*)options;
@end
