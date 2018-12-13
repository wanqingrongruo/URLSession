import UIKit

var str = "Hello, SessionConfiguration"

let defaultConfig = URLSessionConfiguration.default
let ephemeralConfig = URLSessionConfiguration.ephemeral
let backgroundConfig = URLSessionConfiguration.background(withIdentifier: "BackgroundConfiguration")

defaultConfig.allowsCellularAccess = false // 只能连接 wifi
defaultConfig.httpAdditionalHeaders = ["Accept": "application/json"]

let cookie = HTTPCookieStorage.shared
if let name = HTTPCookie(properties: [HTTPCookiePropertyKey.name: ""]) {
    cookie.setCookie(name)
}
defaultConfig.httpCookieStorage = cookie
defaultConfig.httpShouldSetCookies = true

defaultConfig.httpMaximumConnectionsPerHost = 1 // 一个主机只有一个连接

let proxyDict: [String : Any] = [
    "HTTPSEnable":true,
    "HTTPSProxy":"172.96.213.155",
    "HTTPSPort":11551
]
defaultConfig.connectionProxyDictionary = proxyDict  // 设置特定代理

defaultConfig.timeoutIntervalForRequest = 60

// NSURLSessionMultipathServiceType => @available(iOS 11.0, *)
// MPTCP => MultiPath TCP [MPTCP](https://www.jianshu.com/p/e5923160703c)
/* 后三种需要配置权限
 * none: 不使用 MPTCP
 * handover: 只有当主链路不能用的时候，才会使用第二条链路，这种模式可靠性高
 * interactive: 当主链路不够用的时候，比如丢包、延时很长等情况，就会启用第二条链路，这种模式延时低
 * aggregate: 为了更大的带宽，多条链路可以一起使用，当前仅限开发测试使用
 */
defaultConfig.multipathServiceType = .none

// 缓存策略
/*
 useProtocolCachePolicy: 默认的缓存策略，使用协议(http或者自定义的)中实现的缓存策略。对于常见的http协议来说，这个策略根据请求的Header来执行缓存策略。服务器可以在返回的响应Header中加入Expires策略或者Cache-Control策略来告诉客户端应该执行的缓存行为，同时配合#Last-Modified#等Header字段来控制刷新的时机。
 reloadIgnoringLocalCacheData: 忽略缓存，直接请求服务器数据
 reloadIgnoringLocalAndRemoteCacheData: 未实现
 returnCacheDataElseLoad: 本地如有缓存就使用，忽略其有效性，否则请求服务器。既然这种策略不考虑缓存的刷新时机，那我们使用是要额外地控制缓存过期逻辑。
 returnCacheDataDontLoad: 直接加载本地缓存，没有也不请求网络
 reloadRevalidatingCacheData :尚未实现
 */
defaultConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
//: [Next](@next)
