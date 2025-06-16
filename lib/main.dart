import 'package:cuoiky/database_helpers/UserDatabaseHelper.dart';
import 'package:cuoiky/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  // Đảm bảo các binding của Flutter được khởi tạo trước khi gọi các phương thức bất đồng bộ
  WidgetsFlutterBinding.ensureInitialized();

  // Xóa dữ liệu người dùng trong bảng users
  await UserDatabaseHelper.instance.deleteDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}