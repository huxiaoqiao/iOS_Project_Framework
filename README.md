# iOS项目工程通用架构
参考:http://limboy.me/ios/2013/09/23/build-ios-application.html
``` Objective-C
├── iOS_Project_Framework
│   ├── EntryPoint：这个目录下放的是AppDelegate.h(m)，是整个应用的入口文件
│   ├── Models：这个目录下放一些与数据相关的Model文件：
│   │   ├── BaseModel.h
│   │   ├── BaseModel.m
│   │   └── ……
│   ├── Macro：这个目录下放了整个应用会用到的宏定义：
│   │   ├── AppMacro.h
│   │   ├── NotificationMacro.h
│   │   ├── VendorMacro.h
│   │   └── UtilsMacro.h
│   │   └── ……
│   ├── General：这个目录放会被重用的Views/Classes/Categories:
│   │   ├── Views
│   │   │     ├── HHScrollView
│   │   │     ├── HHPullToRefresh
│   │   │     └── ……
│   │   ├── Classes
│   │   │     ├── HHBaseViewController
│   │   │     ├── HHBaseTabBarController
│   │   │     └── ……
│   │   ├── Categories
│   │   │     ├── UIViewController+Push
│   │   │     ├── UIImageView+Downloader
│   │   │     └── ……
│   ├── Helpers：这个目录放一些助手类，文件名与功能挂钩。
│   │   ├── HHShareHelper
│   │   ├── HHDBHelper
│   │   ├── HHEmotionHelper
│   │   └── ……
│   ├── Vendors：这个目录放第三方的类库/SDK，如UMeng、WeiboSDK、WeixinSDK等等。
│   └── Sections：这个目录下面的文件对应的是app的具体单元.
│   │   ├── Menu
│   │   ├── Setting
│   │   ├── Collection
│   │   └── ……
│   ├── Resources：这个目录下放的是app会用到的一些资源，主要是图片。
```
