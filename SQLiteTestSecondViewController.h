//
//  SQLiteTestSecondViewController.h
//  SQLiteTest
//
//  Created by Yingyi Dai on 12-10-25.
//  Copyright (c) 2012年 SCUT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFilename @"data.sqlite3"

@interface SQLiteTestSecondViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>
{
    NSMutableArray *scoreArray;
}

@property (nonatomic, retain) NSMutableArray *scoreArray;
@property (retain, nonatomic) IBOutlet UITableView *table;


@end
