# flutter_cellrebel_sdk

Flutter wrapper for CellRebelSDK


## Usage

In your application entry point import CellRebelSDK module and run `init` method using your unique CLIENT_KEY string:
```dart
import 'package:flutter_cellrebel_sdk/flutter_cellrebel_sdk.dart';

// ...

CellRebelSDK.init(CLIENT_KEY);
```

Use `startTracking` to start measurement. On the first launch it's best to call this method after user response on location permission dialog. During the next sessions this method should be called when application finished launching:
```dart
CellRebelSDK.startTracking
```

In some (rare) cases, if very high load tasks need to be performed, `stopTracking` can be used to abort an ongoing measurement sequence:
```dart
CellRebelSDK.stopTracking
```

Call `getVersion` to retrieve current version of CellRebelSDK:
```dart
 sdkVersion = await CellRebelSDK.getVersion 
```

Use `clearUserData` if you need to request the removal of user data collected (based on GDPR 'right to be forgotten'):
```dart
CellRebelSDK.clearUserData
```
Calling `clearUserData` will deinitialize CellRebelSDK and remove all local data. `init` method should be called before using CellRebelSDK again.

## Demo project
https://github.com/cellrebel/flutter_cellrebel_sdk/blob/main/example/lib/main.dart