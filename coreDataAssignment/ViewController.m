//
//  ViewController.m
//  coreDataAssignment
//
//  Created by Student P_10 on 22/11/17.
//  Copyright © 2017 vaishnavifelixprogram. All rights reserved.
//

#import "ViewController.h"
#import"ProcessDataViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ProcessDataViewController *pdvc=[[ProcessDataViewController alloc]init];
    //_name = [NSArray arrayWithArray:pdvc.itemNameArray];
    //_rate= [NSArray arrayWithArray:pdvc.itemRateArray];
    pdvc.delegate=self;
    NSLog(@"%@",self.name);

}
-(void)sendDataToA:(NSArray *)array
{
    self.name = array;// data will come here inside of ViewControllerA
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.name.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text=[self.name objectAtIndex:indexPath.row];
    id rate=[self.rate objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",rate];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ProcessDataViewController" bundle:nil];
    ProcessDataViewController *pdvc = (ProcessDataViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ProcessDataViewController"];

    //ProcessDataViewController *pdvc = [[ProcessDataViewController alloc]init];
    //pdvc.tf1.text = [self.name objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:pdvc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
