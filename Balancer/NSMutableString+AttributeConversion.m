//
//  NSMutableString+NSMutableString_AttributeConversion.m
//  Balancer
//
//  Created by Younus Porteous on 2016/05/03.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import "NSMutableString+AttributeConversion.h"

@implementation NSMutableString (NSMutableString_AttributeConversion)

-(NSAttributedString *)attributedString:(NSDictionary *) attributes {
	return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

@end
