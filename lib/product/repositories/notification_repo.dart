import '../models/clinic.dart';

abstract class NotificationRepository {
  Future<void> initNotifications() async {}

  Future<void> sendPushNotificationToClinic(
      String name, String message, Clinic clinic) async {}
}
//
