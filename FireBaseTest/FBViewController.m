//
//  FBViewController.m
//  FireBaseTest
//
//  Created by Apple on 10/12/2017.
//  Copyright © 2017 com.spcarlin. All rights reserved.
//

#import "FBViewController.h"
@import Firebase;
@interface FBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *promoButton;
@property (nonatomic) FIRRemoteConfig * rConfig;
@end

@implementation FBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FIRAnalytics logEventWithName:kFIREventViewItem parameters:@{kFIRParameterItemID : @"FBViewControllerViewed"}];
    _rConfig = [FIRRemoteConfig remoteConfig];

    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
    
    [_rConfig setConfigSettings:remoteConfigSettings];
}
- (IBAction)promoTouched:(id)sender {
}
- (IBAction)buttonOneTouched:(id)sender {
    NSLog(@"button one tapped");
    [FIRAnalytics logEventWithName:@"button1Click" parameters:nil];
}
- (IBAction)buttonTwoTouched:(id)sender {
    NSLog(@"button two tapped");
    [FIRAnalytics logEventWithName:@"button2Click" parameters:nil];

}
- (IBAction)buyTouched:(id)sender {
    [FIRAnalytics logEventWithName:kFIREventEcommercePurchase parameters:@{kFIRParameterItemID : @"EcommerceBuyTapped"}];
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

@end
