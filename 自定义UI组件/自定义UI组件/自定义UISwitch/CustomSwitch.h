//
//  CustomSwitch.h
//  自定义UI组件
//
//  Created by PaddyGu on 2018/8/22.
//  Copyright © 2018年 paddygu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSwitch : UIControl

@property (strong, nonatomic) UIColor *backgroundColor; // defaults to gray
@property (strong, nonatomic) UIColor *sliderColor; // defaults to white
@property (strong, nonatomic) UIColor *labelTextColorInsideSlider; // defaults to black
@property (strong, nonatomic) UIColor *labelTextColorOutsideSlider; // defaults to white
@property (strong, nonatomic) UIFont *font; // default is nil
@property (nonatomic) CGFloat cornerRadius; // defaults to 12
@property (nonatomic) CGFloat sliderOffset; // slider offset from background, top, bottom, left, right

@property (strong, nonatomic) NSMutableArray *labels;
@property (strong, nonatomic) NSMutableArray *onTopLabels;
@property (strong, nonatomic) NSArray *strings;

@property (strong, nonatomic) void (^handlerBlock)(NSUInteger index);
@property (strong, nonatomic) void (^willBePressedHandlerBlock)(NSUInteger index);

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *sliderView;

@property (nonatomic) NSInteger selectedIndex;


+ (instancetype)switchWithStringsArray:(NSArray *)strings;
- (instancetype)initWithStringsArray:(NSArray *)strings;
- (instancetype)initWithAttributedStringsArray:(NSArray *)strings;

// sets the index, also calls handler block
- (void)forceSelectedIndex:(NSInteger)index animated:(BOOL)animated;

// This method sets handler block that is getting called after the switcher is done animating the transition
- (void)setPressedHandler:(void (^)(NSUInteger index))handler;

// This method sets handler block that is getting called right before the switcher starts animating the transition
- (void)setWillBePressedHandler:(void (^)(NSUInteger index))handler;

// sets the index without calling the handler block
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;
@end
