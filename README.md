# XYNav

[![CI Status](https://img.shields.io/travis/xiaoyouPrince/XYNav.svg?style=flat)](https://travis-ci.org/xiaoyouPrince/XYNav)
[![Version](https://img.shields.io/cocoapods/v/XYNav.svg?style=flat)](https://cocoapods.org/pods/XYNav)
[![License](https://img.shields.io/cocoapods/l/XYNav.svg?style=flat)](https://cocoapods.org/pods/XYNav)
[![Platform](https://img.shields.io/cocoapods/p/XYNav.svg?style=flat)](https://cocoapods.org/pods/XYNav)

## iOS 15

iOS 15 上苹果改变了导航条的部分默认行为，开发者可以自己设置 UINavigationBar 的各个 Appearance 属性，以确保在各种情况下 UINavigationBar 的正常展示

```
/// 控制 bar 在标准高度上的外观
@available(iOS 13.0, *)
@NSCopying open var standardAppearance: UINavigationBarAppearance

/// 控制 bar 在紧凑布局上的外观，如未设置就用 standardAppearance
@available(iOS 13.0, *)
@NSCopying open var compactAppearance: UINavigationBarAppearance?

/// 控制 bar 在其关联的 scrollView 滑动到bar顶部的时刻的外观，未设置使用 standardAppearance
@available(iOS 13.0, *)
@NSCopying open var scrollEdgeAppearance: UINavigationBarAppearance?

/// 控制 bar 在紧凑布局上，其关联的 scrollView 滑动到bar顶部的时刻的外观。如未设置依次尝试 scrollEdgeAppearance、compactAppearance、standardAppearance
@available(iOS 15.0, *)
@NSCopying open var compactScrollEdgeAppearance: UINavigationBarAppearance?
```

XYNav 统一默认了导航条背景颜色由属性 `barTintColor` 设置. 设置 `barTintColor` 后导航条颜色固定，且关联的 ScrollView 滑动不受影响。

### 快速设置统一的全局样式

iOS App 开发中通常需要设置一个导航栏主基调，如 `导航栏title字体属性，颜色，大小`，`navBar.tintColor`,`navBar.barTintColor` 等。 XYNav 支持 UIAppearance 的方式统一设置。

重点在于重写了 `UINavigationBar.appearance().barTintColor = .cyan` 的实现，实现了一次设置，各个子页面的默认样式为统一导航条背景颜色，具体页面也可以再次自定义需要的效果。

## Light / Dark Mode

XYNav 自动适配亮暗模式，使用无需关心

## iPhone X 

矩形屏和刘海屏自动适配，无需关心


## XYNav 是一个简单易用的导航控制器。

**目标:**

让开发过程更专注业务，让导航使用更加简单透明。
 
**核心功能:**

1. 让导航栈每个页面独立拥有自己的导航栏，单页面导航栏可完全自定义。
2. 全屏侧滑返回手势。单页面可独立控制是否支持侧滑返回、侧滑响应范围
3. 完全使用 UINavigationController 的 API，使用无缝切换
4. 提供增强版自定义 API，让使用更简单

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

## 特性 (UINavigationController API 完全支持)

- 支持	每个 VC 支持自定义的 `navigationBarClass`
- 支持 [Unwind](https://developer.apple.com/library/ios/technotes/tn2298/_index.html)
- 支持屏幕旋转
- 支持禁用侧滑返回手势
- 支持设置侧滑返回手势响应范围
- 支持 `Interface Builder / StoryBoard` 初始化的方式
- 支持统一的 UIAppearance 统一设置导航栏样式
- 支持亮、暗模式自动切换
- 支持系统导航栏透明效果

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

