# App Version

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A Very Good Project created by Very Good CLI.

## Installation 💻

**❗ In order to start using App Version you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Add `app_version` to your `pubspec.yaml`:

```yaml
dependencies:
  app_version:
    git: 'https://github.com/amilkarSingular/app_version.git'
```

Install it:

```sh
flutter packages get
```

---

## Usage 🤖

Para usarlo simplemente cree una instancia de AppVersion, y llame a .checkUpdate(),

La clase tiene un parametro opcional en su constructor llamado forceCurrentVersion, este le servira solo para testear y crear su custom modal a la hora que encuentre una nueva version.

La variable result es una instancia (AppVersionResult) que trae un bool diciendo si se puede actualizar (canUpdate),
Tambien trae la nueva version del app encontrada (newVersion), y la url para redirigir a la tienda (url).
```dart
Future<void> _checkVersion() async {
  
  //final appVersion = AppVersion(forceCurrentVersion: '1.0.0'); Opcional para test
  
  final appVersion = AppVersion();
  final result = await appVersion.checkVersion();

  if(result.canUpdate){
    if(context.mounted){
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('App Version'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('There is a new version for this app'),
                Text('New Version: ${result.newVersion}'),
                Text('Url to redirect: ${result.url}')
              ],
            ),
          );
        },);
    }
  }
}

```

---
