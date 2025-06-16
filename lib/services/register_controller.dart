import 'package:cuoiky/database_helpers/UserDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterController {
  // TextEditingControllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agreeTerms = false;
  String gender = 'Nam';
  String passwordStrength = 'Trống';
  bool isLoading = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  String checkPasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength = 'Trống';
      return 'Trống';
    }
    if (password.length < 6) {
      passwordStrength = 'Yếu';
      return 'Yếu';
    }
    if (password.length < 8) {
      passwordStrength = 'Trung bình';
      return 'Trung bình';
    }
    if (RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password)) {
      passwordStrength = 'Mạnh';
      return 'Mạnh';
    }
    passwordStrength = 'Trung bình';
    return 'Trung bình';
  }

  double getPasswordStrengthValue() {
    switch (passwordStrength) {
      case 'Yếu':
        return 0.25;
      case 'Trung bình':
        return 0.5;
      case 'Mạnh':
        return 1.0;
      default:
        return 0.0;
    }
  }

  Color getPasswordStrengthColor() {
    switch (passwordStrength) {
      case 'Yếu':
        return Colors.redAccent; // Màu đỏ sáng hơn
      case 'Trung bình':
        return Colors.orangeAccent; // Màu cam sáng hơn
      case 'Mạnh':
        return Colors.greenAccent; // Màu xanh sáng hơn
      default:
        return Colors.grey[600]!; // Màu xám đậm hơn
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidDateFormat(String date) {
    return RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(date);
  }

  Future<void> register({
    required BuildContext context,
    required VoidCallback onSuccess,
    required Function(bool) setLoading,
    required bool agreeTerms,
    required String gender,
  }) async {
    // Kiểm tra các trường bắt buộc
    String? errorMessage;
    if (nameController.text.trim().isEmpty) {
      errorMessage = 'Vui lòng nhập họ và tên';
    } else if (emailController.text.trim().isEmpty) {
      errorMessage = 'Vui lòng nhập email';
    } else if (phoneController.text.trim().isEmpty) {
      errorMessage = 'Vui lòng nhập số điện thoại';
    } else if (dobController.text.trim().isEmpty) {
      errorMessage = 'Vui lòng chọn ngày sinh';
    } else if (!isValidDateFormat(dobController.text)) {
      errorMessage = 'Ngày sinh phải có định dạng MM/dd/yyyy';
    } else if (passwordController.text.trim().isEmpty) {
      errorMessage = 'Vui lòng nhập mật khẩu';
    } else if (confirmPasswordController.text.trim().isEmpty) {
      errorMessage = 'Vui lòng nhập xác nhận mật khẩu';
    }

    if (errorMessage != null) {
      _showSnackBar(context, errorMessage);
      return;
    }

    // Kiểm tra email hợp lệ
    if (!isValidEmail(emailController.text)) {
      _showSnackBar(context, 'Email không hợp lệ');
      return;
    }

    // Kiểm tra độ dài mật khẩu
    if (passwordController.text.length < 6) {
      _showSnackBar(context, 'Mật khẩu phải có ít nhất 6 ký tự');
      return;
    }

    // Kiểm tra mật khẩu xác nhận
    if (passwordController.text != confirmPasswordController.text) {
      _showSnackBar(context, 'Mật khẩu xác nhận không khớp');
      return;
    }

    // Kiểm tra đồng ý điều khoản
    if (!agreeTerms) {
      _showSnackBar(context, 'Vui lòng đồng ý với điều khoản sử dụng');
      return;
    }

    setLoading(true);

    try {
      final registerSuccess = await UserDatabaseHelper.instance.registerUser(
        emailController.text,
        passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
        dob: dobController.text,
        gender: gender,
      );

      if (registerSuccess) {
        _showSnackBar(context, 'Đăng ký thành công!');
        onSuccess();
      } else {
        _showSnackBar(context, 'Email đã tồn tại');
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
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}