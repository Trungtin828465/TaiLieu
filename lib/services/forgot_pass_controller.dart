import 'package:cuoiky/database_helpers/UserDatabaseHelper.dart';
import 'package:cuoiky/services/email_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController {
  final TextEditingController emailController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> sendResetEmail({
    required BuildContext context,
    required Function(bool) setLoading,
  }) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showSnackBar(context, 'Vui lòng nhập email');
      return;
    }

    if (!isValidEmail(email)) {
      _showSnackBar(context, 'Email không hợp lệ');
      return;
    }

    setLoading(true);

    try {
      final exists = await UserDatabaseHelper.instance.checkEmailExists(email);
      if (!exists) {
        _showSnackBar(context, 'Email không tồn tại trong hệ thống');
        setLoading(false);
        return;
      }

      final result = await EmailService.sendNewPasswordEmail(email);

      if (result != null && result['success']) {
        final updated = await UserDatabaseHelper.instance.updatePassword(
          email,
          result['newPassword'],
        );

        if (updated) {
          _showSuccessDialog(context);
        } else {
          _showSnackBar(context, 'Không thể cập nhật mật khẩu trong cơ sở dữ liệu.');
        }
      } else {
        _showSnackBar(context, 'Không thể gửi email. Vui lòng thử lại sau.');
      }
    } catch (e) {
      _showSnackBar(context, 'Đã xảy ra lỗi: $e');
    }

    setLoading(false);
  }

  void dispose() {
    emailController.dispose();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Thành công!'),
        content: Text('Mật khẩu mới đã được gửi tới email của bạn.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // đóng dialog
              Navigator.of(context).pop(); // quay về login
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
