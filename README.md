WhatsInApp
==========

**See What`s in your iOS App**

方便在程序运行时查看:

1. UserDefaults
2. Local Notification
3. File System (可查看sqlite数据库,markdown文件)

###使用
1. 将 `WhatsInApp_build` 目录中的文件导入项目，并在项目中引入 `libsqlite3.dylib`
2. 在 `AppDelegate.h` 中 加入 `[WhatsInApp start];`
```objective-c
///AppDelegate.h
#import "WhatsInApp.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //start it
  [WhatsInApp start];
  return YES;
}
```
###try it

`双指长按` 屏幕任意位置(在程序任意运行时刻).  **See What`s in your app now**
