import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class GetNotification {
  String? message;
  String? notificationType;

  GetNotification({this.message, this.notificationType});

  factory GetNotification.fromJson(Map<String, dynamic> parsedJson) {
    return GetNotification(
      message: parsedJson['message'] ?? "",
      notificationType: parsedJson['notificationType'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": this.message,
      "notificationType": this.notificationType,
    };
  }
}

class NotificationObject {
  static GetNotification notificationInfo = GetNotification();
  static String? strBody;
}

Future<void> showNotification(String deviceToken, String notificationMessage,
    String notificationType) async {
  await FirebaseMessaging.instance
      .getToken()
      .then((value) => print("tokan $value"));
  var serverKey =
      "AAAA3DtX-mw:APA91bGUBYCTnmbtmBo2X_4RUk2oZr1SvTgEQtY_JCRkjk0tSSKIsMTqtvMsVa4ojGfujqHi1lHIQyRKM3FlcvkSfRATdZNJwpKGiEeC8_fsw-ZXj3_GnlkpdJPMCCXqXv6u3JG3gYjv";
  try {
    GetNotification _body = GetNotification();
    _body.message = notificationMessage;
    _body.notificationType = notificationType;

    NotificationObject.strBody = jsonEncode(_body);
    var strGetNotificationInfo = NotificationObject.strBody;
    Map<String, dynamic> json = jsonDecode(strGetNotificationInfo!);
    NotificationObject.notificationInfo = GetNotification.fromJson(json);

    dynamic response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$serverKey',
        'project_id': 'nearme-71279',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': NotificationObject.notificationInfo.message,
            'title': 'NearMe',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK $notificationType',
            'id': '1',
            'status': 'done'
          },
          'to': deviceToken
        },
      ),
    );
    print(response.data.toString());
  } catch (e) {
    print("error push notification");
    print(e.toString());
  }
}
