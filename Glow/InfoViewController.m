//
//  InfoViewController.m
//  Glow
//
//  Created by Rory Prior on 27/11/2014.
//  Copyright (c) 2014 ThinkMac Software. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}


- (IBAction) doClose:(id)sender
{
  [[self navigationController] popToRootViewControllerAnimated: YES];
}

@end
