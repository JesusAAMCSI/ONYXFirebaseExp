// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:onyx_firebase/firebase_options.dart';


// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call initializeApp before using other Firebase services.
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   log("Handling a background message: ${message.messageId}");
// }

// @pragma('vm:entry-point')
// Future<void> initLocalNotifications(BuildContext context) async {
//   final localNotifications = FlutterLocalNotificationsPlugin();
//   const android = AndroidInitializationSettings('launcher_icon');
//   const ios = DarwinInitializationSettings();
//   const settings = InitializationSettings(
//     iOS: ios,
//     android: android,
//   );

//   const androidChannel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'Este canal es usado para notificaciones importantes',
//     importance: Importance.max,
//     enableLights: true,
//     enableVibration: true,
//     playSound: true,
//   );

//   await localNotifications.initialize(
//     settings,
//     onDidReceiveNotificationResponse: (details) {
//       // d.log('onDidReceiveNotificationResponse');
//       if (details.payload != null) {
//         try {
//           // d.log('payload es diferente a nulo');
//           final decoded = json.decode(details.payload!);
//           log(decoded.toString());
//           // final data = ResponseBasicCaptureModel.fromJson(decoded['data']);

//           // if (data.arguments.isEmpty) {
//           //   Navigator.pushNamed(context, data.route);
//           // } else {
//           //   Navigator.pushNamed(
//           //     context,
//           //     data.route,
//           //     arguments: ScreenArgumentEntity<String>(data.arguments),
//           //   );
//           // }
//         } catch (e) {
//           log(e.toString());
//         }
//       }
//     },
//   );
//   final platform = localNotifications.resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>();
//   await platform?.createNotificationChannel(androidChannel);
// }
