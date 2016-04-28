//
//  ViewController.m
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize eqn;
@synthesize equationLabel;
//Equation* eqn = [[Equation alloc] initZero];

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	equationLabel.text = [eqn side:eqn.l];
//	[equationLabel setText:[eqn side:eqn.l]];
	NSLog(@"View Loaded");
	NSLog(@"%@", [eqn side:[eqn l]]);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(IBAction)addX {
//	[eqn add:1.0 atDegree:1];
//	equationLabel.text = [eqn side:eqn.l];
}

@end
