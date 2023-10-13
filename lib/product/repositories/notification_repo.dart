
abstract class NotificationRepository {
  Future<void> initNotifications() async {}

  Future<void> sendPushNotificationToClinic(
      String name, String message, String cid) async {}
}
//
