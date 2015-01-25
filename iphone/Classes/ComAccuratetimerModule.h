/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"

@interface ComAccuratetimerModule : TiModule 
{
   // @private
	// The JavaScript callbacks (KrollCallback objects)
	KrollCallback *successCallback;
    NSArray* arrayOfValues;
   // int delayms;
}


@property (nonatomic, assign, readwrite) NSInteger delayms;

@property (nonatomic, assign, readwrite) NSInteger delaynanosec;

@property (nonatomic, assign, readwrite) BOOL playing;

-(void)runCallback;

@end
