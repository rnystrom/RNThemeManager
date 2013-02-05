//
//  RNViewController.m
//  example
//
//  Created by Ryan Nystrom on 2/5/13.
//  Copyright (c) 2013 Ryan Nystrom. All rights reserved.
//

#import "RNViewController.h"
#import "RNThemeManager.h"

@interface RNViewController ()

@end

@implementation RNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDefault:(id)sender {
    [[RNThemeManager sharedManager] changeTheme:@"default"];
}

- (IBAction)onLow:(id)sender {
    [[RNThemeManager sharedManager] changeTheme:@"locontrast"];
}

- (IBAction)onHigh:(id)sender {
    [[RNThemeManager sharedManager] changeTheme:@"hicontrast"];
}

@end
