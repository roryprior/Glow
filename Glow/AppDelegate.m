//
//  AppDelegate.m
//  Glow
//
//  Created by Rory Prior on 27/11/2014.
//  Copyright (c) 2014 ThinkMac Software. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize
{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  [dict setObject: [NSNumber numberWithFloat: [[UIScreen mainScreen] brightness]] forKey: UserBrightnessKey];
  [dict setObject: [NSNumber numberWithFloat: 0.5] forKey: GlowBrightnessKey];
  [dict setObject: [NSNumber numberWithFloat: 1.0] forKey: GlowColourTempKey];
  [[NSUserDefaults standardUserDefaults] registerDefaults: dict];
  [[NSUserDefaults standardUserDefaults] synchronize];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setFloat: [[UIScreen mainScreen] brightness] forKey: UserBrightnessKey];
  [[UIScreen mainScreen] setBrightness: [defaults floatForKey: GlowBrightnessKey]];
  [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [[UIScreen mainScreen] setBrightness: [defaults floatForKey: UserBrightnessKey]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [[UIScreen mainScreen] setBrightness: [defaults floatForKey: UserBrightnessKey]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setFloat: [[UIScreen mainScreen] brightness] forKey: UserBrightnessKey];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [[UIScreen mainScreen] setBrightness: [defaults floatForKey: GlowBrightnessKey]];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [[UIScreen mainScreen] setBrightness: [defaults floatForKey: UserBrightnessKey]];
}

@end
