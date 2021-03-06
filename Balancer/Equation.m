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
	if (self = [super init]) {
		self.l = [[NSMutableArray alloc] init];		//array for lhs
		self.r = [[NSMutableArray alloc] init];		//array for rhs
		[self.l addObject:@(0.0)];					//set lhs to x
		[self.l addObject:@(1.0)];
		[self.r addObject:@(1.0)];					//set rhs to 1
		[self.r addObject:@(0.0)];
	}
	return self;
}

-(void) scale:(double)f {
	for (int i = 0; i < [l count]; i++) {
		double rep = f * [[self.l objectAtIndex:i] doubleValue];		//scale by f
		[self.l replaceObjectAtIndex:i withObject:((isInt(@(rep))) ? @((int)rep) : @(rep))];		//check if setting to int is appropriate
	}
	
	for (int i = 0; i < [r count]; i++) {
		double rep = f * [[self.r objectAtIndex:i] doubleValue];		//scale by f
		[self.r replaceObjectAtIndex:i withObject:((isInt(@(rep))) ? @((int)rep) : @(rep))];		//check if setting to int is appropriate
	}
	
}

-(void) add:(double)f atDegree:(int)d toBoth:(BOOL)both {
	// append objects to reach correct degree		TODO: can these be safely combined into one loop?
	while ([self.l count] < d + 1) {
		[self.l addObject:@(0.0)];
	}
	while ([self.r count] < d + 1) {
		[self.r addObject:@(0.0)];
	}
	// both flag checks if adding to both sides or only one
	if (both) {
		[self.l replaceObjectAtIndex:d withObject:@(f + [[self.l objectAtIndex:d] doubleValue])];
	}
	[self.r replaceObjectAtIndex:d withObject:@(f + [[self.r objectAtIndex:d] doubleValue])];
}

-(NSMutableAttributedString *) side:(NSMutableArray *)sd {
	UIFont *font = [UIFont fontWithName:@"CMUSerif-Roman" size:20];
	UIFont *fontSupRom = [UIFont fontWithName:@"CMUSerif-Roman" size:14];
	UIFont *fontItalic = [UIFont fontWithName:@"CMUSerif-Italic" size:20];
	
	NSMutableString *temp = [[NSMutableString alloc] initWithCapacity:0];
	NSMutableAttributedString *term = [[NSMutableAttributedString alloc] initWithString:temp attributes:@{NSFontAttributeName: font}];
	
	
	NSMutableArray *concat = [[NSMutableArray alloc] init];
	[temp setString:@""];
	
	//NSLog(@"Number of terms: %li", (long)[sd count]);
	
	// All terms except x^1, x^0
	for (long i = [sd count] - 1; i > 1; i--) {
		if ([[sd objectAtIndex:i] doubleValue] != 0.0) {			//if term has non-zero coefficient
			[temp setString:@""];									//clear temp
			if ([[sd objectAtIndex:i] doubleValue] == 1.0) {
				[temp appendFormat:@"x%li", i];					//do not print coefficient if == 1
			}
			else if ([[sd objectAtIndex:i] doubleValue] == -1.0) {
				[temp appendFormat:@"-x%li", i];					//add '-' if coeff == -1
			}
			else {
				(isInt([sd objectAtIndex:i])) ?						//print coefficient (format depending on whether float or int)
				[temp appendFormat:@"%ix%li", (int)[[sd objectAtIndex:i] integerValue], i] :
				[temp appendFormat:@"%.02fx%li", (double)[[sd objectAtIndex:i] doubleValue], i];
			}
			
			//Create attributed string from normal string
			[term setAttributedString:[temp attributedString:@{NSFontAttributeName: font}]];
			
			//if contains an x (which it must, here), make it italic
			NSRange indexLoc = [term.mutableString rangeOfString:@"x"];
			if (indexLoc.location != NSNotFound) {
				[term setAttributes:@{NSFontAttributeName : fontItalic} range:[term.mutableString rangeOfString:@"x"]];
			}
			
			//if index exists (ie if there's a character after the x, again should be as this is x^n, n>1), make it superscript
			if (indexLoc.location != NSNotFound && indexLoc.location < term.mutableString.length - 1) {
				indexLoc.location++;
				indexLoc.length = [term.mutableString length] - indexLoc.location;
				[term setAttributes:@{NSFontAttributeName : fontSupRom, NSBaselineOffsetAttributeName : @8} range:indexLoc];
			}
			
			//add a copy to the string array
			[concat addObject:[term mutableCopy]];
			
			[term deleteCharactersInRange:NSMakeRange(0, term.length - 1)];
		}
	}
	
	// Term in x^1
	if ([sd count] > 1) {
		//clear temp
		[temp setString:@""];
		//if coeff != 0
		if ([[sd objectAtIndex:1] doubleValue] != 0.0) {
			if ([[sd objectAtIndex:1] doubleValue] == 1.0) {
				[temp appendString:@"x"];								// if 1, do not print coeff
			}
			else if ([[sd objectAtIndex:1] doubleValue] == -1.0) {
				[temp appendString:@"-x"];								// if -1, only print '-'
			}
			else {														// print with coefficient, formatted appripriately
				(isInt([sd objectAtIndex:1])) ?
				[temp appendFormat:@"%ix", (int)[[sd objectAtIndex:1] integerValue]] :
				[temp appendFormat:@"%.02fx", (double)[[sd objectAtIndex:1] doubleValue]];
			}
			
			// set attributed string
			[term setAttributedString:[temp attributedString:@{NSFontAttributeName: font}]];
			
			
			//convert x to italic
			if ([term.mutableString rangeOfString:@"x"].location != NSNotFound) {
				[term setAttributes:@{NSFontAttributeName : fontItalic} range:[term.mutableString rangeOfString:@"x"]];
			}
			//no index, so go straight to appending object
			[concat addObject:[term mutableCopy]];
			
			//NSLog(@"Term in x^1");
			//NSLog(@"\t%@", [[concat lastObject] class]);
			//NSLog(@"\t%@", [[concat lastObject] mutableString]);
			//NSLog(@"———––––––––––––");
		}
	}
	
	
	// Term in x^0
	if ([[sd objectAtIndex:0] doubleValue] != 0.0) {
		//clear temp
		[temp setString:@""];
		
		//print coefficient (no x here)
		if (isInt([sd objectAtIndex:0])) {
			[temp appendFormat:@"%i", (int)[[sd objectAtIndex:0] integerValue]];
		}
		else {
			[temp appendFormat:@"%.02f", (double)[[sd objectAtIndex:0] doubleValue]];
		}
		//set attributed string
		[term setAttributedString:[temp attributedString:@{NSFontAttributeName: font}]];
		
		//no index, no x, so go straight to appending object, no need to copy
		[concat addObject:term];
		//NSLog(@"Term in x^0");
		//NSLog(@"\t%@", [[concat lastObject] class]);
		//NSLog(@"\t%@", [[concat lastObject] mutableString]);
		//NSLog(@"———––––––––––––");
	}
	
	//create attributed string for the whole expression
	NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSFontAttributeName: font}];
	
	//some needed strings in concatenation: add, sub, zero
	NSAttributedString *plus = [[NSAttributedString alloc] initWithString:@" + " attributes:@{NSFontAttributeName: font}];
	NSAttributedString *minus = [[NSAttributedString alloc] initWithString:@" – " attributes:@{NSFontAttributeName: font}];
	NSAttributedString *zero = [[NSAttributedString alloc] initWithString:@"0" attributes:@{NSFontAttributeName: font}];
	
	//if there is anything in the print array
	if (concat.count) {
		//NSLog(@"Concat length: %li", (long)concat.count);
		for (int i = 0; i < concat.count; i++) {					// for each item in array
			
			//NSLog(@"%i: %@", i, [[concat objectAtIndex:i] class]);
			//NSLog(@"%@", [[concat objectAtIndex:i] string]);
			
			[attr appendAttributedString: [concat objectAtIndex:i]];	// append item
			
			if (i < concat.count - 1) {												// if there are still items...
				//NSLog(@"%@", [[[concat objectAtIndex:i+1] string] class]);
				
				unichar ch = [[[concat objectAtIndex:i+1] string] characterAtIndex:0];	//check first character of next item
				//NSLog(@"%c", ch);
				//NSLog(@"HERE??");
				//*
				if (ch == '-') {										// if it's '-'
					[attr appendAttributedString:minus];				// append subtraction string
					[[concat objectAtIndex:i+1] deleteCharactersInRange:NSMakeRange(0, 1)];		//remove -ve from next item
				}
				else {
					[attr appendAttributedString:plus];					// otherwise, it's '+'
				}
				//*/
			}
		}
	}
	//if nothing in array, add a zero
	else {
		[attr appendAttributedString:zero];
	}
	
	//find-replace all '-' with '–' (longer m? dash)
	while ([attr.mutableString rangeOfString:@"-"].location != NSNotFound) {
		[attr replaceCharactersInRange:[attr.mutableString rangeOfString:@"-"] withString:@"–"];
	}
	
	return attr;
}

-(NSMutableAttributedString *) bothSides:(unichar)rel {
	NSMutableAttributedString *sides = [self side:self.l];
	
	NSString *relString = [NSString stringWithFormat:@" %c ", rel];
	
	NSAttributedString *equality = [[NSAttributedString alloc] initWithString:relString
																   attributes:@{NSFontAttributeName : [UIFont fontWithName:@"CMUSerif-Roman" size:20]}];
	[sides appendAttributedString:equality];
	
	[sides appendAttributedString:[self side:self.r]];
	
	return sides;
}

-(NSMutableAttributedString *) factoriseQuad:(unichar)rel {
	
	UIFont *font = [UIFont fontWithName:@"CMUSerif-Roman" size:20];
	UIFont *fontItalic = [UIFont fontWithName:@"CMUSerif-Italic" size:20];
	
	NSArray *roots;										//array of roots
	NSMutableArray *temp = [self.l mutableCopy];		//make local editable copy of side's array
	NSMutableAttributedString *factorised = [[NSMutableAttributedString alloc] init];	//allocate string to return
	
	//strip all unneeded object
	while ([[temp lastObject]  isEqual: @(0.0)]) {
		[temp removeLastObject];
	}
	
	//if quadratic (3 term x^0, x^1, x^2)
	if ([temp count] == 3) {
		
		//quadratic equation formula
		double a = [[temp lastObject] doubleValue];
		double b = [[temp objectAtIndex:1] doubleValue];
		double c = [[temp firstObject] doubleValue];
		double x1, x2;
		BOOL real = TRUE;
		
		// if real solution(s), simply follow formula		TODO: check for repeated roots
		if (b*b - 4 * a * c >= 0) {
			x1 = (-b + sqrt(b*b - 4 * a * c))/(2 * a);
			x2 = (-b - sqrt(b*b - 4 * a * c))/(2 * a);
		}
		
		// if complex solutions, negate discriminant
		else {
			x1 = (-b + sqrt(-b*b + 4 * a * c))/(2 * a);
			x2 = (-b - sqrt(-b*b + 4 * a * c))/(2 * a);
			real = FALSE;
		}
		
		// check for premultiplier: if a ≠ 1
		if (a != 1.0) {
			NSMutableString *multiplier;
			//check if int for appropriate formatting
			if (isInt(@(a))) {
				multiplier = [NSMutableString stringWithFormat:@"%li", (long)a];
			}
			else {
				multiplier = [NSMutableString stringWithFormat:@"%f", a];
			}
			//replace '-' with (longer) '–'
			[multiplier replaceOccurrencesOfString:@"-" withString:@"–" options:NSLiteralSearch range:NSMakeRange(0, [multiplier length])];
			
			// if -1, remove the 1
			if (a == -1.0) {
				[multiplier replaceOccurrencesOfString:@"1" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [multiplier length])];
			}
			// append multiplier to final string
			[factorised appendAttributedString:[[NSMutableAttributedString alloc] initWithString:multiplier attributes:@{NSFontAttributeName: font}]];
		}
		
		//put roots in array
		roots = [NSArray arrayWithObjects:@(x1), @(x2), nil];
		
		//mutableString for each root
		NSMutableAttributedString *bracket;
		
		//unattributed holder builder string
		NSMutableString *rootUnattr = [NSMutableString stringWithFormat:@"(x – "];
		
		//for each root:
		for (long i = 0; i < [roots count]; i++) {
			// if 0, just write 'x'
			if ([[roots objectAtIndex:i] doubleValue] == 0.0) {
				[rootUnattr setString:@"x "];
			}
			// if non-zero, write (x-a):
			else {
				[rootUnattr setString:@"(x – "];			//clear rootUnattr to starting value
				
				// if real roots, no need to multiply by i
				if (real) {
					//ternary condition to add as root int if appropriate
					isInt([roots objectAtIndex:i]) ?
					[rootUnattr appendFormat:@"%li)", (long)[[roots objectAtIndex:i] integerValue]] :
					[rootUnattr appendFormat:@"%f)", [[roots objectAtIndex:i] doubleValue]];
				}
				// if complex roots, need to add factor of i
				else {
					// if +i, no need to add coeff
					if ([[roots objectAtIndex:i] isEqual:@(1)]) {
						[rootUnattr appendString:@"i)"];
					}
					// if -i, only need -ve sign
					else if ([[roots objectAtIndex:i] isEqual:@(-1)]) {
						[rootUnattr appendString:@"–i)"];
					}
					//otherwise write ±ai
					else {
						//ternary condition to add as root int if possible
						isInt([roots objectAtIndex:i]) ?
						[rootUnattr appendFormat:@"%lii)", (long)[[roots objectAtIndex:i] integerValue]] :
						[rootUnattr appendFormat:@"%fi)", [[roots objectAtIndex:i] doubleValue]];
					}
				}
			}
			
			//check for double -ve, replace with +ve
			[rootUnattr replaceOccurrencesOfString:@"– -" withString:@"+ " options:NSLiteralSearch range:NSMakeRange(0, [rootUnattr length])];
			
			//initialise bracket to new string with rootUnattr
			bracket = [[NSMutableAttributedString alloc] initWithString:rootUnattr attributes:@{NSFontAttributeName: font}];
			
			//italicise x
			NSRange indexLoc = [bracket.string rangeOfString:@"x"];
			if (indexLoc.location != NSNotFound) {
				[bracket setAttributes:@{NSFontAttributeName : fontItalic} range:indexLoc];
			}
			
			//italicise i if present
			indexLoc = [bracket.string rangeOfString:@"i"];
			if (indexLoc.location != NSNotFound) {
				[bracket setAttributes:@{NSFontAttributeName : fontItalic} range:indexLoc];
			}
			
			//append to main return string
			[factorised appendAttributedString:bracket];
		}
		
		//string to hold relation type
		NSString *relString = [NSString stringWithFormat:@" %c ", rel];
		
		//make it attributed and append to string
		NSAttributedString *equality = [[NSAttributedString alloc] initWithString:relString attributes:@{NSFontAttributeName : font}];
		[factorised appendAttributedString:equality];
		
		//append RHS
		[factorised appendAttributedString:[self side:self.r]];
		
	}
	else {	//if not quadratic, set to a blank string
		NSAttributedString *blank = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSFontAttributeName: font}];
		[factorised setAttributedString:blank];
	}
	
	return factorised;
}

@end