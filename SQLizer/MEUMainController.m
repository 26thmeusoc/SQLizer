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

-(id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
             row:(NSInteger)row {
    return NULL;
}


-(int)numberOfRowsInTableView:(NSTableView *)tableView {
    return 0;
}

-(IBAction)inputField:(id)sender {
    NSError *nerror;
    NSURL *appSupportDir = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&nerror];
    NSString *pathToDatabase = [[appSupportDir path] stringByAppendingString:@"/SQLizer/SQLizer.db"];
    NSLog(@"Using Database: %@", pathToDatabase);
    MEUSQLAccess *sqlAccess = [[MEUSQLAccess alloc] initWithDatabase:pathToDatabase];
    bool result = [sqlAccess executeSQLQuery:[textField stringValue] withError:&nerror];
    
    // Did everything work?
    if (result == YES) {
        NSLog(@"Executed: %@", [textField stringValue]);
    } else {
        NSLog(@"Could not execute");
    }
}
@end
