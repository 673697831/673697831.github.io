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
#define MAX_LEN 10

@interface Calculator ()

@end

@implementation Calculator
@synthesize button1;
@synthesize label_result;
@synthesize label_op;
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
    [model reset];
    [label_result setText:[NSString stringWithFormat:@"0"]];
    [label_op setText:[NSString stringWithFormat:@""]];
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
    [self updateButtonStatus:sender];
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
    NSString *st = [model operateWithNumber:number];
    NSLog(@"operateWithNumber:%@", st);
    
    if (!st) {
        return;
    }
    
    
    [label_result setText:[NSString stringWithFormat:@"%@", st]];
}
// 输入操作符
-(void) inputAOperator:(NSInteger) opt{
    
    NSString *st = [NSString stringWithFormat:@"%@", [model operateWithOp:opt]];
    NSLog(@"operateWithOp:%@", st);
    [label_result setText:[NSString stringWithFormat:@"%@", st]];
    st = [NSString stringWithFormat:@"%@", [model getSymbol:opt]];
    [label_op setText:[NSString stringWithFormat:@"%@", st]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    model = [[CalculatorModel alloc]init];
    [self reset];
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
    f_result = CGRectMake(min_x, 138, 280, 38);
    label_op = [[UILabel alloc] initWithFrame:f_result];
    label_op.backgroundColor = [UIColor cyanColor];
    label_op.textColor = [UIColor blackColor];
    
    [self.view addSubview:label_op];
    
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
    
    UIButton *btn_sub = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_sub.frame = CGRectMake(min_x + 3 * 70, 400 - 40 *2, width, height);
    btn_sub.backgroundColor = [UIColor orangeColor];
    [btn_sub setTitle:[NSString stringWithFormat:@"-"] forState:UIControlStateNormal];
    [btn_sub setTag:-4];
    [btn_sub addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_sub];
    
    UIButton *btn_mul = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_mul.frame = CGRectMake(min_x + 3 * 70, 400 - 40 *3, width, height);
    btn_mul.backgroundColor = [UIColor orangeColor];
    [btn_mul setTitle:[NSString stringWithFormat:@"×"] forState:UIControlStateNormal];
    [btn_mul setTag:-5];
    [btn_mul addTarget:self action:@selector(inputOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_mul];
    
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
    
    dic = [NSMutableDictionary dictionary];
    [dic setObject:btn_plus forKey:@"+"];
    [dic setObject:btn_sub forKey:@"-"];
    [dic setObject:btn_mul forKey:@"*"];
    [dic setObject:btn_div forKey:@"/"];
    
    for (id key in dic) {
        UIButton *button = [dic objectForKey:key];
        CALayer *layer = button.layer;
        layer.borderWidth = 2;  // 给图层添加一个有色边框
        layer.borderColor = [UIColor orangeColor].CGColor;
    }
    [self reset];
}

- (void)updateButtonStatus:(id) sender
{
    for (id key in dic) {
        id object = [dic objectForKey:key];
        UIButton *b = object;
        CALayer *layer = b.layer;
        if (object == sender)
        {
            layer.borderColor = [UIColor blackColor].CGColor;
        }else
        {
            layer.borderColor = [UIColor orangeColor].CGColor;
        }
    }
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
