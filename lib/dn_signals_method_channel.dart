import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dn_signals_platform_interface.dart';
import 'src/dn_signals_config.dart';

class MethodChannelDnSignals extends DnSignalsPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('dn_signals');

  @override
  Future<void> initialize(DnSignalsConfig config) {
    return methodChannel.invokeMethod<void>('initialize', config.toMap());
  }

  @override
  Future<void> start() {
    return methodChannel.invokeMethod<void>('start');
  }

  @override
  Future<void> logAction(
    String actionName, {
    Map<String, Object?>? parameters,
  }) {
    return methodChannel.invokeMethod<void>('logAction', <String, Object?>{
      'actionName': actionName,
      'parameters': parameters,
    });
  }

  @override
  Future<String?> getClickId() {
    return methodChannel.invokeMethod<String>('getClickId');
  }

  @override
  Future<String?> getChannelId() {
    return methodChannel.invokeMethod<String>('getChannelId');
  }

  @override
  Future<bool?> getAutoStartEnabled() {
    return methodChannel.invokeMethod<bool>('getAutoStartEnabled');
  }

  @override
  Future<void> setAutoStartEnabled(bool enabled) {
    return methodChannel.invokeMethod<void>('setAutoStartEnabled', enabled);
  }

  @override
  Future<void> setAnidEnabled(bool enabled) {
    return methodChannel.invokeMethod<void>('setAnidEnabled', enabled);
  }

  @override
  Future<void> setUserUniqueId(String userUniqueId) {
    return methodChannel.invokeMethod<void>('setUserUniqueId', userUniqueId);
  }

  @override
  Future<Map<String, Object?>?> getCaid() async {
    final result = await methodChannel.invokeMapMethod<String, Object?>(
      'getCaid',
    );
    return result == null ? null : Map<String, Object?>.from(result);
  }

  @override
  Future<void> reportRegister({
    required String method,
    required bool isSuccess,
  }) {
    return _invokeReport('reportRegister', <String, Object?>{
      'method': method,
      'isSuccess': isSuccess,
    });
  }

  @override
  Future<void> reportLogin({required String method, required bool isSuccess}) {
    return _invokeReport('reportLogin', <String, Object?>{
      'method': method,
      'isSuccess': isSuccess,
    });
  }

  @override
  Future<void> reportBindAccount({
    required String type,
    required bool isSuccess,
  }) {
    return _invokeReport('reportBindAccount', <String, Object?>{
      'type': type,
      'isSuccess': isSuccess,
    });
  }

  @override
  Future<void> reportQuestFinish({
    required String questId,
    required String questType,
    required String questName,
    required int questNumber,
    required String description,
    required bool isSuccess,
  }) {
    return _invokeReport('reportQuestFinish', <String, Object?>{
      'questId': questId,
      'questType': questType,
      'questName': questName,
      'questNumber': questNumber,
      'description': description,
      'isSuccess': isSuccess,
    });
  }

  @override
  Future<void> reportCreateRole(String role) {
    return _invokeReport('reportCreateRole', <String, Object?>{'role': role});
  }

  @override
  Future<void> reportUpdateLevel(int level) {
    return _invokeReport('reportUpdateLevel', <String, Object?>{
      'level': level,
    });
  }

  @override
  Future<void> reportViewContent({
    required String contentType,
    required String contentName,
    required String contentId,
  }) {
    return _invokeReport('reportViewContent', <String, Object?>{
      'contentType': contentType,
      'contentName': contentName,
      'contentId': contentId,
    });
  }

  @override
  Future<void> reportAddToCart({
    required String contentType,
    required String contentName,
    required String contentId,
    required int contentNumber,
    required bool isSuccess,
  }) {
    return _invokeReport('reportAddToCart', <String, Object?>{
      'contentType': contentType,
      'contentName': contentName,
      'contentId': contentId,
      'contentNumber': contentNumber,
      'isSuccess': isSuccess,
    });
  }

  @override
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
    return _invokeReport('reportCheckout', <String, Object?>{
      'contentType': contentType,
      'contentName': contentName,
      'contentId': contentId,
      'contentNumber': contentNumber,
      'isVirtualCurrency': isVirtualCurrency,
      'virtualCurrencyType': virtualCurrencyType,
      'realCurrencyType': realCurrencyType,
      'isSuccess': isSuccess,
    });
  }

  @override
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
    return _invokeReport('reportPurchase', <String, Object?>{
      'contentType': contentType,
      'contentName': contentName,
      'contentId': contentId,
      'contentNumber': contentNumber,
      'paymentChannel': paymentChannel,
      'realCurrency': realCurrency,
      'currencyAmount': currencyAmount,
      'isSuccess': isSuccess,
    });
  }

  @override
  Future<void> reportAddPaymentChannel({
    required String channel,
    required bool isSuccess,
  }) {
    return _invokeReport('reportAddPaymentChannel', <String, Object?>{
      'channel': channel,
      'isSuccess': isSuccess,
    });
  }

  @override
  Future<void> reportRate(double rate) {
    return _invokeReport('reportRate', <String, Object?>{'rate': rate});
  }

  @override
  Future<void> reportShare({required String channel, required bool isSuccess}) {
    return _invokeReport('reportShare', <String, Object?>{
      'channel': channel,
      'isSuccess': isSuccess,
    });
  }

  Future<void> _invokeReport(String method, Map<String, Object?> arguments) {
    return methodChannel.invokeMethod<void>(method, arguments);
  }
}
