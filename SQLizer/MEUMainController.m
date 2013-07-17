/*
 MEUMainController.m 
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

#import "MEUMainController.h"

@implementation MEUMainController

- (id)init {
    if (![super init]) {
        return nil;
    }
    
    sqlRows = [[NSArray alloc] init];
    return self;
}

-(id) tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
           row:(NSInteger)row {
    return NULL;
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [sqlRows count];
}

-(IBAction)inputField:(id)sender {
    NSError *nerror;
    
    // Get Path to ~/Library/Appliction Support/
    NSURL *appSupportDir = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&nerror];
    // Get Path to ~/Library/Application Support/SQLizer
    // TODO Do this in one step
    NSString *pathToDatabase = [[appSupportDir path] stringByAppendingString:@"/SQLizer/SQLizer.db"];
#if DEBUG
    NSLog(@"Using Database: %@", pathToDatabase);
#endif
    
    // Prepare Databaseaccess
    MEUSQLAccess *sqlAccess = [[MEUSQLAccess alloc] initWithDatabase:pathToDatabase];
    
    // Get SQL Query
    NSString *sqlCommand = [[textField stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // We need to check if a SELECT Query has been requested, so get first word in Query
    NSArray *commandComponents = [sqlCommand componentsSeparatedByString:@" "];
    // SELECT Query?
    if ([[commandComponents objectAtIndex:0] caseInsensitiveCompare:@"select"] == NSOrderedSame) {
        // Yes.
#if DEBUG
        NSLog(@"Select statement detected.");
#endif
        // Run Query, set Array of Results so we can update our tableview
        NSArray *resultArray = [sqlAccess executeSQLiteSelectQuery:sqlCommand withError:&nerror];
        if (resultArray != NULL) {
            sqlRows = resultArray;
        }
    } else {
        // No, some other command has been requested. Execute it and check result
        bool result = [sqlAccess executeSQLQuery:sqlCommand withError:&nerror];
        
        // Everything okay?
        if (!result) {
            // No.
            NSLog(@"Could not execute: %@", sqlCommand);
        }
#if DEBUG
        else {
            NSLog(@"Executed: %@", sqlCommand);
        }
#endif
    }
    
    // Did everything work?
    
}
@end
