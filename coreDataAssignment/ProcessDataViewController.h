//
//  ProcessDataViewController.h
//  coreDataAssignment
//
//  Created by Student P_10 on 22/11/17.
//  Copyright © 2017 vaishnavifelixprogram. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol senddataProtocol <NSObject>

-(void)sendDataToA:(NSArray *)array;

@end
@interface ProcessDataViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tf1;
@property (strong, nonatomic) IBOutlet UITextField *tf2;
- (IBAction)deleteItem:(id)sender;
-(IBAction)updateItem:(id)sender;
- (IBAction)showTable:(id)sender;
-(IBAction)saveItem:(id)sender;

@property NSArray *allObjects;
@property NSArray *itemNameArray;
@property NSArray *itemRateArray;
@property(nonatomic,retain)id delegate;


@end
