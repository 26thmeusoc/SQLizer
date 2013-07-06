/*
 MEUSQLAccess.h
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

/*!
 * Used Access to a SQLite Database.
 */
@interface MEUSQLAccess : NSObject

/*!
 * Execute a SQL Query.
 * 
 * \warning Do not use SQL SELECT Queries with in this method, as it won't return any Items.
 * \param pathToDatabase Database, where SQL Operation will be executed on
 * \param sqlQuery SQL Query to execute
 */
+ (void) executeSQLiteQueryOnDatabase:(NSString *)pathToDatabase
                            queryLine:(NSString *)sqlQuery;

/*!
 * Execute a SQL Select Query. Returns a NSArray if Query could be executed.
 * On Error, this function returns null and sets error
 *
 * \param pathToDatabase Database, where SQL Operation will be executed on
 * \param selectQuery Query to execute
 * \param error NSError Pointer
 * \return Rows returned by Query.
 */
+ (NSArray *) executeSQLiteSelectQueryOnDatabase:(NSString *)pathToDatabase
                                      queryLine:(NSString *)selectQuery
                                       withError:(NSError **)error;

/*!
 * Checks if Last Operation was Successful
 *
 * \return TRUE if last Operation was executed successfully
 */
- (BOOL) resultOfOperation;
@end
