//
//  ViewController.m
//  Calculator
//
//  Created by justin frazer on 1/14/15.
//  Copyright (c) 2015 jfrazer. All rights reserved.
//

#import "ViewController.h"
#import "NSObject_CalculatorBrain.h"

@interface ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userIsUsingAFloatingPointValue;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize stackDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userIsUsingAFloatingPointValue;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
   
    //self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:digit];
   
    if (self.userIsUsingAFloatingPointValue && [digit isEqualToString:@"."]) {
        return;
    }
    
    if(self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    if ([digit isEqualToString:@"."]) {
        userIsUsingAFloatingPointValue = YES;
    }
}


- (IBAction)enterPressed
{
    self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:self.display.text];
    self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:@" "];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userIsUsingAFloatingPointValue = NO;
}

- (IBAction)operationPressed:(id)sender

{
    NSString *operation = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:operation];
    self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:@" "];
    
    double result = [self.brain performOpertion:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    if([operation  isEqualToString: @"C"]) {
        self.display.text = @"0";
        self.stackDisplay.text = @" ";
        self.userIsUsingAFloatingPointValue = NO;
    } 
}

@end

