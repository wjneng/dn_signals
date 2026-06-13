import 'package:dn_signals/dn_signals.dart';
import 'package:dn_signals/dn_signals_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelDnSignals();
  const channel = MethodChannel('dn_signals');
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          calls.add(methodCall);
          if (methodCall.method == 'getClickId') {
            return 'click-id';
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('initialize sends config map', () async {
    await platform.initialize(
      const DnSignalsConfig(
        actionSetId: 'set-id',
        secretKey: 'secret',
        autoStartEnabled: false,
      ),
    );

    expect(calls.single.method, 'initialize');
    expect(calls.single.arguments, <String, Object?>{
      'actionSetId': 'set-id',
      'secretKey': 'secret',
      'channel': null,
      'autoStartEnabled': false,
      'anidEnabled': null,
      'userUniqueId': null,
    });
  });

  test('logAction sends action and parameters', () async {
    await platform.logAction(
      DnSignalAction.purchase,
      parameters: <String, Object?>{'value': 100},
    );

    expect(calls.single.method, 'logAction');
    expect(calls.single.arguments, <String, Object?>{
      'actionName': DnSignalAction.purchase,
      'parameters': <String, Object?>{'value': 100},
    });
  });

  test('getClickId returns native value', () async {
    expect(await platform.getClickId(), 'click-id');
  });
}
