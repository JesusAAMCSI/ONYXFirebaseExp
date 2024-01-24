import 'package:flutter/material.dart';
// import 'package:onyx_firebase/core/utils.dart';
// import 'package:onyx_firebase/firebase_options.dart';
// import 'package:onyx_firebase/helpers/notification_helper.dart';11
import 'package:onyx_firebase/presentation/fingerprint_screen.dart';
import 'package:onyx_firebase/presentation/settings_screen.dart';
import 'package:onyx_plugin/onyx.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BuildContext appContext;

  @override
  void initState() {
    super.initState();

    OnyxCamera.state.addListener(() {
      if (OnyxCamera.state.isError) {
        var snackBar = SnackBar(
          content: Text(OnyxCamera.state.resultMessage),
        );
        ScaffoldMessenger.of(appContext).showSnackBar(snackBar);
      }
      if (OnyxCamera.state.status == OnyxStatuses.success) {
        Navigator.of(appContext)
            .push(MaterialPageRoute(builder: (context) => FingerprintScreen()));
      }
    });
    // _notifications();
  }

  // _notifications() {
  //   Future.delayed(Duration.zero, () async {
  //     NotificationHelper().initNotifications(context);
  //     await initLocalNotifications(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Onyx Flutter Demo',
        home: Builder(builder: (context) {
          appContext = context;
          if (OnyxCamera.state.status == OnyxStatuses.success) {
            return FingerprintScreen();
          } else {
            return SettingsScreen();
          }
        }));
  }
}
