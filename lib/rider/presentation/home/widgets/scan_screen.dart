import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_result_screen.dart';

final barcodeProvider = StateProvider<BarcodeCapture>((ref) {
  return BarcodeCapture();
});

class ScanScreen extends HookConsumerWidget {
  static const route = '/scan';

  const ScanScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        // fit: BoxFit.contain,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          // for (final barcode in barcodes) {
          //   debugPrint('Barcode found! ${barcode.rawValue}');
          // }
          Logger.i("capture: ${capture.height}");
          Logger.i("barcodes: ${barcodes.first.toString()}");
          ref.read(barcodeProvider.notifier).update((state) => capture);
          context.push(ScanResultScreen.route);
        },
      ),
    );
  }
}
