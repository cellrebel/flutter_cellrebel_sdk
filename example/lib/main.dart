import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cellrebel_sdk/flutter_cellrebel_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _version = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    CellRebelSDK.init("CLIENT_KEY");
  }
  Future<void> initPlatformState() async {
    String sdkVersion;
    try {
      sdkVersion =
          await CellRebelSDK.getVersion ?? 'Unknown platform version';
    } on PlatformException {
      sdkVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _version = sdkVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Version: $_version\n'),
            ElevatedButton(
              child: Text('Start tracking'),
              onPressed: CellRebelSDK.startTracking,
            ),
            ElevatedButton(
              child: Text('Stop tracking'),
              onPressed: CellRebelSDK.stopTracking,
            )
          ],
        ),
      ),
        ),
    );
  }
}
