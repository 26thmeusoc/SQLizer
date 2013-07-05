//
//  MEUAppDelegate.h
//  SQLizer
//
//  Created by Dirk on 05.07.13.
//  Copyright (c) 2013 Dirk "26thmeusoc" Braun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MEUAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

/*!
 * When main Window is closed, quit Application
 * 
 * \param sender Application to be closed
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;

@end
