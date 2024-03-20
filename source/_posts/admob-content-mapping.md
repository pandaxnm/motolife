---
title: Admob广告 内容映射实践
date: 2023-08-07 12:16:21
img: https://images.mokeee.com/202308071224260.png
cover: true
coverImg: https://images.mokeee.com/202308071224260.png
categories: 技术
tags: 
- Admob
- 广告

---

最近公司的广告项目接入了 Admob 广告的 Content Mapping（内容映射），特此记录一下
<!-- more -->

## 是什么
Admob Content Mapping 是一种广告内容映射，可以将广告内容映射到应用的内容上，从而提高广告的点击率。

如下图所示，在我们的APP中有一个列表，其中有一条广告，内容映射需要做的就是将这个广告上下的内容回传给 Admob，Admob 会根据这些内容来匹配广告。

![](https://images.mokeee.com/202308071224260.png)

## 为什么要使用

- 对于**发布商**，内容映射可以提高广告与用户之间的相关性，这有助于广告客户提高针对您广告资源的出价，从而提升创收潜力。此功能还可以进一步保障广告客户的广告不会投放到不利于品牌形象的内容中，进而使更多广告客户能够放心地针对您的广告资源进行出价。

- 对于**广告客户**，内容映射可以在移动应用中放置相关性更高的广告，从而提升广告效果，还可以阻止广告在不合适的内容旁边展示，从而进一步保障广告客户的品牌形象。

- 对于**用户**，内容映射可以向用户展示相关性更高的广告，从而提升用户体验。

## 如何使用

我将按照我的业务逻辑，分为几个部分来介绍：  
1. Admob 后台设置
2. 服务端开发（广告下发）
3. APP 端开发（回传Url）
4. H5页面开发（被抓取的页面）

### Admob 后台设置

1. **Search Console 配置**  
    在 [Search Console](https://search.google.com/search-console/welcome?utm_source=wmx&utm_medium=deprecation-pane&utm_content=home) 中添加需要被 Admob 抓取的域名，验证域名所属权。
2. **Admob 后台配置**  
   1. 登录 [Admob 后台](https://apps.admob.com)
   2. 点击 **设置** -> **抓取工具访问权**
   3. 添加登录信息：
    - 登录信息：填写抓取工具需要登录的网址以及登录方式（GET、POST）和登录参数（用户名密码）
    - 受限目录或网址：填写你回传给 Admob 的网址，也就是需要被抓取工具抓取的网址

### 服务端开发
   在下发广告时，需要在返回的内容中添加 `contentUrl`、`neighboringContentUrls` 字段，这两个字段的值就是需要客户端回传给 Admob 抓取的页面Url

**Url及页面内容 注意事项：**
1. Url 必须是与用户在APP中看到的内容相匹配，如果提供虚假的内容，可能会被 Admob 处罚
2. Url 和页面内容中不得传递与用户身份信息或违反用户协议的内容
3. Url 必须具有唯一性，不能传递一个通用网址，不得重复，也就是需要具体到用户的某一次广告请求行为，我们可以通过在 Url 中添加参数来保证唯一性

### APP 端开发
   客户端从服务端获取到广告内容后，调用 Admob SDK 中的 `setContentUrl()` 和 ` setNeighboringContentUrls()` 设置回传的 Url
> 注意: `setContentUrl()` 只能设置一个 Url，而 ` setNeighboringContentUrls()` 可以设置多个 Url

### H5页面开发
1. **登录页面**  
提供一个和在 Admob 后台配置的登录信息一致的登录页面，登录成功后写入Cookie
2. **被抓取的内容页面**  
在显示内容之前，先获取客户端 Cookie 进行身份验证，只有在身份验证成功后才显示内容，避免敏感信息泄露。





