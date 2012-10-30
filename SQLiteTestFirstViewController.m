//
//  SQLiteTestFirstViewController.m
//  SQLiteTest
//
//  Created by Yingyi Dai on 12-10-25.
//  Copyright (c) 2012年 SCUT. All rights reserved.
//

#import "SQLiteTestFirstViewController.h"
#import <sqlite3.h>

@interface SQLiteTestFirstViewController ()

@end

@implementation SQLiteTestFirstViewController

@synthesize recordField1;


@synthesize submitBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Input", @"Input");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    sqlite3 *database;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    
    char* errorMsg;
    NSString *createSQL = @"create table if not exists SCORE (score INTEGER);";
    
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"error creating table :%s", errorMsg);
    }
    
    sqlite3_close(database);
    
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

- (void)touchBg:(id)sender
{
    [recordField1 resignFirstResponder];

}

- (void)submitBtnPressed:(id)sender
{
    sqlite3 *database;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    
    if (recordField1.text.length != 0) {
        NSString *insert = [[NSString alloc] initWithFormat:@"INSERT INTO SCORE (SCORE ) VALUES ('%d');",recordField1.text.intValue];
        
        char* errorMsg;
        if (sqlite3_exec(database, [insert UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) 
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to insert");
        }
    }
    
    sqlite3_close(database);
    
}

- (NSString *)dataFilePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:kFilename];
}

@end
