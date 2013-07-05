//
//  MEUMainController.h
//  SQLizer
//
//  Created by Dirk on 05.07.13.
//  Copyright (c) 2013 Dirk "26thmeusoc" Braun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEUMainController : NSObject
/*!
 * Fill TableView with Objects.
 *
 * \todo Requires Implementation
 *
 * \param aTableView NSTableView requesting Items
 * \param tableColumn Column requesting refreshed Items
 * \param row Row requesting refreshed items
 */
-(void)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
             row:(NSInteger)row;

/*!
 * Return number of lines required in TableView
 * 
 * \todo Requires Implementation
 *
 * \param tableView TableView requesting number of Lines
 */
-(int)numberOfRowsInTableView:(NSTableView *)tableView;
@end
