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
@property Equation *eqn;

@end

