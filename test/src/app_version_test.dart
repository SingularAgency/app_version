// ignore_for_file: prefer_const_constructors
import 'package:app_version/app_version.dart';
import 'package:app_version/src/repository/app_version_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class AndroidMock extends Mock implements AndroidRepository {

  AndroidMock({required this.currentVersion, required this.appName}) : super();

  @override
  final String currentVersion;
  @override
  final String appName;
}

void main() {
  group('Android', () {
    final androidMockHigher = AndroidRepository(currentVersion: '1.0.0',appName: 'com.osmo.smt');
    final androidMockLess = AndroidRepository(currentVersion: '99.0.0',appName: 'com.osmo.smt');
    test('can be instantiated', () {
      expect(androidMockHigher, isNotNull);
    });
    group('AndroidAppVersionResult', ()  {
      test('can get AppVersionResult Instance', () async {
        final appVersionResult = await androidMockHigher.checkUpdate();
        expect(
            appVersionResult, isNotNull,
            skip: appVersionResult.newVersion == null,
        );
      });
      group('Store Version is Higher,', () {
        test('can get New Version', () async {
          final appVersionResult = await androidMockHigher.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isNotNull,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('Can update', () async {
          final appVersionResult = await androidMockHigher.checkUpdate();
          expect(
            appVersionResult.canUpdate,
            isTrue,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('New Version is a String', () async {
          final appVersionResult = await androidMockHigher.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
        test('URL is a String', () async {
          final appVersionResult = await androidMockHigher.checkUpdate();
          expect(
            appVersionResult.url,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
      });
      group('Store Version is Equal or less,', () {
        test('can get New Version', () async {
          final appVersionResult = await androidMockLess.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isNotNull,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('Can not update', () async {
          final appVersionResult = await androidMockLess.checkUpdate();
          expect(
            appVersionResult.canUpdate,
            isFalse,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('New Version is a String', () async {
          final appVersionResult = await androidMockLess.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
        test('URL is a String', () async {
          final appVersionResult = await androidMockLess.checkUpdate();
          expect(
            appVersionResult.url,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
      });
    });
  });

  group('IOS', () {
    final iOSMockHigher = IOSRepository(currentVersion: '1.0.0',appName: 'com.osmowallet.app');
    final iOSMockLess = IOSRepository(currentVersion: '99.0.0',appName: 'com.osmowallet.app');
    test('can be instantiated', () {
      expect(iOSMockHigher, isNotNull);
    });
    group('iOSAppVersionResult', ()  {
      test('can get AppVersionResult Instance', () async {
        final appVersionResult = await iOSMockHigher.checkUpdate();
        expect(appVersionResult, isNotNull);
      });
      group('Store Version is Higher,', () {
        test('can get New Version', () async {
          final appVersionResult = await iOSMockHigher.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isNotNull,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('Can update', () async {
          final appVersionResult = await iOSMockHigher.checkUpdate();
          expect(
            appVersionResult.canUpdate,
            isTrue,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('New Version is a String', () async {
          final appVersionResult = await iOSMockHigher.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
        test('URL is a String', () async {
          final appVersionResult = await iOSMockHigher.checkUpdate();
          expect(
            appVersionResult.url,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
      });
      group('Store Version is Equal or less,', () {
        test('can get New Version', () async {
          final appVersionResult = await iOSMockLess.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isNotNull,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('Can not update', () async {
          final appVersionResult = await iOSMockLess.checkUpdate();
          expect(
            appVersionResult.canUpdate,
            isFalse,
            skip: appVersionResult.newVersion == null,
          );
        });
        test('New Version is a String', () async {
          final appVersionResult = await iOSMockLess.checkUpdate();
          expect(
            appVersionResult.newVersion,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
        test('URL is a String', () async {
          final appVersionResult = await iOSMockLess.checkUpdate();
          expect(
            appVersionResult.url,
            isA<String>(),
            skip: appVersionResult.newVersion == null,
          );
        });
      });
    });
  });
}
