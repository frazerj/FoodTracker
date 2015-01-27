//
//  NSObject_CalculatorBrain.m
//  Calculator
//
//  Created by justin frazer on 1/23/15.
//  Copyright (c) 2015 jfrazer. All rights reserved.
//

#import "NSObject_CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end


@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}


- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOpertion:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"Sin"]) {
        double sinValue = [self popOperand];
        result = sin(sinValue);
    } else if ([operation isEqualToString:@"Cos"]) {
        double cosValue = [self popOperand];
        result = cos(cosValue);
    } else if ([operation isEqualToString:@"sqrt"]) { //taking the square root of a negative value will return 0
        double sqrtValue = [self popOperand];
        if (sqrtValue > 0) result = sqrt(sqrtValue);
    } else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
    } else if ([operation isEqualToString:@"C"]) {
        [_operandStack removeAllObjects];
    }
    
    [self pushOperand:result];
    return result;
}

@end
