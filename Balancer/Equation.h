//
//  Equation.h
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Equation : NSObject

@property NSMutableArray *l,*r;


-(id) initZero;

-(void) scale:(float)f;
-(void) add:(float)f atDegree:(int)d;
-(NSMutableString *) side:(NSMutableArray *)s;


@end
