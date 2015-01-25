/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "ComAccuratetimerModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"


/**
 *  C FUNCTIONS
 */


id refToSelf;

dispatch_time_t lastTime;

void DoWork(void *context);

void ScheduleWork() {
    
    //NSLog(@"ScheduleWork");
    
    //NSLog(@"%d", [refToSelf delayms] );
    
    //dispatch_time_t time = dispatch_time(lastTime, [refToSelf delayms]*1000000); //nanoseconds / 10
    
    lastTime = dispatch_time(lastTime, [refToSelf delaynanosec]);
    
    // pass NULL to the context
    dispatch_after_f(lastTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), NULL, &DoWork);
    
}

void DoWork(void *context) {
    
    if([refToSelf playing]){
        
        dispatch_async_f( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), NULL, &ScheduleWork);

        //NSLog(@"[CALLBACK] %f",CFAbsoluteTimeGetCurrent());
        
        [refToSelf runCallback];
      
    }
    
}



void InitTimer(){
    lastTime = DISPATCH_TIME_NOW;
    DoWork(NULL);
}

/**
 * IMPLEMENTATION
 */

@implementation ComAccuratetimerModule

@synthesize delayms;
@synthesize delaynanosec;
@synthesize playing;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"3ff4a9b2-1b2c-4809-b98a-13a615beee4d";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.accuratetimer";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
    
    refToSelf = self;
    
    [self setDelayms:1000]; //set default delay to 1 sec.
    
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
    
	RELEASE_TO_NIL(successCallback);
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma mark Sample Public APIs

-(id)author
{
	// example method
	return @"Javier Rayon, 2012";
}


#pragma mark PUBLIC APIs

/***
 *      REAL FUNCTIONS
 */


-(void)runCallback
{
	// The 'call' method of the KrollCallback object can be used to directly 
	// call the associated JavaScript function and get a return value. In this
	// instance there is no return value for the callback.
        
	[successCallback call:NULL thisObject:nil];
}


-(void)setInterval:(id)args
{
    
	successCallback = [[args objectForKey:@"callback"] retain];
    
    if([args objectForKey:@"delay"]){
        
        [self setDelay:[args objectForKey:@"delay"]];
        
    }
    
    
   // NSLog(@"%d INITIAL VALUE: ", [self delayms]);
    
	if (successCallback){

        //[self setPlaying:true];        
        
        //DoWork(NULL);
        
	}else{
        NSLog(@"[WARN] Timer: callback function not defined.");
    }
    
}

void DoOnce(){
    NSLog(@"[INFO] Timer: DoOnce.");
    [refToSelf runCallback];
}

//plays only once
-(void)setTimeout:(id)args
{

    [self setPlaying:false];
    
	successCallback = [[args objectForKey:@"callback"] retain];
    
    NSInteger timeOutms = [TiUtils intValue:[args objectForKey:@"delay"]];

    NSLog(@"[INFO] setTimeout %i", timeOutms);
    
    if (successCallback){
        
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, timeOutms * 1000000000);
        
        // Here I pass in NULL for the 'context'    
//        dispatch_after_f(when, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), NULL, &DoOnce);
          dispatch_after_f(when, dispatch_get_main_queue(), NULL, &DoOnce);
        
	}else{
        NSLog(@"[WARN] Timer: callback function not defined.");
    }
}

-(void)setDelay:(id)args
{    
    delayms = [TiUtils intValue:args]; 
    
    delaynanosec = delayms * 1000000;
    
}

-(void)start:(id)args
{
    
    [self setPlaying:true];
    
    InitTimer();
    
}


-(void)stop:(id)args
{
    [self setPlaying:false];
}


-(void)logTimeStamp:(id)args
{
	NSLog(@"[INFO] timestamp: %f", CFAbsoluteTimeGetCurrent());
}


-(id)getTimeStamp:(id)args
{
	return  NUMDOUBLE(CFAbsoluteTimeGetCurrent());
    
}

@end
