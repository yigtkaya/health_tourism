import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:health_tourism/product/repoImpl/user_%20repo_impl.dart';
import '../models/clinic.dart';
import '../repositories/notification_repo.dart';

class NotificationRepoImpl extends NotificationRepository {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final dio = Dio();
  final userRepository = UserRepositoryImpl();
  final serverToken =
      'AAAAqM27bpA:APA91bGL0G_n0cXSqoyphsoryU12tUT4H_Xg5eiXGw5E37uejd2KeRwzZuoP857pgR3_ZjMulpxAjx2wxTeC0OCSB76z9S9jF3vk2LqR3Exce5ywHk_SuMhBuz3reMLFfyG20rQFMvkU';
  @override
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final FCMToken = await _firebaseMessaging.getToken();

    final map = {"fcmToken": FCMToken};

    userRepository.updateUser(map);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilist in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Future<void> sendPushNotificationToClinic(
      String name, String message, String cid) async {
    try {
      final body = {
        "to":
            "ctUk8VbWQwWfkedSv-tUDs:APA91bE40KspxEqCeia4FzLwYkhr323rLlZKpmfR1lD-THPbFRJBtAHd4osldTNTNdJGw1e57aSbF6pbAe_HO0pcht_8x6imwLABY9aHpMWHFPan9EttGOzXdBeCBHoCrE78Hz3e_-IC",
        "notification": {
          "title": name,
          "body": message,
          "android_channel_id": "chats"
        },
        "data" : {
          "some_data": "Clinic ID: $cid",
        }
      };

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $serverToken';

      await dio.post(
        "https://fcm.googleapis.com/fcm/send",
        data: jsonEncode(body),
      );
    } catch (e) {
      print('\nsendNPushNotificationE: $e');
    }
  }
}
