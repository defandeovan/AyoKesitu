// import 'dart:convert'; // For jsonEncode
// import 'package:firebase_messaging/firebase_messaging.dart'; // For Firebase Cloud Messaging
// import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // For local notifications
// import 'package:flutter/material.dart'; // For using basic Flutter widgets and functions

// class FirebaseMessagingHandler {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   // Initialize notification channel for Android
//   final _androidChannel = const AndroidNotificationChannel(
//     'channel_notification',
//     'High Importance Notification',
//     description: 'Used For Notification',
//     importance: Importance.defaultImportance,
//   );

//   // Initialize local notification plugin
//   final _localNotification = FlutterLocalNotificationsPlugin();

//   Future<void> initPushNotification() async {
//     // Request notification permissions from the user
//     await _firebaseMessaging.requestPermission();

//     // Get FCM token
//     String? token = await _firebaseMessaging.getToken();
//     print('FCM Token: $token');

//     // Handler for messages received when the app is in the foreground
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;

//       // Display local notification
//       _localNotification.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             icon: '@drawable/ic_launcher',
//           ),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );

//       print('Message received in foreground: ${notification.title}');
//     });

//     // Handler for when the user opens a notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message opened from notification: ${message.notification?.title}');
//     });
//   }

//   Future<void> initLocalNotification() async {
//     const ios = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: ios);
//     await _localNotification.initialize(settings);
//   }
// }
