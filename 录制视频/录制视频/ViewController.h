//
//  ViewController.h
//  录制视频
//
//  Created by ILIFE on 2019/10/24.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btn720;
@property (weak, nonatomic) IBOutlet UIButton *btn1280;
@property (weak, nonatomic) IBOutlet UIButton *btn4k;
@property (weak, nonatomic) IBOutlet UIButton *btn30fps;
@property (weak, nonatomic) IBOutlet UIButton *btn60fps;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

