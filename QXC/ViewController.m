//
//  ViewController.m
//  QXC
//
//  Created by Nick_Zheng on 17/7/3.
//  Copyright © 2017年 nick. All rights reserved.
//  com.Foocaa.FoocaaMeeting
#define FZScreenH [UIScreen mainScreen].bounds.size.height
#define FZScreenW [UIScreen mainScreen].bounds.size.width


#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UIButton *parsingBtn;

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *tailLabel;

@property (nonatomic, strong) UITextView *headTextView;
@property (nonatomic, strong) UITextView *tailTextView;

@property (nonatomic, strong) UITextView *baiTextView;
@property (nonatomic, strong) UITextView *shiTextView;

@property (nonatomic, strong) UIScrollView *scrollView;


#define DEVICE_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  (IS_IPHONEX ? 754 : DEVICE_HEIGHT)
#define SCREEN_WIDTH   DEVICE_WIDTH


//----------------------系统----------------------------
//获取手机型号
#define IS_IPHONEUI   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPADUI     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE4     ((int)DEVICE_HEIGHT%480==0)
#define IS_IPHONE5     ((int)DEVICE_HEIGHT%568==0)
#define IS_IPAD        ((int)DEVICE_HEIGHT%1024==0)
#define IS_IPHONE6     ((int)DEVICE_HEIGHT%667==0)
#define IS_IPHONE6P    ((int)DEVICE_HEIGHT%736==0)
#define IS_IPHONEX     ((int)DEVICE_HEIGHT%812==0)

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%f", SCREEN_HEIGHT - 100);
    NSLog(@"%f", SCREEN_HEIGHT);
    
//    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.000];
    [self.view addSubview:self.numberTextField];
    [self.view addSubview:self.parsingBtn];
    [self.view addSubview:self.headLabel];
    [self.view addSubview:self.tailLabel];
    [self.view addSubview:self.headTextView];
    [self.view addSubview:self.tailTextView];
    [self.view addSubview:self.baiTextView];
    [self.view addSubview:self.shiTextView];
    [self.view addSubview:self.scrollView];


    
    NSArray *arr = @[@"头", @"百", @"十", @"尾", @"清空"];
    for (int i = 0; i < arr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0+(50*i), 60, 50);
        btn.tag = i;
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(parsingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
    }
    self.scrollView.contentSize = CGSizeMake(60, 250);
}

- (void)parsingBtnAction:(UIButton *)sender {
    
    if (sender.tag == 4) { // 清空
        self.headTextView.text = @"";
        self.tailTextView.text = @"";
        self.baiTextView.text = @"";
        self.shiTextView.text = @"";
        self.numberTextField.text = @"";
    }
    
    
    if (self.numberTextField.text.length < 10) {
        return;
    }
    NSMutableString *mString = [[NSMutableString alloc] init];
    NSMutableArray *letterArray = [NSMutableArray array];
    NSString *letters = self.numberTextField.text;
    [letters enumerateSubstringsInRange:NSMakeRange(0, [letters length])
                                options:(NSStringEnumerationByComposedCharacterSequences)
                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                 [letterArray addObject:substring];
                             }];
    

    int b[letterArray.count];//用来存储统计结果
    for(int i=0;i<letterArray.count;i++) {
        b[i]=0;
    }
    for(int i=0; i<letterArray.count; i++)
    {
        b[[letterArray[i] intValue]]++;
    }
    
    for (int i = 0 ; i < 10; i++) {
        if(b[i]) {
           
            [mString appendFormat:@"%@", [NSString stringWithFormat:@"%d ~~~ %d\n", i,  b[i]]];
        }
    }

    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@",mString] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
    
    if (sender.tag == 0) { // head
        self.headTextView.text = [NSString stringWithFormat:@"头 \n\n%@", mString];
    }
    if (sender.tag == 1) { // tail
        self.tailTextView.text = [NSString stringWithFormat:@"百 \n\n%@", mString];
    }
    if (sender.tag == 2) {
        self.baiTextView.text = [NSString stringWithFormat:@"十 \n\n%@", mString];;
    }
    if (sender.tag == 3) {
        self.shiTextView.text = [NSString stringWithFormat:@"个 \n\n%@", mString];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.headTextView resignFirstResponder];
    [self.tailTextView resignFirstResponder];
    [self.baiTextView resignFirstResponder];
    [self.shiTextView resignFirstResponder];
}

- (UITextField *)numberTextField {
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, FZScreenH/2 - 20, FZScreenW - 110, 50)];
        _numberTextField.layer.borderWidth = 0.5;
        _numberTextField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.000].CGColor;
        _numberTextField.clearButtonMode = UITextFieldViewModeAlways;
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _numberTextField;
}




- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(FZScreenW - 80, FZScreenH/2 - 20, 60, 50);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}










- (UITextView *)headTextView {
    if (!_headTextView) {
        _headTextView = [[UITextView alloc] init];
        _headTextView.frame = CGRectMake(0, 20, FZScreenW/2, FZScreenH/2-50);
//        _headTextView.backgroundColor = [UIColor redColor];
        _headTextView.font = [UIFont systemFontOfSize:20];
        _headTextView.textAlignment = NSTextAlignmentCenter;
    }
    return _headTextView;
}

- (UITextView *)tailTextView {
    if (!_tailTextView) {
        _tailTextView = [[UITextView alloc] init];
        _tailTextView.frame = CGRectMake(FZScreenW/2, 20, FZScreenW/2, FZScreenH/2-50);
//        _tailTextView.backgroundColor = [UIColor redColor];
        _tailTextView.font = [UIFont systemFontOfSize:20];
        _tailTextView.textAlignment = NSTextAlignmentCenter;
    }
    return _tailTextView;
}



- (UITextView *)baiTextView {
    if (!_baiTextView) {
        _baiTextView = [[UITextView alloc] init];
        _baiTextView.frame = CGRectMake(0, FZScreenH/2+40, FZScreenW/2, FZScreenH/2-50);
        //        _headTextView.backgroundColor = [UIColor redColor];
        _baiTextView.font = [UIFont systemFontOfSize:20];
        _baiTextView.textAlignment = NSTextAlignmentCenter;
    }
    return _baiTextView;
}

- (UITextView *)shiTextView {
    if (!_shiTextView) {
        _shiTextView = [[UITextView alloc] init];
        _shiTextView.frame = CGRectMake(FZScreenW/2, FZScreenH/2+40, FZScreenW/2, FZScreenH/2-50);
        //        _tailTextView.backgroundColor = [UIColor redColor];
        _shiTextView.font = [UIFont systemFontOfSize:20];
        _shiTextView.textAlignment = NSTextAlignmentCenter;
    }
    return _shiTextView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
