import 'dart:io';

import 'package:app_version/src/models/check_version_result.dart';
import 'package:app_version/src/repository/app_version_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

///
class AppVersion {
  /// We can inject the forceVersion in the constructor
  AppVersion({this.forceCurrentVersion});

  /// Is the version for test,
  /// you can added this with a version than you currently have,
  ///
  String? forceCurrentVersion;


  /// Check version of app
  Future<AppVersionResult> checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = forceCurrentVersion ?? packageInfo.version;
    final id =  packageInfo.packageName;
    AppVersionRepository appVersionRepository;
    if (Platform.isAndroid) {
      appVersionRepository = AndroidRepository(
          appName: id,
          currentVersion: currentVersion,
      );
    } else {
      appVersionRepository = IOSRepository(
        appName: id,
        currentVersion: currentVersion,
      );
    }
    return appVersionRepository.checkUpdate();
  }
}



