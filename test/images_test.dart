import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:courier_delivery_app/utils/assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.boxs).existsSync(), isTrue);
    expect(File(Images.deliveryBoxCheck).existsSync(), isTrue);
    expect(File(Images.deliveryBoxIcon).existsSync(), isTrue);
    expect(File(Images.deliveryBoxList).existsSync(), isTrue);
    expect(File(Images.deliveryBoxLoading).existsSync(), isTrue);
    expect(File(Images.deliveryBoxes3d).existsSync(), isTrue);
    expect(File(Images.logoOriginal).existsSync(), isTrue);
    expect(File(Images.logo).existsSync(), isTrue);
    expect(File(Images.iconUser).existsSync(), isTrue);
    expect(File(Images.iconFacebook).existsSync(), isTrue);
    expect(File(Images.iconGoogle).existsSync(), isTrue);
    expect(File(Images.jsonNoDataAnimation).existsSync(), isTrue);
  });
}
