import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_app/service/notification_service.dart';

class FcmService {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    //request permission
    NotificationSettings nsetting = await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    print('Izin notifikasi FCM ${nsetting.authorizationStatus}');

    //get token perangkat
    String? token = await fcm.getToken();
    print('Token user adalah : $token');

    //foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage rm) {
      print(
        'Pesan diterima ${rm.notification?.title} ${rm.notification?.body}',  
      );
      showFCMNotif(rm);
    });

    //terminated state
    fcm.getInitialMessage().then((RemoteMessage? rm) {
      if (rm != null) {
        print(
          'Pesan diterima ${rm.notification?.title} ${rm.notification?.body}',
        );
      }
    });

    //setup background handler
    FirebaseMessaging.onBackgroundMessage(fcmHandlerBGMessage);
  }

    //show Notification
    void showFCMNotif(RemoteMessage rm) async {
      RemoteNotification? rn = rm.notification;
      NotificationService ns = NotificationService();

      if (rn != null) {
        ns.showNotification(
          id: rm.hashCode,
          title: rn.title ?? 'N/A',
          desc: rn.body ?? 'N/A',
        );
      }
    }
}

@pragma('vm:entry-point')
Future<void> fcmHandlerBGMessage(RemoteMessage rm) async {
  print('Pesan diterima ${rm.notification?.title} ${rm.notification?.body}');
}
