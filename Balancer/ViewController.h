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
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;
@property (weak, nonatomic) IBOutlet UILabel *scaleFactorLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property double scaleFactor;
@property int index;
@property BOOL setFlag;
@property IBOutlet UIButton *plsXN;
@property IBOutlet UIButton *minXN;
@property IBOutlet UIButton *plsX1;
@property IBOutlet UIButton *minX1;
@property IBOutlet UIButton *plus1;
@property IBOutlet UIButton *minus1;

@property Equation *eqn;

-(IBAction)addX;
-(IBAction)subX;
-(IBAction)addOne;
-(IBAction)subOne;
-(IBAction)addXN;
-(IBAction)subXN;
-(IBAction)mult;
-(IBAction)div;
-(IBAction)step:(UIStepper *)sender;
-(IBAction)changeIndex:(UIStepper *)sender;
-(IBAction)setting:(UISwitch *)sender;
-(IBAction)reset;
-(IBAction)swapSides;
-(IBAction)negate;

@end

