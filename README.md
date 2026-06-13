# dn_signals

`dn_signals` 是腾讯 DataNexus / 广点通转化 SDK 的 Flutter 插件封装。插件只封装原生 SDK 能力，不会自动初始化或自动上报事件；初始化参数、调用时机和上报时机都由 Flutter 端控制。

## 支持平台

- Android 7.0 / API 24 及以上
- iOS 13.0 及以上

当前内置 SDK 版本：

- Android: `GDTActionSDK 1.9.7`，以 `GDTActionSDK-1.9.7.jar` + `jniLibs` 形式随包分发
- iOS: `LibGDTActionSDK 2.1.4`

## 安装

```yaml
dependencies:
  dn_signals: ^0.0.1
```

## 平台配置

### Android

插件已声明 SDK 常用权限：

- `android.permission.INTERNET`
- `android.permission.ACCESS_NETWORK_STATE`
- `android.permission.READ_PHONE_STATE`

`READ_PHONE_STATE` 属于运行时权限，厂商 SDK 建议申请以提高归因准确性，但不是强制要求。业务 App 如需申请权限，应在调用上报接口前自行处理授权。

### iOS

插件 Pod 要求 iOS 13.0 及以上，并链接厂商静态库所需系统框架。若业务 App 需要在 iOS 14+ 获取 IDFA，应由业务 App 自行在合适时机请求 ATT 权限，并配置 `NSUserTrackingUsageDescription`。

## 初始化

建议在 `main()` 中、`runApp()` 前初始化。参数不要写在插件内部，应由业务 App 从自己的配置体系传入。

```dart
import 'package:flutter/widgets.dart';
import 'package:dn_signals/dn_signals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DnSignals.instance.initialize(
    const DnSignalsConfig(
      actionSetId: 'your_action_set_id',
      secretKey: 'your_secret_key',
      autoStartEnabled: false,
    ),
  );

  await DnSignals.instance.start();

  runApp(const MyApp());
}
```

Android 厂商文档建议初始化尽量发生在 Application 启动阶段，且必须在其他上报接口前调用。Flutter 项目中请确保先 `initialize()`，再调用 `start()` 或任何上报方法。

如果未先调用 `initialize()` 就调用 `start()`、`logAction()` 或便捷事件方法，插件会在 Flutter 侧直接抛出 `StateError`。这些方法返回成功只表示调用已交给原生 SDK，不代表厂商服务端已经完成归因或入库。

## 标准/自定义行为上报

```dart
await DnSignals.instance.logAction(DnSignalAction.startApp);

await DnSignals.instance.logAction(
  DnSignalAction.purchase,
  parameters: <String, Object?>{
    'value': 6800,
    'name': 'Pixel 2 XL',
  },
);

await DnSignals.instance.logAction('CUSTOM_ACTION_NAME');
```

## 便捷事件

插件封装了 Android `ActionUtils` 和 iOS `GDTAction+convenience` 中常用事件：

```dart
await DnSignals.instance.reportRegister(
  method: 'WeChat',
  isSuccess: true,
);

await DnSignals.instance.reportLogin(
  method: 'phone',
  isSuccess: true,
);

await DnSignals.instance.reportPurchase(
  contentType: 'equipment',
  contentName: 'AK47',
  contentId: 'sku_ak47',
  contentNumber: 1,
  paymentChannel: 'WeChatPay',
  realCurrency: 'CNY',
  currencyAmount: 648,
  isSuccess: true,
);
```

## 平台差异接口

```dart
final clickId = await DnSignals.instance.getClickId(); // Android only
final channelId = await DnSignals.instance.getChannelId(); // Android only
final caid = await DnSignals.instance.getCaid(); // iOS only
```

不支持的平台会返回 `null` 或执行空操作。

## 发布前检查

```bash
dart format .
flutter analyze
flutter test
flutter pub publish --dry-run
```

发布到 pub.dev 前，请确认你有权随包分发内置的 Android jar/so 和 iOS 静态库。
