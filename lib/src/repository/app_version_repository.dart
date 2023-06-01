

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:app_version/src/models/check_version_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// Repository
sealed class AppVersionRepository {
  
  /// Constructor
  AppVersionRepository({required this.currentVersion, required this.appName});

  /// AppName means AndroidId in Android and BundleId in iOS.
  String appName;

  /// The currentVersion of App
  String currentVersion;


  /// checkUpdate Method
  Future<AppVersionResult> checkUpdate();

  bool _shouldUpdate(String versionA, String versionB) {
    final versionNumbersA =
    versionA.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final versionNumbersB =
    versionB.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final versionASize = versionNumbersA.length;
    final versionBSize = versionNumbersB.length;
    final int maxSize = math.max(versionASize, versionBSize);

    for (var i = 0; i < maxSize; i++) {
      if ((i < versionASize ? versionNumbersA[i] : 0) >
          (i < versionBSize ? versionNumbersB[i] : 0)) {
        return false;
      } else if ((i < versionASize ? versionNumbersA[i] : 0) <
          (i < versionBSize ? versionNumbersB[i] : 0)) {
        return true;
      }
    }
    return false;
  }
}


/// Android Repository, it will check in Google Playstore
class AndroidRepository extends AppVersionRepository{
  ///
  AndroidRepository({
    required super.currentVersion,
    required super.appName,
  });

  @override
  Future<AppVersionResult> checkUpdate() async {
    String? newVersion = currentVersion;
    String? url;
    final uri = Uri.https('play.google.com', '/store/apps/details', {'id': appName});

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        debugPrint('Cant find an app in the Google Play Store with the id: $appName');
        return AppVersionResult(canUpdate: false, url: null,newVersion: null);
      } else {
        newVersion = RegExp(r',\[\[\["([0-9,\.]*)"]],').firstMatch(response.body)!.group(1);
        url = uri.toString();
      }
    } catch (e) {
      return AppVersionResult(canUpdate: false, url: null,newVersion: null);
    }
    if(_shouldUpdate(currentVersion, newVersion!)){
      return AppVersionResult(canUpdate: true, url: url,newVersion: newVersion);
    }
    return AppVersionResult(canUpdate: false, url: url,newVersion: newVersion);
  }
}



/// IOS Repository, it will check in AppStore
class IOSRepository extends AppVersionRepository{
  ///
  IOSRepository({required super.currentVersion, required super.appName});

  String _getCleanVersion(String version) => RegExp(r'\d+\.\d+\.\d+').stringMatch(version) ?? '0.0.0';

  @override
  Future<AppVersionResult> checkUpdate() async {
   try{
     var newVersion = currentVersion;
     final parameters = {'bundleId': appName};
     final uri = Uri.https('itunes.apple.com', '/lookup', parameters);
     final response = await http.get(uri);
     if (response.statusCode != 200) {
       debugPrint('Failed to query iOS App Store');
       return AppVersionResult(canUpdate: false, url: null,newVersion: null);
     }
     final jsonObj = jsonDecode(response.body);
     final results = jsonObj['results'] as List<dynamic>;
     if (results.isEmpty) {
       debugPrint("Can't find an app in the App Store with the id: $appName");
       return AppVersionResult(canUpdate: false, url: null,newVersion: null);
     }
     newVersion = _getCleanVersion(jsonObj['results'][0]['version'] as String);
     final url = jsonObj['results'][0]['trackViewUrl'] as String;
     if(_shouldUpdate(currentVersion, newVersion)){
       return AppVersionResult(canUpdate: true, url: url,newVersion: newVersion);
     }
     return AppVersionResult(canUpdate: false, url: url,newVersion: newVersion);
   }catch(error){
     rethrow;
   }
  }

}
