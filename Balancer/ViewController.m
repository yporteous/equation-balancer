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
@synthesize equationLabel, scaleFactorLabel, indexLabel, scaleFactor, index, setFlag, factFlag, plsXN, minXN, plsX1, minX1, plus1, minus1, relTypeSelect, relType;


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	eqn = [[Equation alloc] init];				//allocate the central Equation object
	scaleFactor = 1;							//initial Scale Factor is 1
	relType = '=';								//initially adding
	index = 1;									//initial index of ±x^n is 1
	setFlag = TRUE;								//set/solve initially true = solve
	factFlag = FALSE;
	equationLabel.attributedText = [eqn bothSides:relType];		//set eqn
	
	UIFont *fontNormal = [UIFont fontWithName:@"CMUSerif-Roman" size:20];
	UIFont *fontItalic = [UIFont fontWithName:@"CMUSerif-Italic" size:20];
//	UIFont *fontSupRom = [UIFont fontWithName:@"CMUSerif-Roman" size:14];
	UIFont *fontSupItl = [UIFont fontWithName:@"CMUSerif-Italic" size:14];
	
	
	//reformat +x^n
	NSMutableAttributedString *plusPow = [[NSMutableAttributedString alloc] initWithString:@"+xn" attributes:@{NSFontAttributeName: fontNormal}];
	[plusPow setAttributes:@{NSFontAttributeName : fontItalic} range:[plusPow.mutableString rangeOfString:@"x"]];
	[plusPow setAttributes:@{NSFontAttributeName : fontSupItl, NSBaselineOffsetAttributeName : @8} range:[plusPow.mutableString rangeOfString:@"n"]];
	[plsXN setAttributedTitle:plusPow forState:UIControlStateNormal];
	//reformat -x^n
	NSMutableAttributedString *minPow = [[NSMutableAttributedString alloc] initWithString:@"–xn" attributes:@{NSFontAttributeName: fontNormal}];
	[minPow setAttributes:@{NSFontAttributeName : fontItalic} range:[minPow.mutableString rangeOfString:@"x"]];
	[minPow setAttributes:@{NSFontAttributeName : fontSupItl, NSBaselineOffsetAttributeName : @8} range:[minPow.mutableString rangeOfString:@"n"]];
	[minXN setAttributedTitle:minPow forState:UIControlStateNormal];
	
	//reformat +x
	NSMutableAttributedString *pX = [[NSMutableAttributedString alloc] initWithString:@"+x" attributes:@{NSFontAttributeName: fontNormal}];
	[pX setAttributes:@{NSFontAttributeName : fontItalic} range:[pX.mutableString rangeOfString:@"x"]];
	[plsX1 setAttributedTitle:pX forState:UIControlStateNormal];
	//reformat -x
	NSMutableAttributedString *mX = [[NSMutableAttributedString alloc] initWithString:@"–x" attributes:@{NSFontAttributeName: fontNormal}];
	[mX setAttributes:@{NSFontAttributeName : fontItalic} range:[mX.mutableString rangeOfString:@"x"]];
	[minX1 setAttributedTitle:mX forState:UIControlStateNormal];
	//reformat +1
	NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc] initWithString:@"+1" attributes:@{NSFontAttributeName: fontNormal}];
	[plus1 setAttributedTitle:p1 forState:UIControlStateNormal];
	//reformat -1
	NSMutableAttributedString *m1 = [[NSMutableAttributedString alloc] initWithString:@"–1" attributes:@{NSFontAttributeName: fontNormal}];
	[minus1 setAttributedTitle:m1 forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(IBAction)addX {
	[eqn add:1.0 atDegree:1 toBoth:setFlag];		//call addition function with n = 1, a = +1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)subX {
	[eqn add:-1.0 atDegree:1 toBoth:setFlag];		//call addition function with n = 1, a = -1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)addOne {
	[eqn add:1.0 atDegree:0 toBoth:setFlag];		//call addition function with n = 0, a = +1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)subOne {
	[eqn add:-1.0 atDegree:0 toBoth:setFlag];		//call addition function with n = 0, a = -1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)addXN {
	[eqn add:1.0 atDegree:self.index toBoth:setFlag];	//call addition function with n = index, a = +1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)subXN {
	[eqn add:-1.0 atDegree:self.index toBoth:setFlag];	//call addition function with n = index, a = -1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)mult {
	[eqn scale:self.scaleFactor];						//scale by scaleFactor
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)div {
	[eqn scale:(1.0/self.scaleFactor)];					//scale by scaleFactor^-1
	equationLabel.attributedText = [eqn bothSides:relType];
}

-(IBAction)step:(UIStepper *)sender {					//set scaleFactor and its label
	scaleFactorLabel.text = [NSString stringWithFormat:@"%.0f", sender.value];
	scaleFactor = sender.value;
}

-(IBAction)changeIndex:(UIStepper *)sender {			//set index and its label
	indexLabel.text = [NSString stringWithFormat:@"%.0f", sender.value];
	index = (int) sender.value;
}

-(IBAction)setting:(UISwitch *)sender {					//toggle setFlag
	setFlag = sender.on;
}

-(IBAction)reset {										//reset method
	if (!setFlag) {										//only allow if in set mode
		[eqn.l removeAllObjects];						//remove objects from left
		[eqn.r removeAllObjects];						//and right
		[eqn.l addObject:@(0.0)];						//To left: 0*1
		[eqn.l addObject:@(1.0)];						// +1*x
		[eqn.r addObject:@(1.0)];						//to right: 1*1
		[eqn.r addObject:@(0.0)];						// +0*x
		relTypeSelect.selectedSegmentIndex = 1;			//set relation type button to '='
		relType = '=';									//set relation button to '='
		equationLabel.attributedText = [eqn bothSides:relType];	//output equation
	}
}

-(IBAction)swapSides {									//swap sides
	NSMutableArray *hold = eqn.l;						//put lhs in temporary holding variable
	eqn.l = eqn.r;										//rhs -> lhs
	eqn.r = hold;										//put holding in rhs
	//change relation type if <>
	switch (relType) {
		case '>':
			relType = '<';
			relTypeSelect.selectedSegmentIndex = 0;
			break;
		case '<':
			relType = '>';
			relTypeSelect.selectedSegmentIndex = 2;
		default:
			break;
	}
	
	equationLabel.attributedText = [eqn bothSides:relType];	//print equation
}

-(IBAction)negate {
	[eqn scale:(-1.0)];									//scale by -1
	//change relation type if <>
	switch (relType) {
		case '>':
			relType = '<';
			relTypeSelect.selectedSegmentIndex = 0;
			break;
		case '<':
			relType = '>';
			relTypeSelect.selectedSegmentIndex = 2;
		default:
			break;
	}
	equationLabel.attributedText = [eqn bothSides:relType];	//print equation
}


-(IBAction)setRel:(UISegmentedControl *)sender {		//sets relation type
	
	switch (sender.selectedSegmentIndex) {				//check UISegmentedControl
		case 0:											//0 => '<'
			relType = '<';
			break;
		case 1:											//1 => '='
			relType = '=';
			break;
		case 2:											//2 => '>'
			relType = '>';
			break;
		default:										//just in case, set to '=' otherwise
			relType = '=';
			break;
	}
	
	equationLabel.attributedText = [eqn bothSides:relType];	//print equation
}

-(IBAction)factoriseQuadratic {
	NSAttributedString *factorisedString = [eqn factoriseQuad:relType];
	if (!factFlag && [factorisedString.string length] > 0) {	//if unfactorised and we get a string from the method,
		equationLabel.attributedText = factorisedString;		//print factorised equation
		factFlag = TRUE;
	}
	else {
		equationLabel.attributedText = [eqn bothSides:relType];
		factFlag = FALSE;
	}
}




@end
