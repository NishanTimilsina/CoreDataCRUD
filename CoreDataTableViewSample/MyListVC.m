//
//  MyListVC.m
//  CoreDataTableViewSample
//
//  Created by design_offshore on 6/30/14.
//  Copyright (c) 2014 Design offshore. All rights reserved.
//

#import "MyListVC.h"

@interface MyListVC (){
    NSManagedObjectContext *context;
    int count;
    
}

@end

@implementation MyListVC
@synthesize mytable,refresh,toolbar,EditButton,DoneButton;
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
    count=0;
    _myList=[[NSMutableArray alloc]init];
    AppDelegate *delegate=[[UIApplication sharedApplication]delegate];
    context=[delegate managedObjectContext];
    
    //remove extra seperator
    self.mytable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    //for refresh
    self.refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshButton) forControlEvents:UIControlEventValueChanged];
    [self.mytable addSubview:self.refresh];
    //call for listingtable
    [self sqlliteFuncion];
    //create add button
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setFrame:CGRectMake(275.0, 5.0, 30.0, 30.0)];
    //button.tag = section;
    button.hidden = NO;
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(addValue) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem  *infoItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [buttons addObject:infoItem];
    
    // put the buttons in the toolbar and release them
    [toolbar setItems:buttons animated:NO];
    self.navigationItem.rightBarButtonItems = buttons;
    
    
    EditButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [EditButton setFrame:CGRectMake(0, 0, 60, 32)];
    [EditButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [EditButton setTitle:@"Edit" forState:UIControlStateNormal];
    [EditButton addTarget:self action:@selector(Edit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc]initWithCustomView:EditButton];
    
    self.navigationItem.leftBarButtonItem = btnRight;
    
   
    // Do any additional setup after loading the view from its nib.
}
-(void)Done{
    self.mytable.editing=NO;
    EditButton.hidden=NO;
    EditButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [EditButton setFrame:CGRectMake(0, 0, 60, 32)];
    [EditButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [EditButton setTitle:@"Edit" forState:UIControlStateNormal];
    [EditButton addTarget:self action:@selector(Edit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc]initWithCustomView:EditButton];
    
    self.navigationItem.leftBarButtonItem = btnRight;

}
-(void)Edit{
    EditButton.hidden=YES;
    DoneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [DoneButton setFrame:CGRectMake(0, 0, 90, 32)];
   // [DoneButton setHidden:YES];
    [DoneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [DoneButton setTitle:@"Done" forState:UIControlStateNormal];
    [DoneButton addTarget:self action:@selector(Done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnRight1 = [[UIBarButtonItem alloc]initWithCustomView:DoneButton];
    self.navigationItem.leftBarButtonItem = btnRight1;
  //  DoneButton.hidden=NO;
    self.mytable.editing = YES;
    
}
-(void)refreshButton{
    [_myList removeAllObjects];
    
    [self.refresh endRefreshing];
    [self sqlliteFuncion];
    [mytable reloadData];

}
-(void)sqlliteFuncion{
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Mytable" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:YES];
   // [request setPropertiesToFetch:@[@"fullName"]];
    NSError *error;
    NSArray *array= [context executeFetchRequest:request error:&error];
    NSLog(@"myarray:%@",array);
    for(NSManagedObject *obj in array){
        NSString *name=[obj valueForKey:@"fullName"];
        NSLog(@"name:%@",name);
        [_myList addObject:name];
        
        // [self.mytab]
    }
    NSLog(@"array:%@",_myList);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addValue{
    addVC *add=[[addVC alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_myList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =[_myList objectAtIndex:indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        NSEntityDescription *entity=[NSEntityDescription entityForName:@"Mytable" inManagedObjectContext:context];
        NSFetchRequest *request=[[NSFetchRequest alloc]init];
        [request setEntity:entity];
        NSPredicate *predict=[NSPredicate predicateWithFormat:@"fullName like %@",[_myList objectAtIndex:indexPath.row]];
        [request setPredicate:predict];
        NSError *error;
        NSArray *matchingdata= [context executeFetchRequest:request error:&error];
        if([matchingdata count]<=0){
            //_DisplatLabel.text=@"no person found";
        }
        else{
            for(NSManagedObject *obj in matchingdata){
                [context deleteObject:obj];
            }
           // self.DisplatLabel.text=[NSString stringWithFormat:@"%d is delete",firstnameTextField.text];
            [context save:&error];
        }
        

        [_myList removeObjectAtIndex:indexPath.row];
        //[BookMarkArray remo]
        //BookMarkArray=listVC;
        [mytable reloadData];
        
        
        
    }
}


@end
