//
//  SQLiteTestSecondViewController.m
//  SQLiteTest
//
//  Created by Yingyi Dai on 12-10-25.
//  Copyright (c) 2012年 SCUT. All rights reserved.
//

#import "SQLiteTestSecondViewController.h"
#import <sqlite3.h>

@interface SQLiteTestSecondViewController ()

@end

@implementation SQLiteTestSecondViewController
@synthesize scoreArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"View", @"View");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        scoreArray = [[NSMutableArray alloc]init];
    }
    return self;
}
	

- (void)viewDidLoad
{
    scoreArray = [[NSMutableArray alloc]init];

    sqlite3 *database;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    
    char *select = "SELECT SCORE FROM SCORE ORDER BY SCORE DESC;";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, select, -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            char *score = (char*)sqlite3_column_text(stmt, 0);
            NSString *scoreString = [[NSString alloc] initWithUTF8String:score];
            
            [scoreArray addObject:scoreString];
        }
        sqlite3_finalize(stmt);
        
    }
    
    sqlite3_close(database);
    
    NSLog(@"hahah");
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSString *)dataFilePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:kFilename];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [scoreArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ScoreTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [scoreArray objectAtIndex:row];
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [scoreArray removeAllObjects];
    
    sqlite3 *database;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    
    char *select = "SELECT SCORE FROM SCORE ORDER BY SCORE DESC;";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, select, -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            char *score = (char*)sqlite3_column_text(stmt, 0);
            NSString *scoreString = [[NSString alloc] initWithUTF8String:score];
            
            [scoreArray addObject:scoreString];
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
}

- (void)dealloc {
    [super dealloc];
}
@end
