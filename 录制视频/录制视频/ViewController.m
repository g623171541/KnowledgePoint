//
//  ViewController.m
//  录制视频
//
//  Created by ILIFE on 2019/10/24.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

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
    AVCaptureDeviceDiscoverySession *deviceDiscoverySession =  [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    for (AVCaptureDevice *device in deviceDiscoverySession.devices) {
        if (AVCaptureDevicePositionBack == device.position) {
            self.device = device;
            NSLog(@"self.device:%@",self.device);
        }
    }
//    if (@available(iOS 10.2, *)) {
//        self.device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
//    } else {
//        // Fallback on earlier versions
//        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    }
    
    
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
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
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
    // 设置图层显示的方向
    self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;

    [self.captureSession startRunning];
}


#pragma mark - 开始结束
- (IBAction)start:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"结束"]) {
        if ([self.output isRecording]) {
            [self.output stopRecording];
        }
        [self.startStopBtn setTitle:@"开始" forState:UIControlStateNormal];
        NSLog(@"结束录制");
    }else{
        if ([self.output isRecording]) {
            NSLog(@"还在录制，无法开始");
            return;
        }
        [self.startStopBtn setTitle:@"结束" forState:UIControlStateNormal];
        NSLog(@"开始录制");
        AVCaptureConnection *connection = [self.output connectionWithMediaType:AVMediaTypeVideo];
        connection.videoOrientation = [self.previewLayer connection].videoOrientation;

        // 设置保存的路径
        NSURL *url = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:[self getNowTimeTimestamp]]];
        [self.output startRecordingToOutputFileURL:url recordingDelegate:self];
    }

}
-(void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error{
    NSLog(@"完成录制");
    NSLog(@"outputFileURL = %@",outputFileURL);

    //保存视频到相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputFileURL];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"%@", [NSString stringWithFormat:@"保存---%@",success?@"成功":@"失败"]);
    }];
}


#pragma mark - 设置尺寸
- (IBAction)setSize720p:(UIButton *)sender {
    [self resetSessionPreset:self.captureSession resolution:720];
}
- (IBAction)setSize1280p:(UIButton *)sender {
    [self resetSessionPreset:self.captureSession resolution:1080];
}
- (IBAction)setSize4k:(UIButton *)sender {
    [self resetSessionPreset:self.captureSession resolution:2160];
}
#pragma mark - 设置分辨率
- (void)resetSessionPreset:(AVCaptureSession *)m_session resolution:(int)resolution{
    [m_session beginConfiguration];
    switch (resolution) {
        case 1080:
            m_session.sessionPreset = [m_session canSetSessionPreset:AVCaptureSessionPreset1920x1080] ? AVCaptureSessionPreset1920x1080 : AVCaptureSessionPresetHigh;
            break;
        case 720:
            m_session.sessionPreset = [m_session canSetSessionPreset:AVCaptureSessionPreset1280x720] ? AVCaptureSessionPreset1280x720 : AVCaptureSessionPresetMedium;
            break;
        case 2160: // 3840*2160 4k
            m_session.sessionPreset = [m_session canSetSessionPreset:AVCaptureSessionPreset3840x2160] ? AVCaptureSessionPreset3840x2160 : AVCaptureSessionPresetHigh;
            break;
            
        default:
            break;
    }
    [m_session commitConfiguration];
}


#pragma mark - 设置FPS
- (IBAction)set30Fps:(UIButton *)sender {
    [self settingFrameRate:30];
}
- (IBAction)set60Fps:(UIButton *)sender {
    [self settingFrameRate:60];
}
- (void)settingFrameRate:(int)frameRate{
    NSLog(@"%@",[self.device formats]);
    
    AVCaptureDevice *captureDevice = self.device;
    for(AVCaptureDeviceFormat *vFormat in [captureDevice formats]) {
        CMFormatDescriptionRef description = vFormat.formatDescription;
        float maxRate = ((AVFrameRateRange*) [vFormat.videoSupportedFrameRateRanges objectAtIndex:0]).maxFrameRate;
        if (maxRate >= frameRate && CMFormatDescriptionGetMediaSubType(description) == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
            if ([captureDevice lockForConfiguration:NULL] == YES) {
                // 对比镜头支持的分辨率和当前设置的分辨率
                CMVideoDimensions dims = CMVideoFormatDescriptionGetDimensions(description);
                if (dims.height == 2160 && dims.width == 3840) {
                    [self.captureSession beginConfiguration];
                    if ([captureDevice lockForConfiguration:NULL]){
                        captureDevice.activeFormat = vFormat;
                        [captureDevice setActiveVideoMinFrameDuration:CMTimeMake(1, frameRate)];
                        [captureDevice setActiveVideoMaxFrameDuration:CMTimeMake(1, frameRate)];
                        [captureDevice unlockForConfiguration];
                        NSLog(@"已设置：%dfps",frameRate);
                    }
                    [self.captureSession commitConfiguration];

                }
            }
        }
    }
}

#pragma mark - 工具
-(NSString *)getNowTimeTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f.mp4", a];   //转为字符型 mp4或mov都可以
    return timeString;
}
@end
