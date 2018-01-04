//
//  ViewController.m
//  OC-js
//
//  Created by PaddyGu on 2017/12/29.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://m.dianping.com/tuan/deal/12383679"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

//UIWebViewDelegage代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSMutableString *stringM = [NSMutableString string];
    // 拼接移除顶部导航的JS代码
    [stringM appendString:@"var headerTag = document.getElementsByTagName('header')[0]; headerTag.parentNode.removeChild(headerTag);"];
    // 拼接移除橙色按钮的JS代码
    [stringM appendString:@"var footerBtnTag = document.getElementsByClassName('footer-btn-fix')[0]; footerBtnTag.parentNode.removeChild(footerBtnTag);"];
    // 拼接移除底部布局的JS代码
    [stringM appendString:@"var footerTag = document.getElementsByClassName('footer')[0]; footerTag.parentNode.removeChild(footerTag);"];
    // 拼接给img标签添加点击事件的JS代码
    [stringM appendString:@"var imgTag = document.getElementsByTagName('figure')[0].children[0]; imgTag.onclick = function(){window.location.href='https://www.baidu.com'};"];
    
    //设置立即购买按钮的背景颜色为红色
    [stringM appendString:@"var btn = document.getElementsByClassName('buy-btn')[0];btn.style.backgroundColor = '#ff00f0';"];

    // 这个方法就是UIWebView提供的.专门做JS注入的方法
    [webView stringByEvaluatingJavaScriptFromString:stringM];
}

@end
