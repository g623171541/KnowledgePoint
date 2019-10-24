//
//  ViewController.m
//  录制视频
//
//  Created by ILIFE on 2019/10/24.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<AVCaptureFileOutputRecordingDelegate>

// AVCaptureSession 会话，负责输入设备和输出设备的数据传递
@property (nonatomic,strong) AVCaptureSession *captureSession;
// 设备
@property (nonatomic,strong) AVCaptureDevice *device;
// 输入设备，视频输入
@property (nonatomic,strong) AVCaptureDeviceInput *videoInput;
// 输入设备，音频输入
@property (nonatomic,strong) AVCaptureDeviceInput *audioInput;
// 视频输出流
@property (nonatomic,strong) AVCaptureMovieFileOutput *output;
// 预览层
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (weak, nonatomic) IBOutlet UIButton *startStopBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化session
    self.captureSession = [[AVCaptureSession alloc] init];
    // 设置显示的分辨率
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset3840x2160]) {
        [self.captureSession setSessionPreset:AVCaptureSessionPreset3840x2160];
    }else{
        [self.captureSession setSessionPreset:AVCaptureSessionPreset1920x1080];
    }

    // 初始化device
    if (@available(iOS 10.2, *)) {
        self.device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDualCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    } else {
        // Fallback on earlier versions
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    // 添加设备的设置，必须先锁定，设置完后再解锁
    [self.device lockForConfiguration:nil];
    if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
        [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
    }
    [self.device unlockForConfiguration];

    // 初始化视频输入对象
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:nil];
    // 初始化音频输入对象
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:nil];

    // 将输入对象添加到会话中
    if ([self.captureSession canAddInput:self.audioInput]) {
        [self.captureSession addInput:self.videoInput];
        [self.captureSession addInput:self.audioInput];
    }

    // 初始化视频输出对象
    self.output = [[AVCaptureMovieFileOutput alloc] init];
    // 将输出对象添加到会话中
    if ([self.captureSession canAddOutput:self.output]) {
        [self.captureSession addOutput:self.output];
    }

    // 创建视图预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.frame = self.view.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];

    [self.captureSession startRunning];

}

#pragma mark - 开始结束
- (IBAction)start:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"结束"]) {
        [self.startStopBtn setTitle:@"开始" forState:UIControlStateNormal];
        NSLog(@"结束录制");
        [self.output stopRecording];
        return;
    }else{
        [self.startStopBtn setTitle:@"结束" forState:UIControlStateNormal];
        NSLog(@"开始录制");
        AVCaptureConnection *connection = [self.output connectionWithMediaType:AVMediaTypeVideo];
        connection.videoOrientation = [self.previewLayer connection].videoOrientation;

        NSURL *url = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"]];
        [self.output startRecordingToOutputFileURL:url recordingDelegate:self];
    }

}
-(void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error{
    NSLog(@"完成录制");
    NSLog(@"outputFileURL = %@",outputFileURL);

    //保存视频到相册
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:nil];

    ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc] init];
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"保存视频到相簿过程中发生错误，错误信息：%@",error.localizedDescription);
        }
        if (lastBackgroundTaskIdentifier!=UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:lastBackgroundTaskIdentifier];
        }
        NSLog(@"成功保存视频到相簿.");
    }];

}


#pragma mark - 设置尺寸
- (IBAction)setSize720p:(UIButton *)sender {
}

- (IBAction)setSize1280p:(UIButton *)sender {
}

- (IBAction)setSize4k:(UIButton *)sender {
}

#pragma mark - 设置FPS
- (IBAction)set30Fps:(UIButton *)sender {
}

- (IBAction)set60Fps:(UIButton *)sender {
}

@end
