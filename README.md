# XYNav

[![CI Status](https://img.shields.io/travis/xiaoyouPrince/XYNav.svg?style=flat)](https://travis-ci.org/xiaoyouPrince/XYNav)
[![Version](https://img.shields.io/cocoapods/v/XYNav.svg?style=flat)](https://cocoapods.org/pods/XYNav)
[![License](https://img.shields.io/cocoapods/l/XYNav.svg?style=flat)](https://cocoapods.org/pods/XYNav)
[![Platform](https://img.shields.io/cocoapods/p/XYNav.svg?style=flat)](https://cocoapods.org/pods/XYNav)

> XYNav 是一个简单易用的导航控制器。
> 
> 核心功能: 
> 1.让导航栈每个页面独立拥有自己的导航栏，单页面导航栏可完全自定义。
> 2.全屏侧滑返回手势。单页面可独立控制是否支持侧滑返回、侧滑响应范围
> 3.完全使用 UINavigationController 的 API，使用无缝切换

## Demos

![](https://github.com/xiaoyouPrince/XYNav/blob/main/demo.gif)

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.


## 零成本接入

直接向使用系统导航栏一样，无缝切换。使用 `XYNav` 你需要做的只有一件事

```
// 纯代码创建 - 直接替换 UINavigationController 即可
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    // 直接 XYNavigationController 创建并设置为 rootVC 即可
    let vc = ViewController()
    let nav = XYNavigationController(rootViewController: vc)
    window?.rootViewController = nav
    
    return true
}
```

如果使用 StoryBoard 创建，只需要将 StoryBoard 中导航控制器指定 Class 为 XYNavigationController 即可，如图
 
![](https://github.com/xiaoyouPrince/XYNav/blob/main/use_sb.png)

### 功能接口完全同步系统

- 支持 StoryBoard 初始化的方式

## Requirements

- Swift 5.0
- iOS 9.0

## Installation

XYNav is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XYNav'
```

## Author

xiaoyouPrince, xiaoyouPrince@163.com

## License

XYNav is available under the MIT license. See the LICENSE file for more info.


https://www.youtube.com/watch?v=Yk4s-WLjxug

