import 'package:cuoiky/services/register_controller.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controller = RegisterController();
  bool _isLoading = false;
  bool _agreeTerms = false;
  String _gender = 'Nam';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _passwordStrength = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              // Header section with background and additional overlay
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                    color: Color(
                      0xFF4A5FC4,
                    ).withOpacity(0.7), // Existing solid blue overlay
                  ),
                  child: Stack(
                    alignment: Alignment.center, // Center the Stack's children
                    children: [
                      // New blue overlay
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Color(
                          0xFF4A5FC4,
                        ).withOpacity(0.3), // Additional blue overlay
                      ),
                      // Existing content (logo and text) centered
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Center horizontally
                        children: [
                          ClipOval(
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Tạo tài khoản mới',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Đăng ký để bắt đầu',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Form section
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          // Họ và tên
                          TextField(
                            controller: _controller.nameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              hintText: 'Họ và tên',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Email
                          TextField(
                            controller: _controller.emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email, color: Colors.grey),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Số điện thoại
                          TextField(
                            controller: _controller.phoneController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone, color: Colors.grey),
                              hintText: 'Số điện thoại',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Ngày sinh
                          TextField(
                            controller: _controller.dobController,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.cake, color: Colors.grey),
                              hintText: 'mm/dd/yyyy',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                                onPressed:
                                    () => _controller.selectDate(context),
                              ),
                            ),
                            onTap: () => _controller.selectDate(context),
                          ),
                          SizedBox(height: 15),
                          // Chọn giới tính
                          DropdownButtonFormField<String>(
                            value: _gender, // Thêm giá trị ban đầu
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.wc, color: Colors.grey),
                              hintText: 'Chọn giới tính',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                            ),
                            items:
                                ['Nam', 'Nữ', 'Khác'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _gender = newValue!;
                              });
                            },
                          ),
                          SizedBox(height: 15),
                          // Mật khẩu
                          TextField(
                            controller: _controller.passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),
                              hintText: 'Mật khẩu',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _passwordStrength = _controller
                                    .checkPasswordStrength(value);
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          // Password strength indicator
                          LinearProgressIndicator(
                            value: _controller.getPasswordStrengthValue(),
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _controller.getPasswordStrengthColor(),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Độ mạnh mật khẩu: $_passwordStrength',
                            style: TextStyle(
                              fontSize: 12,
                              color: _controller.getPasswordStrengthColor(),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Xác nhận mật khẩu
                          TextField(
                            controller: _controller.confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),
                              hintText: 'Xác nhận mật khẩu',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Terms agreement with checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _agreeTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreeTerms = value ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Tôi đã đọc và đồng ý với điều khoản sử dụng và chính sách bảo mật',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Đăng ký button
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                                  _isLoading
                                      ? null
                                      : () => _controller.register(
                                        context: context,
                                        agreeTerms: _agreeTerms,
                                        gender: _gender ?? 'Nam',
                                        setLoading:
                                            (val) => setState(
                                              () => _isLoading = val,
                                            ),
                                        onSuccess: () => Navigator.pop(context),
                                      ),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:
                                  _isLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Đăng ký tài khoản',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Horizontal line with "hoặc"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'hoặc',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          // Đã có tài khoản
                          Center(
                            child: Text(
                              'Đã có tài khoản?',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Đăng nhập ngay button
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.blue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.login, color: Colors.blue),
                                  SizedBox(width: 10),
                                  Text(
                                    'Đăng nhập ngay',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
