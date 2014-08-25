//
//  Calculator.m
//  MyCalculator
//
//  Created by megil on 8/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "Calculator.h"
#define EQUAL -2
#define PLUS -3
#define MINUS -4
#define MUL -5
#define DIV -6

@interface Calculator ()

@end

@implementation Calculator
@synthesize button1;
@synthesize label_result;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) reset
{
    opc = @"";
    op1 = 0.0;
    op2 = 0.0;
    result = 0.0;
    second_num = 0;
    did_second = false;
    opi = 0;
    lastInput = -1;  // 上一个键入的内容类型0代表数字,1代表操作符
    lastSign = -1;
    hasPoint = NO;   // 是否输入了小数点
    lastOp = -1;    // 初始时为-1
    isError = 0;
    
    [label_result setText:[NSString stringWithFormat:@"%d", 0]];
}

-(IBAction) inputCommand:(id) sender {
    [self inputACommand: [sender tag]];
}
// Press a Numberic Button {0-9|.}
-(IBAction) inputNumberic:(id) sender {
    [self inputANumber: [sender tag]];
}
// Press a Operator Button {=|+|-|*|/}
-(IBAction) inputOperator:(id) sender{
    [self inputAOperator: [sender tag]];
}
// Press a Functional Button
-(IBAction) inputFunction:(id) sender{
    //[self inputAFunction:[sender tag]];
}

// 命令操作
-(void) inputACommand:(NSInteger) cmd {
    [self reset];
}
-(void) inputANumber:(NSInteger) number {
    //[label_result setText:[NSString stringWithFormat:@"%d", number]];
    if ( [opc length]>=4 ) {
        //return;
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
    if ( opi == 0 ) {
        op1 = [opc doubleValue];
        did_second = false;
    } else {
        op2 = [opc doubleValue];
        did_second = true;
        second_num = op2;
    }
    [label_result setText:[NSString stringWithFormat:@"%@", opc]];
}
// 输入操作符
-(void) inputAOperator:(NSInteger) opt{
    double _result = 0;
    
    if (opt !=EQUAL && lastOp !=EQUAL)
    {
        //lastInput = opt;
        //lastOp = opt;
        //return;
    }
    
    if ( opt==-2 ) {
        if ( lastOp == -1 ){
            if ( [opc doubleValue]!=0.0 ) {
                result = [opc doubleValue];
                opc = @"";
            }
            _result = result;
        }else
        {
            NSLog(@"%f,%f,%ld",op1,op2,(long)lastOp);
            _result = [self getResult:op1 :op2 :opt];
            result = _result;
        }
        
        lastNumber = &result;
        opi = 0;
        op1 = result;
        op2 = 0;
        opc = @"";
    } else if ( opt<0 ) {
        if (lastOp==-1){
            _result = [opc doubleValue];
        }else
        {
            _result = [self getResult:op1 :op2 :opt];
        }
        
        //_result = [opc doubleValue];
        result = _result;
        opi = 1;
        op1 = result;
        opc = @"";
        op2 = 0;
        lastSign = opt;
        //did_second = false;
    } else {
        // functional addition
    }
    hasPoint = NO;
    lastOp = opt;
    
    if ( isError == 0 ) {
        //[self displayResult: [NSString stringWithFormat:@"%g",_result]];
        [label_result setText:[NSString stringWithFormat:@"%.20g", _result]];
    } else {
        //[self displayError:isError];
        [label_result setText:[NSString stringWithFormat:@"除数不能为0！"]];
        isError = 0;
    }
    lastInput = opt;
    
    //[self debugInfo:@"操作完成\n"];
    
}



// 获得运算结果
-(double) getResult:(double)number1 :(double)number2 :(NSInteger)operation {
    double _result = 0;
    
    
    
    if (!did_second)
    {
        number2 = number1;
        did_second = true;
        second_num = number2;
    }
    else
    {
        number2 = second_num;
    }
        switch ( lastOp ) {
            case EQUAL:
                //_result = [self getResult:number1 :number2 :operation];
                // lastOp = -1;
                if (operation == EQUAL)
                {
                    //_result = [self getResult:number1 :number2:lastOp];
                    if (lastSign != -1)
                    {
                        lastOp = lastSign;
                        _result = [self getResult:number1 :number2:lastOp];
                    }else
                    {
                    
                    }
                }
                else{
                    _result = number1;
                }
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
                    isError = 1;
                }
                break;
            case -1:
                _result = number1;
                break;
            default:
                break;
    }
    return _result;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int min_x = 30;
    int max_y = 440;
    
    int width = 68;
    int height = 38;
    
    CGRect f_result = CGRectMake(min_x, 100, 280, 38);
    label_result = [[UILabel alloc] initWithFrame:f_result];
    label_result.backgroundColor = [UIColor cyanColor];
    label_result.textColor = [UIColor blackColor];
    label_result.textAlignment = UITextAlignmentRight;
    [self.view addSubview:label_result];
    
    UIButton *button_0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button_0.frame = CGRectMake(min_x, 440, width * 2 + 2, height);
    button_0.backgroundColor = [UIColor orangeColor];
    [button_0 setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
    [button_0 setTag:0];
    [button_0 addTarget:self action:@selector(inputNumberic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_0];
    
    UIButton *button_point = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button_point.frame = CGRectMake(min_x + width * 2 + 2+2, max_y, width, height);
    button_point.backgroundColor = [UIColor orangeColor];
    [button_point setTitle:[NSString stringWithFormat:@"."] forState:UIControlStateNormal];
    [button_point setTag:99];
    [button_point addTarget:self action:@selector(inputNumberic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_point];

    for(int i = 1; i<4; i++)
    {
        for(int j = 1; j<4; j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            int x = min_x + j *70 - 70;
            int y = 400 - i * 40 + 40;
            button.frame = CGRectMake(x, y, width, height);
            button.backgroundColor = [UIColor orangeColor];
            [button setTitle:[NSString stringWithFormat:@"%d",j + (i - 1) * 3] forState:UIControlStateNormal];
            [button setTag:(j + (i - 1) * 3)];
            [button addTarget:self action:@selector(inputNumberic:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    UIButton *ebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ebtn.frame = CGRectMake(min_x + 3 * 70, 400, width, height * 2+2);
    ebtn.backgroundColor = [UIColor orangeColor];
    [ebtn setTitle:[NSString stringWithFormat:@"="] forState:UIControlStateNormal];
    [ebtn setTag:-2];
    [ebtn addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ebtn];
    
    UIButton *btn_plus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_plus.frame = CGRectMake(min_x + 3 * 70, 400 - 40, width, height);
    btn_plus.backgroundColor = [UIColor orangeColor];
    [btn_plus setTitle:[NSString stringWithFormat:@"+"] forState:UIControlStateNormal];
    [btn_plus setTag:-3];
    [btn_plus addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_plus];
    
    UIButton *btn_mi = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_mi.frame = CGRectMake(min_x + 3 * 70, 400 - 40 *2, width, height);
    btn_mi.backgroundColor = [UIColor orangeColor];
    [btn_mi setTitle:[NSString stringWithFormat:@"-"] forState:UIControlStateNormal];
    [btn_mi setTag:-4];
    [btn_mi addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_mi];
    
    UIButton *btn_times = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_times.frame = CGRectMake(min_x + 3 * 70, 400 - 40 *3, width, height);
    btn_times.backgroundColor = [UIColor orangeColor];
    [btn_times setTitle:[NSString stringWithFormat:@"×"] forState:UIControlStateNormal];
    [btn_times setTag:-5];
    [btn_times addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_times];
    
    UIButton *btn_div = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_div.frame = CGRectMake(min_x + 2 * 70, 400 - 40 *3, width, height);
    btn_div.backgroundColor = [UIColor orangeColor];
    [btn_div setTitle:[NSString stringWithFormat:@"÷"] forState:UIControlStateNormal];
    [btn_div setTag:-6];
    [btn_div addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_div];
    // Do any additional setup after loading the view.
    
    UIButton *btn_clear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_clear.frame = CGRectMake(min_x, 400 - 40 *3, width, height);
    btn_clear.backgroundColor = [UIColor orangeColor];
    [btn_clear setTitle:[NSString stringWithFormat:@"C"] forState:UIControlStateNormal];
    [btn_clear addTarget:self action:@selector(inputCommand:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_clear];
    
    [self reset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
