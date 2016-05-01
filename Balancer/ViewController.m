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
@synthesize equationLabel, scaleFactorLabel, indexLabel, scaleFactor, index, setFlag, plsXN, minXN, plsX1, minX1, plus1, minus1;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	eqn = [[Equation alloc] init];
	scaleFactor = 1;
	index = 1;
	setFlag = TRUE;
	equationLabel.attributedText = [eqn bothSides];
	
	UIFont *fontNormal = [UIFont fontWithName:@"CMUSerif-Roman" size:20];
	UIFont *fontItalic = [UIFont fontWithName:@"CMUSerif-Italic" size:20];
//	UIFont *fontSupRom = [UIFont fontWithName:@"CMUSerif-Roman" size:14];
	UIFont *fontSupItl = [UIFont fontWithName:@"CMUSerif-Italic" size:14];
	
	NSMutableAttributedString *plusPow = [[NSMutableAttributedString alloc] initWithString:@"+xn" attributes:@{NSFontAttributeName: fontNormal}];
	[plusPow setAttributes:@{NSFontAttributeName : fontItalic} range:[plusPow.mutableString rangeOfString:@"x"]];
	[plusPow setAttributes:@{NSFontAttributeName : fontSupItl, NSBaselineOffsetAttributeName : @8} range:[plusPow.mutableString rangeOfString:@"n"]];
	[plsXN setAttributedTitle:plusPow forState:UIControlStateNormal];
	
	NSMutableAttributedString *minPow = [[NSMutableAttributedString alloc] initWithString:@"–xn" attributes:@{NSFontAttributeName: fontNormal}];
	[minPow setAttributes:@{NSFontAttributeName : fontItalic} range:[minPow.mutableString rangeOfString:@"x"]];
	[minPow setAttributes:@{NSFontAttributeName : fontSupItl, NSBaselineOffsetAttributeName : @8} range:[minPow.mutableString rangeOfString:@"n"]];
	[minXN setAttributedTitle:minPow forState:UIControlStateNormal];
	
	
	NSMutableAttributedString *pX = [[NSMutableAttributedString alloc] initWithString:@"+x" attributes:@{NSFontAttributeName: fontNormal}];
	[pX setAttributes:@{NSFontAttributeName : fontItalic} range:[pX.mutableString rangeOfString:@"x"]];
	[plsX1 setAttributedTitle:pX forState:UIControlStateNormal];
	
	NSMutableAttributedString *mX = [[NSMutableAttributedString alloc] initWithString:@"–x" attributes:@{NSFontAttributeName: fontNormal}];
	[mX setAttributes:@{NSFontAttributeName : fontItalic} range:[mX.mutableString rangeOfString:@"x"]];
	[minX1 setAttributedTitle:mX forState:UIControlStateNormal];
	
	NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc] initWithString:@"+1" attributes:@{NSFontAttributeName: fontNormal}];
	[plus1 setAttributedTitle:p1 forState:UIControlStateNormal];
	
	NSMutableAttributedString *m1 = [[NSMutableAttributedString alloc] initWithString:@"–1" attributes:@{NSFontAttributeName: fontNormal}];
	[minus1 setAttributedTitle:m1 forState:UIControlStateNormal];
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

-(IBAction)addXN {
	[eqn add:1.0 atDegree:self.index toBoth:setFlag];
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)subXN {
	[eqn add:-1.0 atDegree:self.index toBoth:setFlag];
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

-(IBAction)changeIndex:(UIStepper *)sender {
	double val = sender.value;
	
	indexLabel.text = [NSString stringWithFormat:@"%.0f", val];
	index = (int) val;
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

-(IBAction)swapSides {
	NSMutableArray *hold = eqn.l;
	eqn.l = eqn.r;
	eqn.r = hold;
	equationLabel.attributedText = [eqn bothSides];
}

-(IBAction)negate {
	[eqn scale:-1.0];
	equationLabel.attributedText = [eqn bothSides];
}


@end
