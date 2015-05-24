//
//  AppMacro.h
//  iOS项目的目录结构和开发流程_OC
//
//  Created by 胡晓桥 on 15/5/1.
//  Copyright (c) 2015年 胡晓桥. All rights reserved.
//
/**
 *  @author Hiram
 *
 *  App相关宏定义
 */
#ifndef iOS_____________OC_AppMacro_h
#define iOS_____________OC_AppMacro_h
// 导航栏高度
#define kNavigationBarHeight 44.f
// 屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
// 当前系统版本号
#define kCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
// 当前的系统语言
#define kCurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]
// keyWindow
#define kKeyWindow  [UIApplication sharedApplication].keyWindow

// 常用颜色
#define kNavBackgroundColor      //导航栏背景色

// DLog
#define DEBUG_MODE 1
#if DEBUG_MODE
#define DLog(s,...) NSLog(@"<%p %@:(%d)> %@",self,[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__LINE__,[NSString stringWithFormat:(s),##__VA_ARGS__])
#else
#define DLog(s,...)
#endif

// GCD后台线程和主线程
#define BACK_GCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define MAIN_GCD(block) dispatch_async(dispatch_get_main_queue(),block)

#endif
