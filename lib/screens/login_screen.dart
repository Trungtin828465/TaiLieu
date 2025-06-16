import 'package:cuoiky/services/login_controller.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginController();
  bool _isLoading = false;
  bool _obscurePassword = true;

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
                    children: [
                      // New blue overlay
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Color(0xFF4A5FC4).withOpacity(0.3),
                      ),
                      // Existing content (logo and text)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Chào mừng trở lại',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Đăng nhập vào tài khoản của bạn',
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          // Email field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _controller.emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                hintText: 'Email',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Password field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _controller.passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
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
                                hintText: 'Mật khẩu',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Login button
                          Container(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed:
                                  _isLoading
                                      ? null
                                      : () => _controller.login(
                                        context: context,
                                        setLoading:
                                            (val) => setState(
                                              () => _isLoading = val,
                                            ),
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
                                            Icons.login,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Đăng nhập',
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
                          SizedBox(height: 15),
                          // Forgot password
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
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
                          SizedBox(height: 15),
                          Text(
                            'Chưa có tài khoản?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          // Register button
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
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
                                  Icon(Icons.person_add, color: Colors.blue),
                                  SizedBox(width: 10),
                                  Text(
                                    'Đăng ký ngay',
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
