//
//  AppDelegate.h
//  CoreDataTableViewSample
//
//  Created by design_offshore on 6/30/14.
//  Copyright (c) 2014 Design offshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyListVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
