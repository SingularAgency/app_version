

/// App Version Result Model class
class AppVersionResult{
  /// Constructor of this
  AppVersionResult({
    required this.canUpdate,
    required this.url,
    required this.newVersion,
  });

  /// Value if exists to a new version of app
  bool canUpdate = false;

  /// If ***canUpdate*** is true, ***newVersion*** will have a value regarding
  /// the new version number
  String? newVersion;

  /// The url to go to update the APP, whether Playstore or Appstore
  String? url;
}
