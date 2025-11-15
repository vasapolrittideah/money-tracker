import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/app.dart';
import 'package:money_tracker/src/app_module.dart';
import 'package:shared/shared.dart';

/// Entry point of the Flutter application.
Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final fontPath = './modules/ui/assets/fonts/ibm_plex_sans_thai';
    final license = await rootBundle.loadString('$fontPath/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>[fontPath], license);
  });

  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppModule.init();
    await _initializeServices();
    _configureErrorHandling();
    await _configureSystemUI();

    runApp(const App());
  }, (error, stackTrace) {});
}

/// Initializes essential services before the application launches.
Future<void> _initializeServices() async {
  try {
    await sl<AppConfig>().loadEnv();

    await sl<HiveManager>().init();
  } catch (error, stackTrace) {
    _reportError('Service initialization failed', error, stackTrace);
    rethrow;
  }
}

/// Configures global error handling for Flutter and platform errors.
void _configureErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    _reportError('Flutter error', details.exception, details.stack);

    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    _reportError('Platform error', error, stack);
    return true;
  };
}

/// Configures system UI elements such as status bar and navigation bar.
Future<void> _configureSystemUI() async {
  try {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    if (Platform.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  } catch (error, stackTrace) {
    _reportError('System UI configuration failed', error, stackTrace);
    // Don't rethrow because application can continue without these settings.
  }
}

/// Reports errors to an external service or logs them in debug mode.
void _reportError(String context, Object error, StackTrace? stackTrace) {
  if (kDebugMode) {
    debugPrint('$context: $error');
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  } else {
    // Integrate with external error reporting service here.
  }
}
