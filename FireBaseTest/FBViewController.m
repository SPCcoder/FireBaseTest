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
@property (nonatomic) FIRRemoteConfig * remoteConfig;
@end

@implementation FBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FIRAnalytics logEventWithName:kFIREventViewItem parameters:@{kFIRParameterItemID : @"FBViewControllerViewed"}];
    self.remoteConfig = [FIRRemoteConfig remoteConfig];

    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
    
    [self.remoteConfig setConfigSettings:remoteConfigSettings];
    
    //load defaults from plist
    [self.remoteConfig setDefaultsFromPlistFileName:@"FBSettings"];
    
    [self checkPromoEnabled];
}
- (void)checkPromoEnabled {
    double cacheExpireTime = 3600;
    if (self.remoteConfig.configSettings.isDeveloperModeEnabled){// indebug we always want live server
        cacheExpireTime = 0;
    }
    
    //fetch defaults from server
    [self.remoteConfig fetchWithExpirationDuration: cacheExpireTime completionHandler:^(FIRRemoteConfigFetchStatus status, NSError * _Nullable error) {
        if (status == FIRRemoteConfigFetchStatusSuccess){
            //fetch worked
            [self.remoteConfig activateFetched];
        } else {
            // error
        }
        [self showPromoButton];
    }];
}
-(void)showPromoButton {
    NSString *promoButtonString = [self.remoteConfig configValueForKey:@"promo_message"].stringValue;
    BOOL showButtonBool = [self.remoteConfig configValueForKey:@"promo_enabled"].boolValue;
    NSLog(@" show button:%s, with string: %@", showButtonBool ? "true" : "false", promoButtonString);
    self.promoButton.hidden = !showButtonBool;
    [self.promoButton setTitle:promoButtonString forState: normal];

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
