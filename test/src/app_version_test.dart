// ignore_for_file: prefer_const_constructors

import 'package:app_version/app_version.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppVersion', () {
    test('can be instantiated', () {
      expect(AppVersion(), isNotNull);
    });
  });
}
