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

#import <Foundation/Foundation.h>

@interface MEUSQLResultRow : NSObject {
    NSArray *columnsContent;
    NSArray *columnTitles;
    NSDictionary *contents;
}

/*!
 * Creates a now MEUSQLResultRow Object with given columnTitles and Content.
 *
 * \param rowBlock A block of Rows returned by sqlite3 CLI Tool, which represents a single Databaserow
 * \return An initialized MEUSQLResultRow Object
 */
- (id) resultRowWithRowBlock:(NSString *)rowBlock;

/*!
 * Returns a list of all Columntitles of selected Rows.
 *
 * \return List of all Columntitles
 */
- (NSArray *) resultColumns;

/*!
 *
 */
- (NSArray *) resultHeader;

/*!
 * Returns number of Columns.
 *
 * \return Number of Columns
 */
- (NSUInteger) numberOfColumns;

/*!
 * Returns a NSDictionary, containing all Elements of Databaserow
 *
 * \return Dictionaryobject of Databaserow Columns
 */
- (NSDictionary *)contentsDictionary;
@end
