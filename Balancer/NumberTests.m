//
//  NumberTests.m
//  Balancer
//
//  Created by Younus Porteous on 2016/04/28.
//  Copyright © 2016 Younus Porteous. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isInt(NSNumber *num) {
	double dVal = [num doubleValue];
	if (dVal >= 0.0) {
		return (dVal == ceil(dVal));
	}
	else {
		return (dVal == floor(dVal));
	}
}