//
//  Copy.h
//  copy_strong_weak_assign
//
//  Created by UBK on 2018/11/12.
//  Copyright © 2018 UBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Copy : NSObject

@property(nonatomic,strong) NSString *strStrong;
@property(nonatomic,copy) NSString *strCopy;

-(void)testCopy;

@end

NS_ASSUME_NONNULL_END
