import 'dart:convert';
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
  }

  @override
  Future<void> sendPushNotificationToClinic(
      String name, String message, Clinic clinic) async {
    try {
      final body = {
        "to":
            "dDfXQgbURzaM8s1004O8sG:APA91bFiiKEogZLV74Vjom37I1EYItv7AR_t2lSLXN8Mq05GMclu6gC5NkqQZKfQRp4x2Ypnq_7GwcXlXoAChckbV-rSL7nvo7ZAfuc4_DoPColY_q54fNF6wg-5vVfrXKxAIqdKg8uI",
        "notification": {
          "title": name,
          "body": message,
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
