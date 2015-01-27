//
//  NSObject_CalculatorBrain.h
//  Calculator
//
//  Created by justin frazer on 1/14/15.
//  Copyright (c) 2015 jfrazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOpertion:(NSString *)operation;

@end
