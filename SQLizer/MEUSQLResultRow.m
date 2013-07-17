/*
 MEUSQLResultRow.h
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

#import "MEUSQLResultRow.h"

@implementation MEUSQLResultRow
- (id) resultRowWithRowBlock:(NSString *)rowBlock {
#if DEBUG
    NSLog(@"Row is: %@",rowBlock);
#endif
    // Run Superclass initialiser
    if (![super init]) {
        return nil;
    }
    
    // Create some buffers
    NSMutableArray *contentRowBuffer = [[NSMutableArray alloc] init]; // Remember content for each column in this row
    NSMutableArray *headerBuffer = [[NSMutableArray alloc] init]; // Remember Column Headers
    // Create an array containing header and content of column
    NSArray *columnBuffer = [rowBlock componentsSeparatedByString:@"\n"];
    // Buffer only contents of this row here
    NSArray *rContents = [[NSArray alloc] init];
    // Prepare a Dictionarybuffer
    NSMutableDictionary *contentsBuffer = [[NSMutableDictionary alloc] init];
    
    // Go through every line in this block and prepare the objects
    for (NSUInteger i = 0; i < [columnBuffer count]; i++) {
        // Remove trailing whitespaces
        NSString *row = [[columnBuffer objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
#if DEBUG
        NSLog(@"Processing Row: %@", row);
#endif
        // Make sure, we won't process an empty line.
        if ([row compare:@""] != NSOrderedSame){
            // Separate line at equality sign
            rContents = [row componentsSeparatedByString:@" = "];
            
            // Add content to Dictionary
            [contentsBuffer setValue:[rContents objectAtIndex:1] forKey:[rContents objectAtIndex:0]];
            // Add content to arrays
            [contentRowBuffer addObject:[rContents objectAtIndex:1]];
            [headerBuffer addObject:[rContents objectAtIndex:0]];
        }
        
    }
    
    // Save Dictionary
    contents = [NSDictionary dictionaryWithDictionary:contentsBuffer];
#if DEBUG
    NSLog(@"Dict is: %@", contents);
#endif
    // Save Arrays
    columnsContent = [NSArray arrayWithArray:contentRowBuffer];
#if DEBUG
    NSLog(@"\n Contents is: %@", columnsContent);
#endif
    columnTitles = [NSArray arrayWithArray:headerBuffer];
#if DEBUG
    NSLog(@"\n Header is: %@,", columnTitles);
#endif
    return self;
}

- (NSArray *)resultColumns {
    // TODO implement me
    return columnsContent;
}

- (NSArray *)resultHeader {
    // TODO implement me
    return columnTitles;
}

- (NSUInteger)numberOfColumns {
    return [columnTitles count];
}

- (NSDictionary *)contentsDictionary {
    return contents;
}
@end
