import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:system_theme/system_theme.dart';

import 'package:team_dart_knights_sih/models/ModelProvider.dart';
import 'package:team_dart_knights_sih/languages/localeString.dart';

import 'package:window_manager/window_manager.dart';
import 'amplifyconfiguration.dart';
import 'injection_container.dart' as di;
import 'package:get/get.dart';
import 'features/Auth/UI/pages/login_screen.dart';

const String appTitle = 'Fluent UI Showcase for Flutter';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}


Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);

    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(api);

    final storage = AmplifyStorageS3();
    await Amplify.addPlugin(storage);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    print('An error occurred configuring Amplify: $e');
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.setup();
  // if it's on the web, windows or android, load the accent color
  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    // await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: true,
      );

      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  } else {
    await _configureAmplify();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (ctx, child) => GetMaterialApp(
        translations: LocalString(),
        locale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
      designSize: isDesktop ? const Size(1366, 768) : const Size(375, 812),
    );
  }
}

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 100,
            ),
            Text('Logged In'),
          ],
        ),
      ),
    );
  }
}
