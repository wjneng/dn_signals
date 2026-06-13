import 'package:dn_signals/dn_signals.dart';
import 'package:dn_signals/dn_signals_method_channel.dart';
import 'package:dn_signals/dn_signals_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDnSignalsPlatform
    with MockPlatformInterfaceMixin
    implements DnSignalsPlatform {
  DnSignalsConfig? config;
  String? actionName;
  Map<String, Object?>? parameters;

  @override
  Future<void> initialize(DnSignalsConfig config) async {
    this.config = config;
  }

  @override
  Future<void> logAction(
    String actionName, {
    Map<String, Object?>? parameters,
  }) async {
    this.actionName = actionName;
    this.parameters = parameters;
  }

  @override
  Future<void> start() async {}

  @override
  Future<String?> getClickId() async => 'click-id';

  @override
  Future<String?> getChannelId() async => 'channel-id';

  @override
  Future<bool?> getAutoStartEnabled() async => false;

  @override
  Future<void> setAutoStartEnabled(bool enabled) async {}

  @override
  Future<void> setAnidEnabled(bool enabled) async {}

  @override
  Future<void> setUserUniqueId(String userUniqueId) async {}

  @override
  Future<Map<String, Object?>?> getCaid() async => <String, Object?>{
    'caid': 'value',
  };

  @override
  Future<void> reportRegister({
    required String method,
    required bool isSuccess,
  }) async {}

  @override
  Future<void> reportLogin({
    required String method,
    required bool isSuccess,
  }) async {}

  @override
  Future<void> reportBindAccount({
    required String type,
    required bool isSuccess,
  }) async {}

  @override
  Future<void> reportQuestFinish({
    required String questId,
    required String questType,
    required String questName,
    required int questNumber,
    required String description,
    required bool isSuccess,
  }) async {}

  @override
  Future<void> reportCreateRole(String role) async {}

  @override
  Future<void> reportUpdateLevel(int level) async {}

  @override
  Future<void> reportViewContent({
    required String contentType,
    required String contentName,
    required String contentId,
  }) async {}

  @override
  Future<void> reportAddToCart({
    required String contentType,
    required String contentName,
    required String contentId,
    required int contentNumber,
    required bool isSuccess,
  }) async {}

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
  }) async {}

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
  }) async {}

  @override
  Future<void> reportAddPaymentChannel({
    required String channel,
    required bool isSuccess,
  }) async {}

  @override
  Future<void> reportRate(double rate) async {}

  @override
  Future<void> reportShare({
    required String channel,
    required bool isSuccess,
  }) async {}
}

void main() {
  test('$MethodChannelDnSignals is the default instance', () {
    expect(DnSignalsPlatform.instance, isInstanceOf<MethodChannelDnSignals>());
  });

  test('initialize delegates config to platform', () async {
    final fakePlatform = MockDnSignalsPlatform();
    DnSignalsPlatform.instance = fakePlatform;

    await DnSignals.instance.initialize(
      const DnSignalsConfig(actionSetId: 'set-id', secretKey: 'secret'),
    );

    expect(fakePlatform.config?.actionSetId, 'set-id');
    expect(fakePlatform.config?.secretKey, 'secret');
  });

  test('logAction delegates action and parameters to platform', () async {
    final fakePlatform = MockDnSignalsPlatform();
    DnSignalsPlatform.instance = fakePlatform;

    await DnSignals.instance.logAction(
      DnSignalAction.purchase,
      parameters: <String, Object?>{'value': 100},
    );

    expect(fakePlatform.actionName, DnSignalAction.purchase);
    expect(fakePlatform.parameters, <String, Object?>{'value': 100});
  });
}
