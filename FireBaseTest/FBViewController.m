//
//  FBViewController.m
//  FireBaseTest
//
//  Created by Apple on 10/12/2017.
//  Copyright © 2017 com.spcarlin. All rights reserved.
//

#import "FBViewController.h"
//constants
NSString * const kPromoClicked = @"promoClicked";
NSString * const kButton1Click = @"button1Click";
NSString * const kButton2Click = @"button2Click";
NSString * const kEcommerceBuyTapped = @"EcommerceBuyTapped";
NSString * const kPromo_message = @"promo_message";
NSString * const kPromo_enabled = @"promo_enabled";
NSString * const kFBSettings = @"FBSettings";

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
    [FIRAnalytics logEventWithName:kFIREventViewItem parameters:@{kFIRParameterItemID : @"FBViewControllerViewed"}]; // logs screen view
    self.remoteConfig = [FIRRemoteConfig remoteConfig];

    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];// so we get live server instead of waiting while developing
    
    [self.remoteConfig setConfigSettings:remoteConfigSettings];
    
    //load defaults from plist
    [self.remoteConfig setDefaultsFromPlistFileName:kFBSettings];
    
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
            NSLog(@"could not get data from server");
        }
        [self showPromoButton];
    }];
}
-(void)showPromoButton {
    
    NSString *promoButtonString = [self.remoteConfig configValueForKey:kPromo_message].stringValue;
    
    BOOL showButtonBool = [self.remoteConfig configValueForKey:kPromo_enabled].boolValue;
    NSLog(@" show button:%s, with string: %@", showButtonBool ? "true" : "false", promoButtonString);
    
    //Animated button showing to get user attention

    if (showButtonBool == TRUE) {
        self.promoButton.alpha = 0;
        self.promoButton.hidden = FALSE;
        [UIView animateWithDuration:2 animations:^{
            self.promoButton.alpha = 1;
        }];
        
        [self.promoButton setTitle:promoButtonString forState: normal];
    } else {
        // make sure button is not showing. this is default in storyboard, but we should c heck for future incase value changes
        self.promoButton.hidden = TRUE;
    }


}
- (IBAction)promoTouched:(id)sender {
    [FIRAnalytics logEventWithName:kPromoClicked parameters:nil];

}
- (IBAction)buttonOneTouched:(id)sender {
    NSLog(@"button one tapped");
    [FIRAnalytics logEventWithName:kButton1Click parameters:nil];
}
- (IBAction)buttonTwoTouched:(id)sender {
    NSLog(@"button two tapped");
    [FIRAnalytics logEventWithName:kButton2Click parameters:nil];

}
- (IBAction)buyTouched:(id)sender {
    [FIRAnalytics logEventWithName:kFIREventEcommercePurchase parameters:@{kFIRParameterItemID : kEcommerceBuyTapped}];//special event type for logging
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
