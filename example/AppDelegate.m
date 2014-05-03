//
//  AppDelegate.m
//  example
//
//  Created by shoguncao on 13-9-30.
//  Copyright (c) 2013年 shoguncao. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImage+ex.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/resource"];
    fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    for (NSString *str in fileList) {
        if (NSNotFound != [str rangeOfString:@".png"].location) {
            NSString *temPath = [NSString stringWithFormat:@"resource/%@",str];
            UIImage *img = [UIImage imageNamed:temPath];
            NSString *path = [str stringByDeletingPathExtension];
            path = [path stringByAppendingString:@"_green.png"];
            path = [NSString stringWithFormat:@"/Users/caoshougang/shoguncao/customImage/example/out/%@", path];
            if (img) {
                img = [img grayImageRed:0 green:200 blue:0];
                NSData *data = UIImagePNGRepresentation(img);
                [data writeToFile:path atomically:YES];
            }
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
