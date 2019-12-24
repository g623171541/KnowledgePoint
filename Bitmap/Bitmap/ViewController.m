//
//  ViewController.m
//  Bitmap
//
//  Created by ILIFE on 2019/12/21.
//  Copyright © 2019 ILIFE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBitmap];
}

-(void)creatBitmap{
    // 创建BitmapContext所需要的内存空间
    unsigned char *mapData = malloc(self.imageView.bounds.size.width * self.imageView.bounds.size.height * 4);
    
    // bitmap的宽度,单位为像素
    NSUInteger width = self.imageView.bounds.size.width;
    
    // bitmap的高度,单位为像素
    NSUInteger height = self.imageView.bounds.size.height;
    
    // bitsPerComponent：内存中像素的每个组件的位数.例如，对于32位像素格式和RGB颜色空间，你应该将这个值设为8.
    NSUInteger bitsPerComponent = 8;
    
    // bytesPerRow：bitmap的每行字节数(byte) 一个像素一个byte。图片每行的字节数=图片的列数*4（因为一个像素点有四个通道RGBA）
    NSUInteger bytesPerRow = width * 4;
    
    // CGColorSpaceRef：bitmap上下文使用的颜色空间
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceRGB();
    
    // bitmapInfo：指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串。
    /*
     kCGBitmapByteOrder32Little: 生成的信息位置为倒序
     kCGBitmapByteOrder32Big: 生成的信息位置为顺序
     kCGImageAlphaLast: RGBA
     kCGImageAlphaFirst: ARGB
     */
    NSUInteger bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    
    for (NSInteger i=0; i<40000; i=i+4) {
        if (i<5005) {
            mapData[i]=random()%255;
            mapData[i+1]=random()%255;
            mapData[i+2]=random()%255;
            mapData[i+3]=255;
        }else{
            mapData[i]=255;
            mapData[i+1]=0;
            mapData[i+2]=0;
            mapData[i+3]=255;
        }
    }
    
    
    CGContextRef context = CGBitmapContextCreate(mapData, 100, 100, bitsPerComponent, bytesPerRow, colorSapce, bitmapInfo);
//    CGContextDrawImage(context, CGRectMake(0, 0,100, 100), NULL);
    CGContextSetShouldAntialias(context,YES);
    NSLog(@"%@",CGBitmapContextCreateImage(context));
    self.imageView.image = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
}


@end
