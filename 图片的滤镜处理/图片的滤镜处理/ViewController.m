//
//  ViewController.m
//  图片的滤镜处理
//
//  Created by paddygu on 2019/6/15.
//  Copyright © 2019 ILFE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self convertFormatTest];
    [self testImageGray];
    [self testImageReColor];
    [self testImageHighlight];
}

-(void)testImageHighlight{
    UIImage *image = [UIImage imageNamed:@"sea.jpeg"];
    // 图片转data
    unsigned char *imageData = [self convertUIImageToData:image];
    // 将data处理为灰色
    unsigned char *newImageData = [self imageHighlightWithData:imageData width:image.size.width height:image.size.height];
    // data转图片
    self.imageView4.image = [self convertDataToUIImage:newImageData image:image];
}

-(void)testImageReColor{
    UIImage *image = [UIImage imageNamed:@"sea.jpeg"];
    // 图片转data
    unsigned char *imageData = [self convertUIImageToData:image];
    // 将data处理为彩色
    unsigned char *newImageData = [self imageReColorWithData:imageData width:image.size.width height:image.size.height];
    // data转图片
    self.imageView3.image = [self convertDataToUIImage:newImageData image:image];
}

// 图片转为灰色
-(void)testImageGray{
    UIImage *image = [UIImage imageNamed:@"sea.jpeg"];
    // 图片转data
    unsigned char *imageData = [self convertUIImageToData:image];
    // 将data处理为灰色
    unsigned char *newImageData = [self imageGrayWithData:imageData width:image.size.width height:image.size.height];
    // data转图片
    self.imageView2.image = [self convertDataToUIImage:newImageData image:image];
}

// UIImage -> data -> UIImage
-(void)convertFormatTest{
    UIImage *image = [UIImage imageNamed:@"sea.jpeg"];
    // 图片转data
    unsigned char *imageData = [self convertUIImageToData:image];
    // data转图片
    self.imageView1.image = [self convertDataToUIImage:imageData image:image];
}





#pragma mark - UIImage转为data
-(unsigned char *)convertUIImageToData:(UIImage *)image{
    // 将UIImage转化为CGImage
    CGImageRef imageRef = [image CGImage];
    // 创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 分配bit空间 即 unsigned char *的大小：每个像素点=4Byte(RGBA)
    void *data = malloc(image.size.height * image.size.width * 4);// malloc 内存分配
    // 创建上下文
    /*
     bitsPerComponent：每个元素（R/G/B/A）的位数，1B（byte，字节）= 8 bit,所以这个值为8
     bytePerRow：每行多少个字节
     kCGImageAlphaPremultipliedLast：颜色排列顺序 R-G-B-A
     */
    CGContextRef context = CGBitmapContextCreate(data, image.size.width, image.size.height, 8, image.size.width * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    // 渲染：将UIImage -> data
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    
    // 要释放
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    return (unsigned char *)data;
}

#pragma mark - data转UIImage
-(UIImage *)convertDataToUIImage:(unsigned char *)imageData image:(UIImage *)imageSource{
    CGFloat width = imageSource.size.width;
    CGFloat height = imageSource.size.height;
    NSInteger dataLength = width * height * 4;// data应该有的长度
    
    // 提供原始数据
    CGDataProviderRef provide = CGDataProviderCreateWithData(NULL, imageData, dataLength, NULL);
    
    int bitsPerComponent = 8; //每个元素（R/G/B/A）的位数
    int bitsPerPiexl = 32; // 每个像素的位数 4 * 8
    int bytesPerRow = width * 4; // 每行的字节数
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapiInfo = kCGBitmapByteOrderDefault;   // 描述信息
    CGColorRenderingIntent renderIntent = kCGRenderingIntentDefault; // 渲染
    
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPiexl, bytesPerRow, colorSpaceRef, bitmapiInfo, provide, NULL, NO, renderIntent);
    UIImage *imageNew = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provide);
    return imageNew;
}

#pragma mark - 图片改为灰色
-(unsigned char *)imageGrayWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height{
    // 分配内存空间，每个unsigned char占一个字节，RGBA的R占一个字节
    unsigned char *resultData = malloc(width * height * sizeof(unsigned char) * 4);
    // 将新分配的内存空间填充0，填充个数为：width * height * sizeof(unsigned char) * 4，即初始化这块内存空间，因为之前可能有人用过，有垃圾数据
    memset(resultData, 0, width * height * sizeof(unsigned char) * 4);
    for (int h=0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h * width + w;// 第几个像素
            unsigned char bitmapRed = *(imageData + imageIndex * 4);// 地址偏移，每个像素有RGBA四个值
            unsigned char bitmapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitmapBlue = *(imageData + imageIndex * 4 + 2);
            
            int bitmap = bitmapRed*77/255 + bitmapGreen*151/255 + bitmapBlue*88/255;
            //            int bitmap = (bitmapRed + bitmapGreen + bitmapBlue)/3;// 此方法也可以，官网推荐上面这种
            unsigned char newBitmap = bitmap>255 ? 255 : bitmap;
            memset(resultData + imageIndex * 4, newBitmap, 1);
            memset(resultData + imageIndex * 4 + 1, newBitmap, 1);
            memset(resultData + imageIndex * 4 + 2, newBitmap, 1);
        }
    }
    return resultData;
}

#pragma mark - 彩色底板算法
-(unsigned char *)imageReColorWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height{
    unsigned char *resultData = malloc(width * height * sizeof(unsigned char) * 4);
    memset(resultData, 0, width * height * sizeof(unsigned char) * 4);
    for (int h=0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h * width + w;// 第几个像素
            unsigned char bitmapRed = *(imageData + imageIndex * 4);// 地址偏移，每个像素有RGBA四个值
            unsigned char bitmapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitmapBlue = *(imageData + imageIndex * 4 + 2);
            
            unsigned char newBitmapRed = 255 - bitmapRed;
            unsigned char newBitmapGreen = 255 - bitmapGreen;
            unsigned char newBitmapBlue = 255 - bitmapBlue;
            memset(resultData + imageIndex * 4, newBitmapRed, 1);
            memset(resultData + imageIndex * 4 + 1, newBitmapGreen, 1);
            memset(resultData + imageIndex * 4 + 2, newBitmapBlue, 1);
        }
    }
    return resultData;
}

#pragma mark - 图片美白高亮算法
-(unsigned char *)imageHighlightWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height{
    unsigned char *resultData = malloc(width * height * sizeof(unsigned char) * 4);
    memset(resultData, 0, width * height * sizeof(unsigned char) * 4);
    // 8个特殊点
    NSArray *colorArrayBase = @[@"55",@"110",@"155",@"185",@"220",@"240",@"250",@"255"];
    NSMutableArray *colorArray = [NSMutableArray array];
    int beforNum = 0;
    // 变成256个颜色对应点
    for (int i=0; i<8; i++) {
        NSString *numStr = colorArrayBase[i];
        int num = numStr.intValue;
        float step = 0;// 设置步长
        if (i == 0) {
            step = num / 32.0;
            beforNum = num;
        }else{
            step = (num - beforNum) / 32.0;
        }
        for (int j=0; j<32; j++) {
            int newNum = 0;
            if (i == 0) {
                newNum = (int)(j*step);
            } else {
                newNum = (int)(j*step + beforNum);
            }
            NSString *newNumStr = [NSString stringWithFormat:@"%d",newNum];
            [colorArray addObject:newNumStr];
        }
        beforNum = num;
    }
    
    for (int h=0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h * width + w;// 第几个像素
            unsigned char bitmapRed = *(imageData + imageIndex * 4);// 地址偏移，每个像素有RGBA四个值
            unsigned char bitmapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitmapBlue = *(imageData + imageIndex * 4 + 2);
            
            unsigned char newBitmapRed = [colorArray[bitmapRed] intValue];
            unsigned char newBitmapGreen = [colorArray[bitmapGreen] intValue];
            unsigned char newBitmapBlue = [colorArray[bitmapBlue] intValue];
            memset(resultData + imageIndex * 4, newBitmapRed, 1);
            memset(resultData + imageIndex * 4 + 1, newBitmapGreen, 1);
            memset(resultData + imageIndex * 4 + 2, newBitmapBlue, 1);
        }
    }
    
    return resultData;
}
@end
