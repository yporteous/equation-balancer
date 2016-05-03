//
//  NSMutableString+NSMutableString_AttributeConversion.h
//  Balancer
//
//  Created by Younus Porteous on 2016/05/03.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (NSMutableString_AttributeConversion)

-(NSAttributedString *)attributedString:(NSDictionary *) attributes;

@end
