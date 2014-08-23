//
//  Calculator.h
//  MyCalculator
//
//  Created by megil on 8/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculator : UIViewController
{
    IBOutlet UILabel *label_result;
    IBOutlet UIButton *button0;
    IBOutlet UIButton *button1;
    NSMutableArray *numberArray;
    
    double op1; // 存储操作数 1
    double op2; // 存储操作数 2
    double cache;   // 缓存
    double result;  // 上一次计算的结果缓存
    
    NSString * opc; // 当前操作数
    
    NSInteger lastOp;   // 上一次操作
    NSInteger isError;  // 是否存在错误
    int opi;        // 当前操作数序号
    bool hasPoint;   // 是否输入了小数点
    int lastInput;  // 最后输入的类型
}
@property(nonatomic,retain)IBOutlet UIButton *button1;
@property(nonatomic,retain)IBOutlet UIButton *button0;
@property(nonatomic,retain)IBOutlet UILabel *label_result;


// 重置状态
-(void) reset;
-(void) resetAll;

-(IBAction) inputCommand:(id) sender;
-(IBAction) inputNumberic:(id) sender;
-(IBAction) inputOperator:(id) sender;
-(IBAction) inputFunction:(id) sender;
@end
