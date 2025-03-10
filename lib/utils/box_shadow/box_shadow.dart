import 'package:flutter/material.dart';

abstract class DefineBoxShadow {
  /// Shadowing
  static List<BoxShadow>? get noneShadow => kElevationToShadow[0];

  /// Shadowing
  static List<BoxShadow>? get shadow => kElevationToShadow[6];

  ///
  /// To give extra small shadow.
  ///
  static List<BoxShadow>? get shadowXs => kElevationToShadow[1];

  ///
  /// To give small shadow.
  ///
  static List<BoxShadow>? get shadowSm => kElevationToShadow[2];

  ///
  /// To give medium shadow.
  ///
  static List<BoxShadow>? get shadowMd => kElevationToShadow[3];

  ///
  /// To give large shadow.
  ///
  static List<BoxShadow>? get shadowLg => kElevationToShadow[4];

  ///
  /// To give extra large shadow.
  ///
  static List<BoxShadow>? get shadowXl => kElevationToShadow[6];

  ///
  /// To give twice extra large shadow.
  ///
  static List<BoxShadow>? get shadow2xl => kElevationToShadow[8];

  ///
  /// To give thrice extra large shadow.
  ///
  static List<BoxShadow>? get shadow3xl => kElevationToShadow[9];

  ///
  /// To give 4x extra large shadow.
  ///
  static List<BoxShadow>? get shadow4xl => kElevationToShadow[12];

  ///
  /// To give 5x extra large shadow.
  ///
  static List<BoxShadow>? get shadow5xl => kElevationToShadow[16];

  ///
  /// To give max shadow.
  ///
  static List<BoxShadow>? get shadowMax => kElevationToShadow[24];
}

const Map<int, List<BoxShadow>> kElevationToShadow =
    _elevationToShadow; // to hide the literal from the docs

const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12
const Map<int, List<BoxShadow>> _elevationToShadow = <int, List<BoxShadow>>{
  // The empty list depicts no elevation.
  0: <BoxShadow>[],

  1: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 1.0,
        spreadRadius: -1.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 1.0), blurRadius: 1.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 3.0,
        color: _kAmbientShadowOpacity),
  ],

  2: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 1.0,
        spreadRadius: -2.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 2.0), blurRadius: 2.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 5.0,
        color: _kAmbientShadowOpacity),
  ],

  3: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 3.0,
        spreadRadius: -2.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 3.0), blurRadius: 4.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 8.0,
        color: _kAmbientShadowOpacity),
  ],

  4: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 4.0,
        spreadRadius: -1.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 4.0), blurRadius: 5.0, color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 10.0,
        color: _kAmbientShadowOpacity),
  ],

  6: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 5.0,
        spreadRadius: -1.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 6.0),
        blurRadius: 10.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 18.0,
        color: _kAmbientShadowOpacity),
  ],

  8: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 5.0),
        blurRadius: 5.0,
        spreadRadius: -3.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 8.0),
        blurRadius: 10.0,
        spreadRadius: 1.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 14.0,
        spreadRadius: 2.0,
        color: _kAmbientShadowOpacity),
  ],

  9: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 5.0),
        blurRadius: 6.0,
        spreadRadius: -3.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 9.0),
        blurRadius: 12.0,
        spreadRadius: 1.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 16.0,
        spreadRadius: 2.0,
        color: _kAmbientShadowOpacity),
  ],

  12: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 7.0),
        blurRadius: 8.0,
        spreadRadius: -4.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 12.0),
        blurRadius: 17.0,
        spreadRadius: 2.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 5.0),
        blurRadius: 22.0,
        spreadRadius: 4.0,
        color: _kAmbientShadowOpacity),
  ],

  16: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 8.0),
        blurRadius: 10.0,
        spreadRadius: -5.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 16.0),
        blurRadius: 24.0,
        spreadRadius: 2.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 6.0),
        blurRadius: 30.0,
        spreadRadius: 5.0,
        color: _kAmbientShadowOpacity),
  ],

  24: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 11.0),
        blurRadius: 15.0,
        spreadRadius: -7.0,
        color: _kKeyUmbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 24.0),
        blurRadius: 38.0,
        spreadRadius: 3.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 9.0),
        blurRadius: 46.0,
        spreadRadius: 8.0,
        color: _kAmbientShadowOpacity),
  ],
};
