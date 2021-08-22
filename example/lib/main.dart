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
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    CellRebelSDK.init("CLIENT_KEY");
    String sdkVersion;
    try {
      sdkVersion = await CellRebelSDK.getVersion ?? 'Unknown platform version';
    } on PlatformException {
      sdkVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _version = sdkVersion;
    });
  }

  void clearUserData() async {
    bool success = await CellRebelSDK.clearUserData();
    if (success) {
      setState(() {
        _isEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CellRebelSDK'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Version: $_version\n'),
              ElevatedButton(
                child: Text('Start tracking'),
                onPressed: _isEnabled ? CellRebelSDK.startTracking : null,
              ),
              ElevatedButton(
                child: Text('Stop tracking'),
                onPressed: _isEnabled ? CellRebelSDK.stopTracking : null,
              ),
              ElevatedButton(
                child: Text('Clear user data'),
                onPressed: _isEnabled ? clearUserData : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
