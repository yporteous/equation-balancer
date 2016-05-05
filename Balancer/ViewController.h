//
//  ViewController.h
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Equation.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;			//main equation output
@property (weak, nonatomic) IBOutlet UILabel *scaleFactorLabel;			//labels scale factor for mult
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;				//labels index for ±x^n
@property double scaleFactor;											//holds scale factor variable
@property int index;													//holds index variable
@property unichar relType;												//holds relation type variable
@property BOOL setFlag;													//holds set/solve flag
@property BOOL factFlag;												//factorised/unfactorised flag
@property IBOutlet UIButton *plsXN;										//refers to +x^n button
@property IBOutlet UIButton *minXN;										//refers to -x^n button
@property IBOutlet UIButton *plsX1;										//refers to +x^1 button
@property IBOutlet UIButton *minX1;										//refers to -x^1 button
@property IBOutlet UIButton *plus1;										//refers to +1 button
@property IBOutlet UIButton *minus1;									//refers to -1 button
@property IBOutlet UISegmentedControl *relTypeSelect;					//refers to relation type segmented control

@property Equation *eqn;												//main equation

-(IBAction)addX;														//+x method
-(IBAction)subX;														//-x method
-(IBAction)addOne;														//+1 method
-(IBAction)subOne;														//-1 method
-(IBAction)addXN;														//+x^n method
-(IBAction)subXN;														//-x^n method
-(IBAction)mult;														//×SF method
-(IBAction)div;															//÷SF method
-(IBAction)step:(UIStepper *)sender;									//change SF method
-(IBAction)changeIndex:(UIStepper *)sender;								//change index method
-(IBAction)setting:(UISwitch *)sender;									//change set/solve
-(IBAction)reset;														//reset method
-(IBAction)swapSides;													//lhs <–> rhs
-(IBAction)negate;														//×-1
-(IBAction)setRel:(UISegmentedControl *)sender;							//set relation type
-(IBAction)factoriseQuadratic;											//factorise a quadratic equation

@end

