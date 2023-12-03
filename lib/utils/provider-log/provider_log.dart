import 'dart:developer';

import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLog extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Logger.i('''
{
  "PROVIDER": "${provider.name}; ${provider.runtimeType.toString()}"

}''');
    log("$newValue");
  }
}
