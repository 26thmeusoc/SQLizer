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
    NSLog(@"Row is: %@",rowBlock);
    if (![super init]) {
        return nil;
    }
    NSMutableArray *contentRowBuffer = [[NSMutableArray alloc] init];
    NSMutableArray *headerBuffer = [[NSMutableArray alloc] init];
    NSArray *columnBuffer = [rowBlock componentsSeparatedByString:@"\n"];
    NSLog(@"Current Row is: %@", columnBuffer);
    NSArray *rContents = [[NSArray alloc] init];
    NSMutableDictionary *contentsBuffer = [[NSMutableDictionary alloc] init];
    for (NSUInteger i = 0; i < [columnBuffer count]; i++) {
        NSString *row = [[columnBuffer objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"Processing Row: %@", row);
        if ([row compare:@""] != NSOrderedSame){
            rContents = [row componentsSeparatedByString:@" = "];
            [contentsBuffer setValue:[rContents objectAtIndex:1] forKey:[rContents objectAtIndex:0]];
            [contentRowBuffer addObject:[rContents objectAtIndex:1]];
            [headerBuffer addObject:[rContents objectAtIndex:0]];
        }
        
    }
    contents = [NSDictionary dictionaryWithDictionary:contentsBuffer];
#if DEBUG
    NSLog(@"Dict is: %@", contents);
#endif
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
    return NULL;
}

- (NSArray *)resultHeader {
    return NULL;
}

- (int)numberOfColumns {
    return 1;
}
@end
