//
//  AppDelegate.h
//  MyCalculator
//
//  Created by megil on 8/23/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Calculator *calculator;
}
@property (strong, nonatomic) UIWindow *window;

@end
