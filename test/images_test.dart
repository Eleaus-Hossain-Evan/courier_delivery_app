import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:courier_delivery_app/utils/assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.deliveryBox).existsSync(), isTrue);
    expect(File(Images.logo).existsSync(), isTrue);
    expect(File(Images.iconFacebook).existsSync(), isTrue);
    expect(File(Images.iconGoogle).existsSync(), isTrue);
  });
}
