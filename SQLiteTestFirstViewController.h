//
//  SQLiteTestFirstViewController.h
//  SQLiteTest
//
//  Created by Yingyi Dai on 12-10-25.
//  Copyright (c) 2012年 SCUT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFilename @"data.sqlite3"

@interface SQLiteTestFirstViewController : UIViewController {
    UITextField *recordField1;
    
    UIButton *submitBtn;
}

@property (nonatomic, retain) IBOutlet UITextField *recordField1;


@property (nonatomic, retain) IBOutlet UIButton *submitBtn;

- (IBAction)touchBg:(id)sender;

- (IBAction)submitBtnPressed:(id)sender;

- (NSString *)dataFilePath;

@end
