//
//  WhatsInApp.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WhatsInApp.h"
#import "WIAppLongPressTriggerGestureRecognizer.h"
#import "WIAViewController.h"

#import "WIAppUserDefaultsModule.h"
#import "WIAppLocalNotificationModule.h"
#import "WIAppKeyChainModule.h"


@interface WhatsInApp ()

@property (nonatomic, retain) UINavigationController * whatsInAppController;
@property (nonatomic, assign, getter=isAssistantLogOn) BOOL assistantLogOn;
@end

@implementation WhatsInApp

+ (WhatsInApp *)sharedInstance
{
    static WhatsInApp * sharedInstance = nil;
    if(!sharedInstance){
        sharedInstance = [[WhatsInApp alloc] init];
    }
    return sharedInstance;
}

+ (void)start
{
    WhatsInApp * sharedInstance = [WhatsInApp sharedInstance];
    [sharedInstance addTriggerGestureOnKeyWindow];
    [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(addTriggerGestureOnKeyWindow) name:UIWindowDidBecomeVisibleNotification object:nil];
    sharedInstance.assistantLogOn = YES;
}

+ (void)stop
{
    NSArray * windows = [[UIApplication sharedApplication] windows];
    for (UIWindow * window in windows) {
        NSArray * gestureRecognizers = [window gestureRecognizers];
        for (UIGestureRecognizer * recognizer in gestureRecognizers) {
            if([recognizer isKindOfClass:[WIAppLongPressTriggerGestureRecognizer class]]){
                [window removeGestureRecognizer:recognizer];
            }
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:[WhatsInApp sharedInstance]];
    [[WhatsInApp sharedInstance] releaseResource];
}

- (void)addTriggerGestureOnKeyWindow
{
    NSArray * windows = [[UIApplication sharedApplication] windows];
    for (UIWindow * window in windows) {
        NSArray * gestureRecognizers = window.gestureRecognizers;
        BOOL isExists = NO;
        for (UIGestureRecognizer * recognizer in gestureRecognizers) {
            if([recognizer isKindOfClass:[WIAppLongPressTriggerGestureRecognizer class]]){
                isExists = YES;
                break;
            }
        }
        if(!isExists){
            UILongPressGestureRecognizer * triggerGestureRecognizer = [[[WIAppLongPressTriggerGestureRecognizer alloc] initWithTarget:self action:@selector(triggerWhatsInApp:)] autorelease];
            triggerGestureRecognizer.numberOfTouchesRequired = 2;
            [window addGestureRecognizer:triggerGestureRecognizer];
        }
    }
}

- (void)triggerWhatsInApp : (UITapGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        if(!keyWindow) return;
        UIViewController * rootViewController = keyWindow.rootViewController;
        if(!rootViewController) return;
        UIViewController * presentViewController = rootViewController.presentedViewController;
        if(presentViewController && (presentViewController == self.whatsInAppController)){
            [self.whatsInAppController dismissViewControllerAnimated:YES completion:0];
        }else{
            WIAViewController * viewController = [[WIAViewController alloc] initWithXibInBundle];
            UINavigationController * navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
            [navigationController.navigationBar setTranslucent:YES];
            [viewController release];
            [rootViewController presentViewController:navigationController animated:YES completion:0];
            self.whatsInAppController = navigationController;
        }
    }
}

- (void)releaseResource
{
    [_whatsInAppController release];
}

- (void)dealloc
{
    [self releaseResource];
    [super dealloc];
}

@end

@implementation WhatsInApp (ConsoleDisplay)

+ (void)showUserDefaults
{
    [WIAppUserDefaultsModule displayInConsole];
}

+ (void)showKeyChain
{
    [WIAppKeyChainModule displayInConsole];
}

+ (void)showLocalNotification
{
    [WIAppLocalNotificationModule displayInConsole];
}

+ (void)setAssistantLogOff: (BOOL)off
{
    [[WhatsInApp sharedInstance] setAssistantLogOn:!off];
}

+ (BOOL)isLAssistantLogOn
{
    return [[WhatsInApp sharedInstance] isAssistantLogOn];

}



@end




















