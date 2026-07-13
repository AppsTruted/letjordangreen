// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// class LocalNotificationHandler{
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   static Future<bool?> init() async {
//
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       log('User granted permission');
//       await  getToken();
//     } else {
//       log('User declined or has not accepted permission');
//     }
//   }
//
//   static Future initializeSettings() async {
//
//     DarwinInitializationSettings iosNotificationDetails = const DarwinInitializationSettings();
//     var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
//     var iOSInitialize =  iosNotificationDetails;
//     var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//     await flutterLocalNotificationsPlugin.initialize(settings: initializationsSettings );
//   }
//
//   static Future showBigTextNotification({dynamic id =0,required String title, required String body, var payload, required FlutterLocalNotificationsPlugin fln
//   } ) async {
//     DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails( sound: 'notification.caf');
//     AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails("hello", "high_importance_channel",
//         playSound: true,
//         //  sound: RawResourceAndroidNotificationSound('notification'),
//         importance: Importance.max,
//         // styleInformation: BigPictureStyleInformation(
//         //   FilePathAndroidBitmap(payload),
//         //   contentTitle: 'Title',
//         //   summaryText: 'Summary',
//         // ),
//         // icon: ".png",
//         priority: Priority.high
//     );
//
//     var not= NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
//     await fln.show(id: 0,title:  title,body:  body,notificationDetails: not );
//   }
//
//   static Future<String> getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//
//     if(token != null) {
//       print("token $token");
//       return token;
//     }
//     else {
//       return "";
//     }
//
//   }
//
//   static initNotification(){
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       LocalNotificationHandler.showBigTextNotification(title: event.notification!.title!, body: event.notification!.body!, fln: flutterLocalNotificationsPlugin);
//
//       log("message received");
//       log(event.notification!.body.toString());
//
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       log('Message clicked!');
//       LocalNotificationHandler.showBigTextNotification(title: message.notification!.title!, body: message.notification!.body!, fln: flutterLocalNotificationsPlugin);
//
//     });
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//
//   }
//
// }
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   LocalNotificationHandler.showBigTextNotification(title: message.notification!.title!, body: message.notification!.body!, fln: flutterLocalNotificationsPlugin);
//
//   log("Handling a background message: $message");
// }