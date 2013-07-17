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
#import "MEUSQLResultSet.h"
#import "MEUSQLResultRow.h"

/*!
 * Used Access to a SQLite Database.
 */
@interface MEUSQLAccess : NSObject {
    NSString *databasePath;
}

/*!
 * Execute a SQL Query.
 * 
 * \warning Do not use SQL SELECT Queries with in this method, as it won't return any Items.
 * \param pathToDatabase Database, where SQL Operation will be executed on
 * \param sqlQuery SQL Query to execute
 * \param Pointer for NSError, which will return 
 * \return YES, if query was successfully executed, otherwise the function sets error and returns NO
 */
+ (BOOL) executeSQLiteQueryOnDatabase:(NSString *)pathToDatabase
                            queryLine:(NSString *)sqlQuery
                            withError:(NSError **)error;

/*!
 * Execute a SQL Select Query. Returns a NSArray if Query could be executed, otherwise null and sets error
 *
 * \param pathToDatabase Database, where SQL Operation will be executed on
 * \param selectQuery Query to execute
 * \param error NSError Pointer, which will contain Informations in case Query could not be executed
 * \return Rows returned by Query, null
 */
+ (NSArray *) executeSQLiteSelectQueryOnDatabase:(NSString *)pathToDatabase
                                      queryLine:(NSString *)selectQuery
                                       withError:(NSError **)error;

/*!
 * Initialises an MEUSSQLAccess Object with a given Path to Database
 *
 * \param pathToDatabase Path to a SQLite Database
 */
- (id)initWithDatabase:(NSString *)pathToDatabase;

/*!
 * Execute a SQL Query
 *
 * \warning Do not use SQL SELECT Queries with this method, as it won't return any Items
 * \param sqlQuery
 * \param error
 * \return YES, if query was successfully executed, otherwise the function sets error and returns NO
 */
- (BOOL) executeSQLQuery:(NSString *)sqlQuery
               withError:(NSError **)error;

/*!
 * Execute a SQL Select Query. Returns a NSArray if Query could be executed, otherwise null and sets error
 * 
 * \param selectQuery Query to execute
 * \param error NSError Pointer, which will contarn Informations in case Query could not be executed
 * \return Rows returned by Query, null
 */
- (NSArray *) executeSQLiteSelectQuery:(NSString *)selectQuery
                             withError:(NSError **)error;

@end
