class DnSignalsConfig {
  const DnSignalsConfig({
    required this.actionSetId,
    required this.secretKey,
    this.channel,
    this.autoStartEnabled,
    this.anidEnabled,
    this.userUniqueId,
  });

  final String actionSetId;
  final String secretKey;

  /// Android SDK 可选渠道字符串。
  final String? channel;

  /// Android 可选项：是否启用自动启动上报。
  final bool? autoStartEnabled;

  /// Android 可选项：是否启用 anid 采集。
  final bool? anidEnabled;

  /// Android 可选项：业务用户唯一标识。
  final String? userUniqueId;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'actionSetId': actionSetId,
      'secretKey': secretKey,
      'channel': channel,
      'autoStartEnabled': autoStartEnabled,
      'anidEnabled': anidEnabled,
      'userUniqueId': userUniqueId,
    };
  }
}
