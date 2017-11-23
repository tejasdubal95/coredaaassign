//
//  ProcessDataViewController.m
//  coreDataAssignment
//
//  Created by Student P_10 on 22/11/17.
//  Copyright © 2017 vaishnavifelixprogram. All rights reserved.
//

#import "ProcessDataViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface ProcessDataViewController ()

@end

@implementation ProcessDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tf1 becomeFirstResponder];


    [self fetch];


}
-(void)fetch
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSError *error;
    NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    self.allObjects=[context executeFetchRequest:request error:&error];
    if(self.allObjects.count >0)
    {
        myobject=[self.allObjects firstObject];
        NSString *name,*rate;
        name=[myobject valueForKey:@"itemName"];
        self.tf1.text=[myobject valueForKey:@"itemName"];
        //id object=[myobject valueForKey:@"itemRate"];
        rate=[myobject valueForKey:@"itemID"];
        self.tf2.text=[NSString stringWithFormat:@"%@",rate];
    }
    else{
    }
    NSLog(@"%@",self.allObjects);
    self.itemNameArray=[self.allObjects valueForKey:@"itemName"];
    self.itemRateArray=[self.allObjects valueForKey:@"itemID"];
    NSLog(@"NamesArray:%@",self.itemNameArray);
    NSLog(@"itemRateArray:%@",self.itemRateArray);
    //[self.myTableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
//    ViewController *vc = [[ViewController alloc]init];
//
//    vc.name = [NSMutableArray arrayWithArray:self.itemNameArray];
//    vc.rate = [NSMutableArray arrayWithArray:self.itemRateArray];
//    
//    [_delegate sendDataToA:self.itemNameArray];
    
   
}



- (IBAction)deleteItem:(id)sender {
    [self deleteObject]
    ;
    NSLog(@"Core Data-Delete:Success");
    [self fetch];
    
}

- (IBAction)saveItem:(id)sender {
    [self insertObject];
    NSLog(@"Core Data-Insert:Success");
    [self fetch];
}

- (IBAction)updateItem:(id)sender {
    
    [self updateObject];
    NSLog(@"Update:Success");
    [self fetch];
}

- (IBAction)showTable:(id)sender {
    [self performSegueWithIdentifier:@"tablesegue" sender:sender];
    
}




-(void)updateObject
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd] %@)",self.tf1.text];
    NSError *error;
    //NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    [request setPredicate:namePredicate];
    NSArray *allObjects=[context executeFetchRequest:request error:&error];
    if(allObjects.count==1)
    {
        NSManagedObject  *myobject=[allObjects firstObject];
        NSString *name,*rate;
        name=self.tf1.text;
        rate=self.tf2.text;
        NSNumberFormatter *f=[[NSNumberFormatter alloc]init];
        f.numberStyle=NSNumberFormatterDecimalStyle;
        NSNumber *myNumber= [f numberFromString: self.tf2.text];
        [myobject setValue:name forKey:@"itemName"];
        [myobject setValue:myNumber forKey:@"itemID"];
        [context save:&error];
    }
    else{
        
    }
}

-(void)deleteObject
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd] %@)",self.tf2.text];
    NSError *error;
    NSManagedObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    [request setPredicate:namePredicate];
    NSArray *allObjects=[context executeFetchRequest:request error:&error];
    if(allObjects.count>=1)
    {
        myobject=[allObjects firstObject];
        [context deleteObject:myobject];
    }
    else{
        NSLog(@"Deletion Failed");
    }
    }
-(void)insertObject
{
    NSError *error;
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSManagedObject *Object=[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    [Object setValue:self.tf1.text forKey:@"itemName"];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:self.tf2.text];
    [Object setValue:myNumber forKey:@"itemID"];
    [context save:&error];
    self.tf1.text=@"";
    self.tf2.text=@"";
    
}

-(bool)textFieldShouldReturn:(UITextField *)textField
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[delegate managedObjectContext];
    NSError *error;
    NSObject *myobject;
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    if(textField.text.length>0)
    {
        NSPredicate *namePredicate=[NSPredicate predicateWithFormat:@"(itemName contains[cd]      %@)",textField.text];
        [request setPredicate:namePredicate];
    }
    self.allObjects=[context executeFetchRequest:request error:&error];
    if(self.allObjects.count >0)
    {
        myobject=[self.allObjects firstObject];
        NSString *name,*rate;
        name=[myobject valueForKey:@"itemName"];
        self.tf1.text=[myobject valueForKey:@"itemName"];
        //id object=[myobject valueForKey:@"itemRate"];
        rate=[myobject valueForKey:@"itemID"];
        self.tf2.text=[NSString stringWithFormat:@"%@",rate];
    }
    else{
    }
    NSLog(@"%@",self.allObjects);
    self.itemNameArray=[self.allObjects valueForKey:@"itemName"];
    self.itemRateArray=[self.allObjects valueForKey:@"itemID"];
    NSLog(@"NamesArray:%@",self.itemNameArray);
    NSLog(@"itemRateArray:%@",self.itemRateArray);
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"tablesegue"])
    {
        // Get reference to the destination view controller
        ViewController *vc = [segue destinationViewController];
        vc.name = [NSArray arrayWithArray:_itemNameArray];
        vc.rate = [NSArray arrayWithArray:_itemRateArray];
        // Pass any objects to the view controller here, like...
    
    }
}
@end
