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
    // TODO Needs implementation
    return FALSE;
}

+ (NSArray *) executeSQLiteSelectQueryOnDatabase:(NSString *)pathToDatabase
                                       queryLine:(NSString *)selectQuery
                                       withError:(NSError **)error {
    // TODO Needs implementation
    return NULL;
}


- (id)initWithDatabase:(NSString *)pathToDatabase {
    if (![super init]) {
        return nil;
    }
    
    // Set Path to Database
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
#if DEBUG
    NSLog(@"Using Array: %@", debugArray);
#endif
    [task setArguments:debugArray];
    // Run in ~/Library/Application\ Support/SQLizer
    NSError *nerror;
    NSString *appSupportDir = [[[[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&nerror] path] stringByAppendingString:@"/SQLizer"];
    [task setCurrentDirectoryPath:appSupportDir];
    
    // We need to get output, in case an error happens
    NSPipe *errPipe = [[NSPipe alloc] init];
    [task setStandardError:errPipe];
    
    // Execute Task
    [task launch];
    
    // Read Pipes when Operation is finished
    NSData *errData = [[errPipe fileHandleForReading] readDataToEndOfFile];
    // Wait until sqlite3 has finished the Task
    [task waitUntilExit];

    if ([task terminationStatus] != 0) {
        // Something went wrong. Show an errormessage
        NSString *errorMessage = [[NSString alloc] initWithData:errData encoding:NSUTF8StringEncoding];
        NSLog(@"!! %@", errorMessage);
        NSAlert *alert = [NSAlert alertWithMessageText:@"Could not execute SQL Command"
                        defaultButton:@"OK"
                      alternateButton:NULL
                          otherButton:NULL
            informativeTextWithFormat:@"%@",errorMessage];
        [alert runModal];
        
        // TODO set NSError
    }
    return [task terminationStatus] == 0;
}

/*!
 * Generate an Array of MEUSQLResultrows from sqlite3 CLI-Tool Result. Result must be generated using -line option
 *
 * \param resultText Text returned by sqlite3
 * \return Array of MEUSQLResultRow Objects, containing results in resultText
 */
- (NSArray *) generateArrayOfRows:(NSString *)resultText {
    // Separate Database Lines
    NSArray *sqlResultRows = [resultText componentsSeparatedByString:@"\n\n"];
    // Create a Buffer
    NSMutableArray *lineBuffer = [[NSMutableArray alloc] initWithCapacity:1];
#if DEBUG
    NSLog(@"Got %lu rows",[sqlResultRows count]);
#endif
    // Create a MEUSQLResultRow Object for each row
    for (NSUInteger i = 0; i < [sqlResultRows count]; i++) {
        [lineBuffer addObject:[[MEUSQLResultRow alloc] resultRowWithRowBlock:[sqlResultRows objectAtIndex:i]]];
    }
    return  [NSArray arrayWithArray:lineBuffer];
}

- (NSArray *) executeSQLiteSelectQuery:(NSString *)selectQuery
                             withError:(NSError **)error {
    NSTask *task = [[NSTask alloc] init];
    
    // Prepare task to run
    // Run sqlite3, until we use the libraries
    [task setLaunchPath:@"/usr/bin/sqlite3"];
    // Set Arguments
    NSArray *debugArray = [NSArray arrayWithObjects:@"-line", databasePath, selectQuery, nil];
#if DEBUG
    NSLog(@"Using Array: %@", debugArray);
#endif
    [task setArguments:debugArray];
    // Run in ~/Library/Application\ Support/SQLizer
    NSError *nerror;
    NSString *appSupportDir = [[[[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&nerror] path] stringByAppendingString:@"/SQLizer"];
    [task setCurrentDirectoryPath:appSupportDir];
    
    // We need to get output, in case an error happens
    NSPipe *errPipe = [[NSPipe alloc] init];
    [task setStandardError:errPipe];
    NSPipe *outPipe = [[NSPipe alloc] init];
    [task setStandardOutput:outPipe];
    
    // Execute Task
    [task launch];
    
    // Read Pipes when Operation is finished
    NSData *errData = [[errPipe fileHandleForReading] readDataToEndOfFile];
    NSData *outData = [[outPipe fileHandleForReading] readDataToEndOfFile];
    // Wait until sqlite3 has finished the Task
    [task waitUntilExit];
    
    if ([task terminationStatus] != 0) {
        // Something went wrong. Show an errormessage
        NSString *errorMessage = [[NSString alloc] initWithData:errData encoding:NSUTF8StringEncoding];
        NSLog(@"!! %@", errorMessage);
        NSAlert *alert = [NSAlert alertWithMessageText:@"Could not execute SQL Command"
                                         defaultButton:@"OK"
                                       alternateButton:NULL
                                           otherButton:NULL
                             informativeTextWithFormat:@"%@",errorMessage];
        [alert runModal];
        
        // TODO set NSError
        return NULL;
    }
    return [self generateArrayOfRows:[[NSString alloc] initWithData:outData encoding:NSUTF8StringEncoding]];
}

@end
