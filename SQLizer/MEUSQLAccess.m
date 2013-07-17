/*
 MEUSQLAccess.m
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
#import "MEUSQLAccess.h"

@implementation MEUSQLAccess
+ (BOOL) executeSQLiteQueryOnDatabase:(NSString *)pathToDatabase
                            queryLine:(NSString *)sqlQuery
                            withError:(NSError **)error {
    return FALSE;
}

+ (NSArray *) executeSQLiteSelectQueryOnDatabase:(NSString *)pathToDatabase
                                       queryLine:(NSString *)selectQuery
                                       withError:(NSError **)error {
    return NULL;
}


- (id)initWithDatabase:(NSString *)pathToDatabase {
    if (![super init]) {
        return nil;
    }
    
    databasePath = pathToDatabase;
    return self;
}

- (BOOL) executeSQLQuery:(NSString *)sqlQuery
               withError:(NSError **)error {
    // Create a new Task
    NSTask *task = [[NSTask alloc] init];
    
    // Prepare task to run
    // Run sqlite3, until we use the libraries
    [task setLaunchPath:@"/usr/bin/sqlite3"];
    // Set Arguments
    NSArray *debugArray = [NSArray arrayWithObjects:databasePath, sqlQuery, nil];
    NSLog(@"Using Array: %@", debugArray);
    [task setArguments:[NSArray arrayWithObjects:databasePath, sqlQuery, nil]];
    // Run in ~/Library/Application\ Support
    NSError *nerror;
    NSString *appSupportDir = [[[[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&nerror] path] stringByAppendingString:@"/SQLizer"];
    [task setCurrentDirectoryPath:appSupportDir];
    NSPipe *errPipe = [[NSPipe alloc] init];
    [task setStandardError:errPipe];
    
    // Execute Task
    [task launch];
    
    NSData *errData = [[errPipe fileHandleForReading] readDataToEndOfFile];
//    // Wait until sqlite3 has finished the Task
    [task waitUntilExit];

    if ([task terminationStatus] != 0) {
        NSString *errorMessage = [[NSString alloc] initWithData:errData encoding:NSUTF8StringEncoding];
        NSLog(@"!! %@", errorMessage);
        NSAlert *alert = [NSAlert alertWithMessageText:@"Could not execute SQL Command"
                        defaultButton:@"OK"
                      alternateButton:NULL
                          otherButton:NULL
            informativeTextWithFormat:@"%@",errorMessage];
        [alert runModal];
    }
    return [task terminationStatus] == 0;
}

- (NSArray *) executeSQLiteSelectQuery:(NSString *)selectQuery
                             withError:(NSError **)error {
    return NULL;
}


@end
