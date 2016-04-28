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


-(id) initZero {
	self = [super init];
	if (self) {
		[self.l addObject:@(0.0)];
		[self.r addObject:@(0.0)];
	}
	return self;
}


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
	
	for (long i = [sd count] - 1; i > 1; i--) {
		if ([[sd objectAtIndex:i] doubleValue] == 1.0) {
			[res appendFormat:@"x^%li + ", i];
		}
		else {
			(isInt([sd objectAtIndex:i])) ?
			[res appendFormat:@"%ix^%li + ", (int)[[sd objectAtIndex:i] integerValue], i] :
			[res appendFormat:@"%fx^%li + ", (double)[[sd objectAtIndex:i] doubleValue], i];
		}
	}
	
	if ([[sd objectAtIndex:1] doubleValue] == 1.0) {
		[res appendString:@"x + "];
	}
	else {
		(isInt([sd objectAtIndex:1])) ?
		[res appendFormat:@"%ix + ", (int)[[sd objectAtIndex:1] integerValue]] :
		[res appendFormat:@"%fx + ", (double)[[sd objectAtIndex:1] doubleValue]];
	}
	
	if (isInt([sd objectAtIndex:0])) {
		[res appendFormat:@"%i + ", (int)[[sd objectAtIndex:1] integerValue]];
	}
	else {
		[res appendFormat:@"%fx + ", (double)[[sd objectAtIndex:1] doubleValue]];
	}
	
	if ([res length] == 0) {
		[res setString:@"0"];
	}
	else {
		[res deleteCharactersInRange:NSMakeRange([res length]-3, 3)];
	}
	
	return res;
}


@end
