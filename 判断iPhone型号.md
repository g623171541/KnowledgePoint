# 判断iPhone型号
```
-(NSString *)getiPhoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *phoneType = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if([phoneType isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    if([phoneType isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    if([phoneType isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    if([phoneType isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    if([phoneType isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    if([phoneType isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    if([phoneType isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    if([phoneType isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    if([phoneType isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    if([phoneType isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    if([phoneType isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    if([phoneType isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    if([phoneType isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    if([phoneType isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    if([phoneType isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    if([phoneType isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    if([phoneType isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    if([phoneType isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    if([phoneType isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    if([phoneType isEqualToString:@"iPhone11,8"]) return@"iPhone XR";
    if([phoneType isEqualToString:@"iPhone11,2"]) return@"iPhone XS";
    if([phoneType isEqualToString:@"iPhone11,4"]) return@"iPhone XS Max";
    if([phoneType isEqualToString:@"iPhone11,6"]) return@"iPhone XS Max";
    return nil;
}
```