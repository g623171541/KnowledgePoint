//
//  GXDView.h
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXDView : UIView
@property (nonatomic,strong) RACSubject *btnClickSignal;
@end

NS_ASSUME_NONNULL_END
