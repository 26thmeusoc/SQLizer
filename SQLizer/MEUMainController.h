/*
 MEUMainController.h
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
#import "MEUSQLAccess.h"

/*!
 * MEUMainController controls UI Items in Main Window.
 *
 * \since 0.1
 * \author Dirk "26thmeusoc" Braun
 * \copyright GNU Public License v3
 */
@interface MEUMainController : NSObject {
    IBOutlet NSTextField *textField;
    IBOutlet NSTableView *tableView;
    NSArray *sqlRows;
}
/*!
 * Fill TableView with Objects.
 *
 * \since 0.1
 *
 * \param aTableView NSTableView requesting Items
 * \param tableColumn Column requesting refreshed Items
 * \param row Row requesting refreshed items
 */
-(id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
             row:(NSInteger)row;

/*!
 * Return number of lines required in TableView
 * 
 * \since 0.1
 *
 * \param tableView TableView requesting number of Lines
 */
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

/*!
 * Refreshes Contents and columns of tableView.
 * Make sure sqlRows has been refreshed befor calling refreshTableView
 *
 * \since 0.1
 */
- (void)refreshTableView;

/*!
 * Execute SQL Query
 */
-(IBAction)inputField:(id)sender;
@end
