//
//  EcommerceViewController.m
//  FireBaseTest
//
//  Created by Apple on 10/12/2017.
//  Copyright © 2017 com.spcarlin. All rights reserved.
//

#import "EcommerceViewController.h"
@import Firebase;
@interface EcommerceViewController ()

@end

@implementation EcommerceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FIRAnalytics logEventWithName:kFIREventViewItem parameters:@{kFIRParameterItemID : @"EcommerceViewed"}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//line for ibaction buy button
//     [FIRAnalytics logEventWithName:kFIREventEcommercePurchase parameters:@{kFIRParameterItemID : @"EcommerceBuyTapped"}];

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
