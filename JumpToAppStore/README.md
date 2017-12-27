# JumpToAppStore
直接跳转到App Store，两种方法

### 1.跳转到AppStore,进行评分：
      
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id391945719"]];

### 2.另一种是在应用内,内置AppStore进行评分:

        //苹果提供了一个框架StoreKit.framework,导入StoreKit.framework,在需要跳转的控制器里面添加头文件#import, 实现代理方法：< SKStorePRoductViewControllerDelegate >
        
        // 初始化控制器
        SKStoreProductViewController*storeProductViewContorller = [[SKStoreProductViewController alloc] init];

        // 设置代理请求为当前控制器本身

        storeProductViewContorller.delegate = self;

        [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@391945719} completionBlock:^(BOOL result,NSError*error)   {

            if(error)  {
                NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
            }else{
                // 模态弹出appstore
                [self presentViewController:storeProductViewContorller animated:YES completion:nil];
            }

        }];

