//
//  CalculatorModel.m
//  MyCalculator
//
//  Created by megil on 8/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "CalculatorModel.h"
#define EQUAL -2
#define PLUS -3
#define MINUS -4
#define MUL -5
#define DIV -6

@implementation CalculatorModel

- (void) reset
{
    op1 = 0.0; // 存储操作数 1
    op2 = 0.0; // 存储操作数 2
    lastOp = -1; //上一次操作符
    op = -1; //本次操作符
    opc = nil;//当前显示的操作数
    result = 0.0;//上一次结果
    hasPoint = NO;//是否有小数点
    isError = NO;//是否有错误信息
    lastFun = -1;//上一次运算符
}
- (NSString *)getSymbol:(int)input
{
    NSString *symbol;
    switch (input) {
        case EQUAL:
            symbol = [NSString stringWithFormat:@"="];
            break;
        case PLUS:
            symbol = [NSString stringWithFormat:@"+"];
            break;
        case MINUS:
            symbol = [NSString stringWithFormat:@"-"];
            break;
        case DIV:
            symbol = [NSString stringWithFormat:@"/"];
            break;
        case MUL:
            symbol = [NSString stringWithFormat:@"×"];
            break;
        default:
            symbol = [NSString stringWithFormat:@""];
            break;
    }
    return symbol;
}

- (double) getResult:(int)input
{
    
    return 1.1;
}

- (int) checkType:(int)input
{
    if (input < 0)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

- (NSString *)operateWithNumber:(int)number
{
    if (![self checkInputLen:[opc length]]) {
        return nil;
    }
    if ( number==99 ) {
        // 输入小数点
        if ( hasPoint==NO ) {
            if ( [opc intValue]==0 ) {
                opc = @"0";
            }
            opc = [NSString stringWithFormat:@"%@.",opc];
            hasPoint = YES;
        }
    } else {
        // 输入数字
        if ( hasPoint==YES ) {
            opc = [NSString stringWithFormat:@"%@%d", opc, number];
        } else {
            if ( [opc intValue]==0 ) {
                //if ( number>0 ) {
                opc = [NSString stringWithFormat:@"%d", number];
                //}
            } else {
                opc = [NSString stringWithFormat:@"%@%d", opc, number];
            }
        }
    }
    if ( lastOp == EQUAL | lastOp == -1) {
        op1 = [opc doubleValue];
        //did_second = false;
    } else {
        op2 = [opc doubleValue];
    }
    //返回当前操作数
    lastInput = number;
    return opc;
}

- (bool)checkInputLen:(int)len
{
    if (len<10) {
        return YES;
    }else
    {
        return NO;
    }
}
- (NSString *)operateWithOp:(int)opt
{
    double _result = 0;
    
    if ( opt == EQUAL ) {
        if ( lastOp == -1 ){
            _result = [opc doubleValue];
        }else
        {
            if (lastInput < 0 )//上一次仍是操作符
            {
                if (lastInput == EQUAL) {
                    if (lastFun != -1) {
                       _result = [self calculate:result :op2 :lastFun];
                    }
                    else
                    {
                        _result = result;
                    }
                }
                else
                {
                    op2 = op1;
                    _result = [self calculate:op1 :op2 :lastOp];
                }
            }
            else
            {
                if (lastFun == -1) {
                    _result = [opc doubleValue];
                }else
                {
                    _result = [self calculate:op1 :op2 :lastFun];
                }
            }
        }
        result = _result;
        op1 = result;
        opc = @"";
    } else if ( opt<0 ) {
        if (lastOp==-1){
            _result = [opc doubleValue];
        }else
        {
            if (lastInput < 0) {
                _result = result;
            }
            else
            {
                if (lastOp == EQUAL) {
                    _result = [opc doubleValue];
                }
                else
                {
                    _result = [self calculate:op1 :op2 :lastOp];
                }
            }
        }
        
        //_result = [opc doubleValue];
        result = _result;
        op1 = result;
        opc = @"";
        lastFun = opt;
    } else {
        // functional addition
    }
    hasPoint = NO;
    lastOp = opt;
    
    if ( isError == 0 ) {
    } else {
        [self reset];
        return [NSString stringWithFormat:@"除数不能为0！"];
    }
    lastInput = opt;
    return [NSString stringWithFormat:@"%.10g", _result];
}

- (double)calculate:(double)number1 :(double)number2 :(int)operation
{
    NSLog(@"%f %f %d", number1, number2, operation);
    double _result;
    switch ( operation ) {
        case EQUAL:
            NSLog(@"EQUALerror~~~~~~~~~~~~~~~~~~~~");
            isError = YES;
            _result = number1;
            break;
        case PLUS:
            _result = number1 + number2;
            break;
        case MINUS:
            _result = number1 - number2;
            break;
        case MUL:
            _result = number1 * number2;
            break;
        case DIV:
            if ( number2 != 0 ) {
                _result = number1 / number2;
            } else {
                // ErrorID == 1 for Cant div 0
                isError = YES;
            }
            break;
        case -1:
            NSLog(@"-1error~~~~~~~~~~~~~~~~~~~~");
            isError = YES;
            _result = number1;
            break;
        default:
            break;
    }
    return _result;
}
@end
