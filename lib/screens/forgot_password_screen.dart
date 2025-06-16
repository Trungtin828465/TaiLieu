import 'package:cuoiky/services/forgot_pass_controller.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _controller = ForgotPasswordController();
  bool _isLoading = false;

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
                    color: Color(0xFF4A5FC4).withOpacity(0.7),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Color(0xFF4A5FC4).withOpacity(0.3),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            'Quên mật khẩu?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Đừng lo lắng, chúng tôi sẽ giúp bạn',
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
                    padding: EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border(
                                left: BorderSide(color: Colors.blue, width: 4),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hướng dẫn',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Nhập địa chỉ email để nhận mật khẩu mới. Kiểm tra email, kể cả hộp thư rác.',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
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
                                hintText: 'Địa chỉ email',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed:
                                  _isLoading
                                      ? null
                                      : () => _controller.sendResetEmail(
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
                                          Icon(Icons.send, color: Colors.white),
                                          SizedBox(width: 10),
                                          Text(
                                            'Gửi mật khẩu mới',
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
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.arrow_back, color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text(
                                    'Quay lại đăng nhập',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Vẫn gặp vấn đề?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                ' Liên hệ hỗ trợ',
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
