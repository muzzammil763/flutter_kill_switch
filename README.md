# Flutter Kill Switch

A Flutter package that provides a kill switch functionality to remotely disable apps using Firebase Firestore.

## Features

- 🛡️ Remote app disable/enable functionality
- 🔥 Firebase Firestore integration
- 🎨 Beautiful UI matching iOS design patterns
- 🔒 Secure confirmation dialog with custom keyboard
- 📱 Cross-platform support

## Prerequisites

**IMPORTANT**: Before using this package, ensure you have:

1. **Firebase Project Setup**: Create a Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/)
2. **Firebase SDK**: Add Firebase to your Flutter app following the [official documentation](https://firebase.flutter.dev/docs/overview)
3. **Firestore Database**: Enable Firestore Database in your Firebase console
4. **Platform Configuration**: Configure Firebase for both iOS and Android platforms

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_kill_switch: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### 1. Import the package

```dart
import 'package:flutter_kill_switch/flutter_kill_switch.dart';
```

### 2. Navigate to Kill Switch Screen

Replace your navigation with the `FlutterKillSwitch` widget:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const FlutterKillSwitch(),
  ),
);
```

### 3. Initialize Kill Switch Listener (Optional)

To automatically show the kill switch dialog when the app is disabled, add this to your main app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_kill_switch/flutter_kill_switch.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      builder: (context, child) {
        // Initialize kill switch listener
        KillSwitchService.initializeKillSwitchListener(context);
        return child!;
      },
    );
  }
}
```

## How It Works

1. **Kill Switch Screen**: Users can access a beautifully designed kill switch screen
2. **Confirmation Dialog**: When enabling the kill switch, users must type "IWANNAENABLE" using a custom keyboard
3. **Firestore Integration**: The kill switch state is stored in Firestore at:
   - Collection: `IAmNothing/NothingInsideMe/WhyAreYouFollowingThisCollection`
   - Document: `FlutterKillSwitch`
   - Field: `enabled` (boolean)
4. **App Blocking**: When enabled, the app shows an undismissible dialog forcing users to close the app

## Firestore Structure

The package automatically creates the following Firestore document structure:

```
IAmNothing/
└── NothingInsideMe/
    └── WhyAreYouFollowingThisCollection/
        └── FlutterKillSwitch
            └── enabled: boolean
```

## Customization

### Kill Switch Service Methods

```dart
// Update kill switch state
await KillSwitchService.updateKillSwitchState(true);

// Get current kill switch state
bool isEnabled = await KillSwitchService.getKillSwitchState();

// Initialize listener for automatic dialog display
KillSwitchService.initializeKillSwitchListener(context);
```

## Security Features

- **Confirmation Required**: Enabling requires typing a specific phrase
- **Custom Keyboard**: Uses a custom keyboard to prevent automation
- **Undismissible Dialog**: When activated, users cannot dismiss the blocking dialog
- **System Exit**: Forces app closure when kill switch is active

## Firebase Setup Guide

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing one
3. Add your Flutter app to the project
4. Download and add configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
5. Enable Firestore Database in the Firebase console
6. Set up Firestore security rules as needed

## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_kill_switch/flutter_kill_switch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      builder: (context, child) {
        KillSwitchService.initializeKillSwitchListener(context);
        return child!;
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FlutterKillSwitch(),
              ),
            );
          },
          child: Text('Open Kill Switch'),
        ),
      ),
    );
  }
}
```

## Requirements

- Flutter SDK: >=2.0.0
- Dart SDK: >=2.17.0 <4.0.0
- Firebase project with Firestore enabled

## License

This project is licensed under the MIT License.

## Support

For issues and feature requests, please visit our [GitHub repository](https://github.com/your-username/flutter_kill_switch).