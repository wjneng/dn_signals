import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dn_signals_method_channel.dart';
import 'src/dn_signals_config.dart';

abstract class DnSignalsPlatform extends PlatformInterface {
  DnSignalsPlatform() : super(token: _token);

  static final Object _token = Object();

  static DnSignalsPlatform _instance = MethodChannelDnSignals();

  static DnSignalsPlatform get instance => _instance;

  static set instance(DnSignalsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize(DnSignalsConfig config) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> start() {
    throw UnimplementedError('start() has not been implemented.');
  }

  Future<void> logAction(
    String actionName, {
    Map<String, Object?>? parameters,
  }) {
    throw UnimplementedError('logAction() has not been implemented.');
  }

  Future<String?> getClickId() {
    throw UnimplementedError('getClickId() has not been implemented.');
  }

  Future<String?> getChannelId() {
    throw UnimplementedError('getChannelId() has not been implemented.');
  }

  Future<bool?> getAutoStartEnabled() {
    throw UnimplementedError('getAutoStartEnabled() has not been implemented.');
  }

  Future<void> setAutoStartEnabled(bool enabled) {
    throw UnimplementedError('setAutoStartEnabled() has not been implemented.');
  }

  Future<void> setAnidEnabled(bool enabled) {
    throw UnimplementedError('setAnidEnabled() has not been implemented.');
  }

  Future<void> setUserUniqueId(String userUniqueId) {
    throw UnimplementedError('setUserUniqueId() has not been implemented.');
  }

  Future<Map<String, Object?>?> getCaid() {
    throw UnimplementedError('getCaid() has not been implemented.');
  }

  Future<void> reportRegister({
    required String method,
    required bool isSuccess,
  }) {
    throw UnimplementedError('reportRegister() has not been implemented.');
  }

  Future<void> reportLogin({required String method, required bool isSuccess}) {
    throw UnimplementedError('reportLogin() has not been implemented.');
  }

  Future<void> reportBindAccount({
    required String type,
    required bool isSuccess,
  }) {
    throw UnimplementedError('reportBindAccount() has not been implemented.');
  }

  Future<void> reportQuestFinish({
    required String questId,
    required String questType,
    required String questName,
    required int questNumber,
    required String description,
    required bool isSuccess,
  }) {
    throw UnimplementedError('reportQuestFinish() has not been implemented.');
  }

  Future<void> reportCreateRole(String role) {
    throw UnimplementedError('reportCreateRole() has not been implemented.');
  }

  Future<void> reportUpdateLevel(int level) {
    throw UnimplementedError('reportUpdateLevel() has not been implemented.');
  }

  Future<void> reportViewContent({
    required String contentType,
    required String contentName,
    required String contentId,
  }) {
    throw UnimplementedError('reportViewContent() has not been implemented.');
  }

  Future<void> reportAddToCart({
    required String contentType,
    required String contentName,
    required String contentId,
    required int contentNumber,
    required bool isSuccess,
  }) {
    throw UnimplementedError('reportAddToCart() has not been implemented.');
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
    throw UnimplementedError('reportCheckout() has not been implemented.');
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
    throw UnimplementedError('reportPurchase() has not been implemented.');
  }

  Future<void> reportAddPaymentChannel({
    required String channel,
    required bool isSuccess,
  }) {
    throw UnimplementedError(
      'reportAddPaymentChannel() has not been implemented.',
    );
  }

  Future<void> reportRate(double rate) {
    throw UnimplementedError('reportRate() has not been implemented.');
  }

  Future<void> reportShare({required String channel, required bool isSuccess}) {
    throw UnimplementedError('reportShare() has not been implemented.');
  }
}
