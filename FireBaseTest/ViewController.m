//
//  ViewController.m
//  FireBaseTest
//
//  Created by Apple on 10/12/2017.
//  Copyright © 2017 com.spcarlin. All rights reserved.
//

#import "ViewController.h"
#import "FBViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray * cellNames;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cellNames = @[@"FireBase", @"Theme"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellNames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.cellNames[indexPath.row];
    NSLog(@"index:%li, cell name: %@", (long)indexPath.row, cell.textLabel.text);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"you touched cell at index: %li", (long)indexPath.row);
    if([cell.textLabel.text isEqual: @"FireBase"]) {
        //firebase
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        FBViewController *FBVC =  [storyBoard instantiateViewControllerWithIdentifier:@"FBVC"]; //[[FBViewController alloc]init];
        [[self navigationController] pushViewController:FBVC animated:YES]; //presentViewController:FBVC animated:YES completion:nil];
    } else if ([cell.textLabel.text isEqual: @"Theme"]){
        //here either just flip the theme or make new VC to show option for theme
    }
}
@end
