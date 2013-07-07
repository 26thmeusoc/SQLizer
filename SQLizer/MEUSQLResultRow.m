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
- (id)resultRowWithColumns:(NSArray *)columnTitles
             columnContent:(NSArray *)columnContent {
    if ([super init]) {
        return nil;
    }
    
    return self;
}

- (NSArray *)resultColumns {
    return NULL;
}

- (NSArray *)resultHeader {
    return NULL;
}

- (int)numberOfColumns {
    return NULL;
}
@end
