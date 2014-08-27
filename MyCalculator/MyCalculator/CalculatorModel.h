//
//  CalculatorModel.h
//  MyCalculator
//
//  Created by megil on 8/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject
{
    double op1; // 存储操作数 1
    double op2; // 存储操作数 2
    int lastOp; //上一次操作符
    int op; //本次操作符
    NSString * opc;//当前显示的操作数
    double result;//上一次结果
    bool hasPoint;//是否有小数点
    bool isError;//错误信息标志
    int lastInput;//上一次输入
    int lastFun;//上一次运算符,+-*/
}

- (void)reset;
- (int)checkLastInput;
- (NSString *)back;
- (double)getResult:(int)input;
- (bool)checkInputLen:(int)len;
- (NSString *)getSymbol:(int)input;
- (int)checkType:(int)input;//0表示操作符,1表示操作数
- (NSString *)operateWithNumber:(int)number;//输入操作数返回结果
- (NSString *)operateWithOp:(int)opt;//输入操作符返回结果
- (double) calculate:(double)number1 :(double)number2 :(int)operation;
@end
