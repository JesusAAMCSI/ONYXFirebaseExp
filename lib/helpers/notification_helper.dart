import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Este canal es usado para notificaciones importantes',
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
    playSound: true,
  );

  Future<void> initNotifications(BuildContext context) async {
    log('Entra en init Notifications');
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await _messaging.getToken();
    log(token ?? ' No token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('onMessage');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        _localNotifications.show(
          message.notification.hashCode,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('onMessageOpenedApp');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        // _navigateScreen(context, message);
      }
    });

    FirebaseMessaging.onBackgroundMessage(
        (message) => _onBackgroundmessage(message, context));

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log('getInitialMessage');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
      }
    });
  }

  Future<void> _onBackgroundmessage(
      RemoteMessage message, BuildContext context) async {
    log('_onBackgroundmessage');
    log('Message data: ${message.data}');

    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
    }
  }
}
