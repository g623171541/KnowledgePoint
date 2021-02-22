//
//  ViewController2.m
//  RACDemo
//
//  Created by paddygu on 2021/1/8.
//  Copyright © 2021 paddygu. All rights reserved.
//

#import "ViewController2.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController2 ()
@property (nonatomic,strong) RACDisposable *disposable;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];

    
//    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"222222" object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//        NSLog(@"收到：%@",x);
//        }
//    ];
    
    self.disposable = [RACObserve(self, index) subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACObserve:%@",x);
    }];
}

- (void)dealloc
{
    NSLog(@"dealloc");
    NSLog(@"%@",self.disposable);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
