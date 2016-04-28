//
//  Equation.m
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import "Equation.h"
#import "NumberTests.m"

@implementation Equation

@synthesize l,r;

-(void) scale:(float)f {
	for (int i = 0; i < [l count]; i++) {
		[self.l replaceObjectAtIndex:i withObject:@(f * [[self.l objectAtIndex:i] doubleValue])];
	}
	
	for (int i = 0; i < [r count]; i++) {
		[self.r replaceObjectAtIndex:i withObject:@(f * [[self.r objectAtIndex:i] doubleValue])];
	}
	
}

-(void) add:(float)f atDegree:(int)d {
	[self.l replaceObjectAtIndex:d withObject:@(d + [[self.l objectAtIndex:d] doubleValue])];
	[self.r replaceObjectAtIndex:d withObject:@(d + [[self.r objectAtIndex:d] doubleValue])];
}

-(NSMutableString *) side:(NSMutableArray *)sd {
	NSMutableString *res = [[NSMutableString alloc] initWithCapacity:10];
	
	for (long i = [sd count] - 1; i >= 0; i--) {
		if ([[sd objectAtIndex:i] doubleValue] == 1.0) {
			[res appendFormat:@"x^%li", i];
		}
		else {
			(isInt([sd objectAtIndex:i])) ?
			
		}
	}
	
	
	
	return res;
}


@end
