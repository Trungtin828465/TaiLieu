import 'package:cuoiky/database_helpers/UserDatabaseHelper.dart';
import 'package:cuoiky/screens/home_screen.dart';
import 'package:flutter/material.dart';


class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login({
    required BuildContext context,
    required Function(bool) setLoading,
  }) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showSnackBar(context, 'Vui lòng nhập đầy đủ thông tin');
      return;
    }

    setLoading(true);

    try {
      bool loginSuccess = await UserDatabaseHelper.instance.loginUser(
        emailController.text,
        passwordController.text,
      );

      if (loginSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        _showSnackBar(context, 'Email hoặc mật khẩu không đúng');
      }
    } catch (e) {
      _showSnackBar(context, 'Đã xảy ra lỗi: $e');
    }

    setLoading(false);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
