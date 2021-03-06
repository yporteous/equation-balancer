//
//  Equation.h
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSMutableString+AttributeConversion.h"

@interface Equation : NSObject

@property NSMutableArray *l,*r;


-(id) init;										//inits with lhs = rhs = 0

-(void) scale:(double)f;						//scales both sides by factor f
-(void) add:(double)f atDegree:(int)d toBoth:(BOOL)both;		//adds a factor of f*x^d to left or both sides
-(NSMutableAttributedString *) side:(NSMutableArray *)s;		//creates a string of one side for printing
-(NSMutableAttributedString *) bothSides:(unichar)rel;			//creates final string using rel as relation
-(NSMutableAttributedString *) factoriseQuad:(unichar)rel;	//creates a string that represents a factorised quadratic, takes one side as argument

@end
