import 'dn_signals_platform_interface.dart';
import 'src/dn_signal_action.dart';
import 'src/dn_signals_config.dart';

export 'src/dn_signal_action.dart';
export 'src/dn_signals_config.dart';

/// 广点通转化 SDK 的 Flutter 调用入口。
///
/// 插件不会自动初始化或自动上报，初始化、启动和事件上报时机都由业务侧
/// Flutter 代码控制。
class DnSignals {
  DnSignals._();

  static final DnSignals instance = DnSignals._();

  /// 初始化广点通转化 SDK。
  ///
  /// [actionSetId] 和 [secretKey] 均应由业务 App 在运行时传入，不建议硬编码
  /// 到插件内部。Android 侧 SDK 文档建议在 Application.onCreate 阶段初始化；
  /// Flutter 项目通常可在 `main()` 中 `runApp` 前调用。
  Future<void> initialize(DnSignalsConfig config) {
    return DnSignalsPlatform.instance.initialize(config);
  }

  /// 启动 SDK 数据上报。
  Future<void> start() {
    return DnSignalsPlatform.instance.start();
  }

  /// 上报标准或自定义行为。
  ///
  /// 标准行为可使用 [DnSignalAction] 常量；自定义行为直接传字符串。
  Future<void> logAction(
    String actionName, {
    Map<String, Object?>? parameters,
  }) {
    return DnSignalsPlatform.instance.logAction(
      actionName,
      parameters: parameters,
    );
  }

  /// Android: 获取 Click ID；iOS 不支持时返回 null。
  Future<String?> getClickId() {
    return DnSignalsPlatform.instance.getClickId();
  }

  /// Android: 获取 Channel ID；iOS 不支持时返回 null。
  Future<String?> getChannelId() {
    return DnSignalsPlatform.instance.getChannelId();
  }

  /// Android: 是否自动上报启动行为；iOS 不支持时返回 null。
  Future<bool?> getAutoStartEnabled() {
    return DnSignalsPlatform.instance.getAutoStartEnabled();
  }

  /// Android: 控制 SDK 自动启动上报；iOS 不支持时为空操作。
  Future<void> setAutoStartEnabled(bool enabled) {
    return DnSignalsPlatform.instance.setAutoStartEnabled(enabled);
  }

  /// Android: 控制 anid 采集；iOS 不支持时为空操作。
  Future<void> setAnidEnabled(bool enabled) {
    return DnSignalsPlatform.instance.setAnidEnabled(enabled);
  }

  /// Android: 设置业务侧用户唯一标识；iOS 不支持时为空操作。
  Future<void> setUserUniqueId(String userUniqueId) {
    return DnSignalsPlatform.instance.setUserUniqueId(userUniqueId);
  }

  /// iOS: 获取 CAID 信息；Android 不支持时返回 null。
  Future<Map<String, Object?>?> getCaid() {
    return DnSignalsPlatform.instance.getCaid();
  }

  Future<void> reportRegister({
    required String method,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportRegister(
      method: method,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportLogin({required String method, required bool isSuccess}) {
    return DnSignalsPlatform.instance.reportLogin(
      method: method,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportBindAccount({
    required String type,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportBindAccount(
      type: type,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportQuestFinish({
    required String questId,
    required String questType,
    required String questName,
    required int questNumber,
    required String description,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportQuestFinish(
      questId: questId,
      questType: questType,
      questName: questName,
      questNumber: questNumber,
      description: description,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportCreateRole(String role) {
    return DnSignalsPlatform.instance.reportCreateRole(role);
  }

  Future<void> reportUpdateLevel(int level) {
    return DnSignalsPlatform.instance.reportUpdateLevel(level);
  }

  Future<void> reportViewContent({
    required String contentType,
    required String contentName,
    required String contentId,
  }) {
    return DnSignalsPlatform.instance.reportViewContent(
      contentType: contentType,
      contentName: contentName,
      contentId: contentId,
    );
  }

  Future<void> reportAddToCart({
    required String contentType,
    required String contentName,
    required String contentId,
    required int contentNumber,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportAddToCart(
      contentType: contentType,
      contentName: contentName,
      contentId: contentId,
      contentNumber: contentNumber,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportCheckout({
    required String contentType,
    required String contentName,
    required String contentId,
    required int contentNumber,
    required bool isVirtualCurrency,
    required String virtualCurrencyType,
    required String realCurrencyType,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportCheckout(
      contentType: contentType,
      contentName: contentName,
      contentId: contentId,
      contentNumber: contentNumber,
      isVirtualCurrency: isVirtualCurrency,
      virtualCurrencyType: virtualCurrencyType,
      realCurrencyType: realCurrencyType,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportPurchase({
    required String contentType,
    required String contentName,
    required String contentId,
    required int contentNumber,
    required String paymentChannel,
    required String realCurrency,
    required int currencyAmount,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportPurchase(
      contentType: contentType,
      contentName: contentName,
      contentId: contentId,
      contentNumber: contentNumber,
      paymentChannel: paymentChannel,
      realCurrency: realCurrency,
      currencyAmount: currencyAmount,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportAddPaymentChannel({
    required String channel,
    required bool isSuccess,
  }) {
    return DnSignalsPlatform.instance.reportAddPaymentChannel(
      channel: channel,
      isSuccess: isSuccess,
    );
  }

  Future<void> reportRate(double rate) {
    return DnSignalsPlatform.instance.reportRate(rate);
  }

  Future<void> reportShare({required String channel, required bool isSuccess}) {
    return DnSignalsPlatform.instance.reportShare(
      channel: channel,
      isSuccess: isSuccess,
    );
  }
}
