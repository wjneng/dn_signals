import 'package:dn_signals/dn_signals.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExampleHomePage());
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final TextEditingController _actionSetIdController = TextEditingController();
  final TextEditingController _secretKeyController = TextEditingController();
  String _status = '未初始化';

  @override
  void dispose() {
    _actionSetIdController.dispose();
    _secretKeyController.dispose();
    super.dispose();
  }

  Future<void> _run(String label, Future<void> Function() action) async {
    try {
      await action();
      if (!mounted) return;
      setState(() => _status = '$label 成功');
    } catch (error) {
      if (!mounted) return;
      setState(() => _status = '$label 失败：$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('dn_signals example')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _actionSetIdController,
            decoration: const InputDecoration(labelText: 'Action Set ID'),
          ),
          TextField(
            controller: _secretKeyController,
            decoration: const InputDecoration(labelText: 'Secret Key'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _run('初始化', () {
              return DnSignals.instance.initialize(
                DnSignalsConfig(
                  actionSetId: _actionSetIdController.text,
                  secretKey: _secretKeyController.text,
                  autoStartEnabled: false,
                ),
              );
            }),
            child: const Text('初始化 SDK'),
          ),
          FilledButton.tonal(
            onPressed: () => _run('启动', DnSignals.instance.start),
            child: const Text('Start'),
          ),
          FilledButton.tonal(
            onPressed: () => _run('上报启动', () {
              return DnSignals.instance.logAction(DnSignalAction.startApp);
            }),
            child: const Text('上报 START_APP'),
          ),
          FilledButton.tonal(
            onPressed: () => _run('上报注册', () {
              return DnSignals.instance.reportRegister(
                method: 'WeChat',
                isSuccess: true,
              );
            }),
            child: const Text('上报注册'),
          ),
          const SizedBox(height: 16),
          Text(_status),
        ],
      ),
    );
  }
}
