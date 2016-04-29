//
//  Equation.m
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import "Equation.h"
//#import "NumberTests.m"

BOOL isInt(NSNumber *num) {
	double dVal = [num doubleValue];
	if (dVal >= 0.0) {
		return (dVal == ceil(dVal));
	}
	else {
		return (dVal == floor(dVal));
	}
}


@implementation Equation

@synthesize l,r;


-(id) init {
//	self ;
	if (self = [super init]) {
		self.l = [[NSMutableArray alloc] init];
		self.r = [[NSMutableArray alloc] init];
		[self.l addObject:@(4.0)];
		[self.l addObject:@(3.0)];
		[self.r addObject:@(19.0)];
		[self.r addObject:@(-2.0)];
	}
	return self;
}


-(void) scale:(double)f {
	for (int i = 0; i < [l count]; i++) {
		[self.l replaceObjectAtIndex:i withObject:@(f * [[self.l objectAtIndex:i] doubleValue])];
	}
	
	for (int i = 0; i < [r count]; i++) {
		[self.r replaceObjectAtIndex:i withObject:@(f * [[self.r objectAtIndex:i] doubleValue])];
	}
	
}

-(void) add:(double)f atDegree:(int)d {
	[self.l replaceObjectAtIndex:d withObject:@(f + [[self.l objectAtIndex:d] doubleValue])];
	[self.r replaceObjectAtIndex:d withObject:@(f + [[self.r objectAtIndex:d] doubleValue])];
}

-(NSMutableString *) side:(NSMutableArray *)sd {
	NSMutableString *res = [[NSMutableString alloc] initWithCapacity:10];
		
	for (long i = [sd count] - 1; i > 1; i--) {
		if ([[sd objectAtIndex:i] doubleValue] != 0.0) {
			if ([[sd objectAtIndex:i] doubleValue] == 1.0) {
				[res appendFormat:@"x^%li + ", i];
			}
			else if ([[sd objectAtIndex:i] doubleValue] == -1.0) {
				[res appendFormat:@"-x^%li + ", i];
			}
			else {
				(isInt([sd objectAtIndex:i])) ?
				[res appendFormat:@"%ix^%li + ", (int)[[sd objectAtIndex:i] integerValue], i] :
				[res appendFormat:@"%fx^%li + ", (double)[[sd objectAtIndex:i] doubleValue], i];
			}
		}
	}
	
	if ([sd count] > 1) {
		if ([[sd objectAtIndex:1] doubleValue] != 0.0) {
			if ([[sd objectAtIndex:1] doubleValue] == 1.0) {
				[res appendString:@"x + "];
			}
			else if ([[sd objectAtIndex:1] doubleValue] == -1.0) {
				[res appendString:@"-x + "];
			}
			else {
				(isInt([sd objectAtIndex:1])) ?
				[res appendFormat:@"%ix + ", (int)[[sd objectAtIndex:1] integerValue]] :
				[res appendFormat:@"%fx + ", (double)[[sd objectAtIndex:1] doubleValue]];
			}
		}
	}
	
	if ([[sd objectAtIndex:0] doubleValue] != 0.0) {
		if (isInt([sd objectAtIndex:0])) {
			[res appendFormat:@"%i + ", (int)[[sd objectAtIndex:0] integerValue]];
		}
		else {
			[res appendFormat:@"%fx + ", (double)[[sd objectAtIndex:0] doubleValue]];
		}
	}
	
	if ([res length] == 0) {
		[res setString:@"0"];
	}
	else {
		[res deleteCharactersInRange:NSMakeRange([res length]-3, 3)];
	}
//	NSLog(@"Final string is %@.", res);
	
	return res;
}

-(NSString *) bothSides {
	return [NSString stringWithFormat:@"%@ = %@", [self side:[self l]], [self side:[self r]]];
}


@end
