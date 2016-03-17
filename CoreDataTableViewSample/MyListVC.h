//
//  MyListVC.h
//  CoreDataTableViewSample
//
//  Created by design_offshore on 6/30/14.
//  Copyright (c) 2014 Design offshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addVC.h"

#import "AppDelegate.h"
@interface MyListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property(nonatomic,strong)NSMutableArray *myList;
@property(nonatomic,strong)UIRefreshControl *refresh;
@property(nonatomic,strong)UIToolbar *toolbar;
@property(nonatomic,strong)UIButton *EditButton;
@property(nonatomic,strong)UIButton *DoneButton;

@end
