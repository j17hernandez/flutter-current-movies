
# Screen capture
![1](https://github.com/j17hernandez/flutter-current-movies/assets/57992471/d7e98423-9be5-4c8e-881c-467b49a32ba2)
![3](https://github.com/j17hernandez/flutter-current-movies/assets/57992471/52508a16-1be0-49e2-a77d-7383b0edd431)
![4](https://github.com/j17hernandez/flutter-current-movies/assets/57992471/0959fdb9-db3e-468d-915c-0f4d3b07460f)
![2](https://github.com/j17hernandez/flutter-current-movies/assets/57992471/2e4235b2-203b-4eca-a8f1-6e08ca6e8ced)





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
