import 'package:app_version/src/app_version.dart';
import 'package:flutter/material.dart';

class AppVersionExample extends StatefulWidget {
  const AppVersionExample({Key? key}) : super(key: key);

  @override
  State<AppVersionExample> createState() => _AppVersionExampleState();
}

class _AppVersionExampleState extends State<AppVersionExample> {

  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  Future<void> _checkVersion() async {
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
                children: [
                  const Text('The is a new version for this app'),
                  Text('New Version: ${result.newVersion}'),
                  Text('Url to redirect: ${result.url}')
                ],
              ),
            );
          },);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('My App'),
      ),
    );
  }
}
