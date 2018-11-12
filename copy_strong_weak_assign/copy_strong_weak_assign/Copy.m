//
//  Copy.m
//  copy_strong_weak_assign
//
//  Created by UBK on 2018/11/12.
//  Copyright © 2018 UBK. All rights reserved.
//

#import "Copy.h"

@implementation Copy

-(void)testCopy{
    
    NSMutableString *str = [NSMutableString string];
    [str setString:@"string"];
    
    self.strCopy = str;
    self.strStrong = str;
    
    NSLog(@"copy:%@",self.strCopy);         // copy:string
    NSLog(@"strong:%@",self.strStrong);     // strong:string
    
    
    // 修改原有的字符串
    [str setString:@"ohter"];
    
    NSLog(@"copy:%@",self.strCopy);         // copy:string
    NSLog(@"strong:%@",self.strStrong);     // strong:ohter
    
    // 如果是用copy修饰的属性，修改了原有的字符串，该属性不发生变化
    // 如果是用strong修饰的属性，修改了原字符串，属性随之变化。
    // 发生在用NSMutableString类型给NSString类型赋值时，为了防止赋值的属性内容被无意中修改，所以用copy修饰
    
}

@end
