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

@end

@implementation FBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)buttonOneTouched:(id)sender {
    NSLog(@"button one tapped");
    [FIRAnalytics logEventWithName:@"button1Click" parameters:nil];
}
- (IBAction)buttonTwoTouched:(id)sender {
    NSLog(@"button two tapped");
    [FIRAnalytics logEventWithName:@"button2Click" parameters:nil];

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
