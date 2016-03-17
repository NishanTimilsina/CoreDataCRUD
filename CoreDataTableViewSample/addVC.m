//
//  addVC.m
//  CoreDataTableViewSample
//
//  Created by design_offshore on 6/30/14.
//  Copyright (c) 2014 Design offshore. All rights reserved.
//

#import "addVC.h"

@interface addVC (){
    NSManagedObjectContext *context;

}

@end

@implementation addVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *delegate=[[UIApplication sharedApplication]delegate];
    context=[delegate managedObjectContext];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(id)sender {
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Mytable" inManagedObjectContext:context];
    NSManagedObject *object=[[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    [object setValue:_FullnametextField.text forKey:@"fullName"];
    NSError *error;
    [context save:&error];
    _DisplatLabel.text=@"value added...";
    _FullnametextField.text=@"";
}
@end
