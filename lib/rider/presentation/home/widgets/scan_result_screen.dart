import 'package:courier_delivery_app/rider/presentation/home/widgets/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../presentation/widgets/widgets.dart';

class ScanResultScreen extends HookConsumerWidget {
  static const route = '/scan_result';

  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capture = ref.watch(barcodeProvider);
    Logger.i("capture: ${capture.barcodes.first.displayValue}");
    return Scaffold(
      appBar: const KAppBar(
        titleText: 'ScanResult',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            capture.barcodes.first.displayValue.toString().text.make(),
          ],
        ),
      ),
    );
  }
}
