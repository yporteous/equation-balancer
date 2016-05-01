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
@synthesize equationLabel, scaleFactorLabel, scaleFactor, setFlag;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	eqn = [[Equation alloc] init];
	scaleFactor = 1;
	setFlag = TRUE;
	equationLabel.attributedText = [eqn bothSides];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



-(IBAction)addX {
	[eqn add:1.0 atDegree:1 toBoth:setFlag];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)subX {
	[eqn add:-1.0 atDegree:1 toBoth:setFlag];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)addOne {
	[eqn add:1.0 atDegree:0 toBoth:setFlag];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)subOne {
	[eqn add:-1.0 atDegree:0 toBoth:setFlag];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)mult {
	[eqn scale:self.scaleFactor];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)div {
	[eqn scale:(1.0/self.scaleFactor)];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)step:(UIStepper *)sender {
	double val = sender.value;
	
	scaleFactorLabel.text = [NSString stringWithFormat:@"%.0f", val];
	scaleFactor = val;
}

-(IBAction)setting:(UISwitch *)sender {
	setFlag = sender.on;
}

-(IBAction)reset {
	if (!setFlag) {
		[eqn.l removeAllObjects];
		[eqn.r removeAllObjects];
		[eqn.l addObject:@(0.0)];
		[eqn.l addObject:@(1.0)];
		[eqn.r addObject:@(1.0)];
		[eqn.r addObject:@(0.0)];
		equationLabel.attributedText = [eqn bothSides];
	}
}




@end
