import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_result_screen.dart';

final barcodeProvider = StateProvider<BarcodeCapture>((ref) {
  return BarcodeCapture();
}, name: "barcodeProvider");

class ScanScreen extends HookConsumerWidget {
  static const route = '/scan';

  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final overlayText = useState("Please Scan...");

    final controller = useMemoized<MobileScannerController>(() {
      return MobileScannerController(
        formats: const [BarcodeFormat.all],
        autoStart: true,
      );
    }, const []);

    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(const Offset(0, -80)),
      width: 300,
      height: 100,
    );

    void onBarcodeDetect(BarcodeCapture barcodeCapture) {
      final barcode = barcodeCapture.barcodes.last;

      overlayText.value = barcodeCapture.barcodes.last.displayValue ??
          barcode.rawValue ??
          'Barcode has no displayable value';
    }

    useEffect(() {
      Future.microtask(
        () => controller.barcodes.listen((event) {
          Logger.d('event: $event');
          if (event.barcodes.isNotEmpty &&
              event.barcodes.first.displayValue != null) {
            ref.read(barcodeProvider.notifier).update((e) => event);

            Future.delayed(const Duration(milliseconds: 500),
                () => context.replace(ScanResultScreen.route));
          }
        }),
      );
      return null;
    }, []);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanner with Overlay Example app'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: MobileScanner(
                fit: BoxFit.contain,
                onDetect: onBarcodeDetect,
                overlay: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: const Alignment(0, .4),
                    child: Opacity(
                      opacity: 1,
                      child: Text(
                        overlayText.value,
                        style: const TextStyle(
                          backgroundColor: Colors.black26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                controller: controller,
                scanWindow: scanWindow,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
              ),
            ),
            Center(
              child: controller.isStarting
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
            ),
            CustomPaint(
              painter: ScannerOverlay(scanWindow),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ValueListenableBuilder<TorchState>(
                  valueListenable: controller.torchState,
                  builder: (context, value, child) {
                    final Color iconColor;
                    final IconData icon;

                    switch (value) {
                      case TorchState.off:
                        iconColor = Colors.white;
                        icon = Icons.flashlight_on;
                        break;
                      case TorchState.on:
                        iconColor = Colors.yellow;
                        icon = Icons.flashlight_on_outlined;
                        break;
                    }

                    return IconButton.filled(
                      onPressed: () => controller.toggleTorch(),
                      icon: Icon(
                        icon,
                        color: iconColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;
  final double borderRadius = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    // Create a Paint object for the white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Adjust the border width as needed

    // Calculate the border rectangle with rounded corners
// Adjust the radius as needed
    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // Draw the white border
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
        break;
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
        break;
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
