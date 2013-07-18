/*
 MEUAppDelegate.m
 Copyright (C) 2013  Dirk "26thmeusoc" Braun
 
 This file is part of SQLizer.
 
 SQLizer is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 SQLizer is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with SQLizer.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "MEUAppDelegate.h"

@implementation MEUAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Our Folder in ~/Library/Applcation Support exists?
    NSError *nerror;
    NSURL *appSupportDir = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&nerror];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathToFolder = [[appSupportDir path] stringByAppendingString:@"/SQLizer"];
#if DEBUG
    NSLog(@"Checking for Appliction Support Folder at %@", pathToFolder);
#endif
    BOOL isDir;
    BOOL result = [fileManager fileExistsAtPath:pathToFolder isDirectory:&isDir];
    if (result == FALSE ) {
#if DEBUG
        NSLog(@"Application Supportfolder does not exist, creating one.");
#endif
        NSError *error;
        [fileManager createDirectoryAtPath:pathToFolder withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    // Exit Application after last Window has been Closed
    return YES;
}
@end
