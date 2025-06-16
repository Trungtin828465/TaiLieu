import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

class EmailService {
  // Cấu hình SMTP
  // static const String _smtpHost = 'smtp.gmail.com';
  // static const int _smtpPort = 587;
  static const String _username = 'quangvinhdang7a1@gmail.com';
  static const String _password = 'mqiy fknr aorr mohq';
  static const String _fromName = 'Login App Support';

  // Gửi email chứa mật khẩu mới
  static Future<Map<String, dynamic>?> sendNewPasswordEmail(String toEmail) async {
    try {
      // Tạo mật khẩu mới ngẫu nhiên
      String newPassword = _generateNewPassword();

      // Cấu hình SMTP server
      final smtpServer = gmail(_username, _password);

      // Tạo email message
      final message = Message()
        ..from = Address(_username, _fromName)
        ..recipients.add(toEmail) // Gửi tới email người dùng nhập
        ..subject = 'Mật khẩu mới'
        ..text = 'Mật khẩu mới là: $newPassword'; // Nội dung email đơn giản

      // Gửi email
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');

      return {'success': true, 'newPassword': newPassword};
    } catch (e) {
      print('Error sending email: $e');
      return {'success': false};
    }
  }

  // Tạo mật khẩu mới ngẫu nhiên
  static String _generateNewPassword() {
    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(12, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}