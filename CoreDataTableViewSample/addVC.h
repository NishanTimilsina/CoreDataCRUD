//
//  addVC.h
//  CoreDataTableViewSample
//
//  Created by design_offshore on 6/30/14.
//  Copyright (c) 2014 Design offshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface addVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *FullnametextField;
- (IBAction)addAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *DisplatLabel;

@end
