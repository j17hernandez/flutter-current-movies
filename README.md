
# Screen capture

![1](https://github.com/j17hernandez/flutter-current-movies/assets/57992471/8038e73b-541e-4e56-909a-a37ab1a71436)
![2](https://github.com/j17hernandez/flutter-current-movies/assets/57992471/c21c6e6e-7c57-4204-8393-e3c243ee677a)




# Movies

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

You need to install [Android Studio] (https://developer.android.com/studio?hl=es-419)
For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Change icon app

in console run the code ## flutter pub run flutter_launcher_icons:main


# Clear Dependencies and Gradle
```bash
cd android && ./gradlew clean
fvm flutter clean
```

# Install all packages
```bash
fvm flutter pub get
```

# Compiler apk
```bash
fvm flutter build apk --release --target-platform android-arm64 --no-tree-shake-icons
```
