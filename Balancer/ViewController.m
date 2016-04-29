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
	eqn = [[Equation alloc] init];
	NSLog(@"View Loaded");
	
	/*
	NSString *lhs = [eqn side:[eqn l]];
	NSString *rhs = [eqn side:[eqn r]];
	
	NSString *both = [NSString stringWithFormat:@"%@ = %@", lhs, rhs];
	
	[equationLabel setText:both];
	// */
	
	[equationLabel setText:[eqn bothSides]];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(IBAction)addX {
	[eqn add:1.0 atDegree:1];
	equationLabel.text = [eqn bothSides];
}

-(IBAction)subX {
	[eqn add:-1.0 atDegree:1];
	equationLabel.text = [eqn bothSides];
}

-(IBAction)addOne {
	[eqn add:1.0 atDegree:0];
	equationLabel.text = [eqn bothSides];
}

-(IBAction)subOne {
	[eqn add:-1.0 atDegree:0];
	equationLabel.text = [eqn bothSides];
}

@end
