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
		[self.l addObject:@(0.0)];
		[self.l addObject:@(1.0)];
		[self.r addObject:@(1.0)];
		[self.r addObject:@(0.0)];
	}
	return self;
}


-(void) scale:(double)f {
	for (int i = 0; i < [l count]; i++) {
		double rep = f * [[self.l objectAtIndex:i] doubleValue];
//		NSNumber *replaceWith = ((isInt(@(rep))) ? @((int)rep) : @(rep));
		[self.l replaceObjectAtIndex:i withObject:((isInt(@(rep))) ? @((int)rep) : @(rep))];
	}
	
	for (int i = 0; i < [r count]; i++) {
		double rep = f * [[self.r objectAtIndex:i] doubleValue];
		[self.r replaceObjectAtIndex:i withObject:((isInt(@(rep))) ? @((int)rep) : @(rep))];
	}
	
}

-(void) add:(double)f atDegree:(int)d toBoth:(BOOL)both {
	if (both) {
		[self.l replaceObjectAtIndex:d withObject:@(f + [[self.l objectAtIndex:d] doubleValue])];
	}
	[self.r replaceObjectAtIndex:d withObject:@(f + [[self.r objectAtIndex:d] doubleValue])];
}

-(NSMutableAttributedString *) side:(NSMutableArray *)sd {
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
				[res appendFormat:@"%.02fx^%li + ", (double)[[sd objectAtIndex:i] doubleValue], i];
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
				[res appendFormat:@"%.02fx + ", (double)[[sd objectAtIndex:1] doubleValue]];
			}
		}
	}
	
	if ([[sd objectAtIndex:0] doubleValue] != 0.0) {
		if (isInt([sd objectAtIndex:0])) {
			[res appendFormat:@"%i + ", (int)[[sd objectAtIndex:0] integerValue]];
		}
		else {
			[res appendFormat:@"%.02f + ", (double)[[sd objectAtIndex:0] doubleValue]];
		}
	}
	
	if ([res length] == 0) {
		[res setString:@"0"];
	}
	else {
		[res deleteCharactersInRange:NSMakeRange([res length]-3, 3)];
	}
	
	[res replaceOccurrencesOfString:@"+ -" withString:@"- " options:NSLiteralSearch range:NSMakeRange(0, [res length])];
	[res replaceOccurrencesOfString:@"-" withString:@"–" options:NSLiteralSearch range:NSMakeRange(0, [res length])];
	
	UIFont *font = [UIFont fontWithName:@"CMUSerif-Roman" size:20];
	
	NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:res attributes:@{NSFontAttributeName: font}];
	
	[attr setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"CMUSerif-Italic" size:20]} range:[attr.mutableString rangeOfString:@"x"]];
	
//	NSLog(@"Final string is %@.", res);
	
	return attr;
}

-(NSMutableAttributedString *) bothSides {
	NSMutableAttributedString *sides = [self side:self.l];
	NSAttributedString *equality = [[NSAttributedString alloc] initWithString:@" = " attributes:@{NSFontAttributeName : [UIFont fontWithName:@"CMUSerif-Roman" size:20]}];
	[sides appendAttributedString:equality];
	[sides appendAttributedString:[self side:self.r]];
	return sides;
}


@end
