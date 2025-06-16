import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cuoiky/models/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class UserDatabaseHelper {
  // Singleton pattern
  static final UserDatabaseHelper instance = UserDatabaseHelper._internal();

  factory UserDatabaseHelper() => instance;

  static Database? _database;

  // Constructor
  UserDatabaseHelper._internal();

  // Getter cho database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // Nếu chưa có database, tạo một database mới
    _database = await _initDatabase();
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDatabase() async {
    // Lấy đường dẫn của thư mục cơ sở dữ liệu
    String path = join(await getDatabasesPath(), 'user_database.db');
    // Mở hoặc tạo mới database
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Tạo bảng User
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            email TEXT,
            phone TEXT,
            birthDate TEXT,
            gender TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  // Thêm người dùng vào cơ sở dữ liệu
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toJson());
  }

  // Lấy danh sách tất cả người dùng
  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        fullName: maps[i]['fullName'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        birthDate: DateTime.parse(maps[i]['birthDate']),
        gender: maps[i]['gender'],
        password: maps[i]['password'],
      );
    });
  }

  // Lấy người dùng theo ID
  Future<User?> getUserById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User(
        fullName: maps[0]['fullName'],
        email: maps[0]['email'],
        phone: maps[0]['phone'],
        birthDate: DateTime.parse(maps[0]['birthDate']),
        gender: maps[0]['gender'],
        password: maps[0]['password'],
      );
    }
    return null;
  }

  // Cập nhật thông tin người dùng
  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Xóa người dùng theo ID
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Đóng kết nối database
  Future<void> close() async {
    Database db = await database;
    db.close();
  }

  // Kiểm tra xem email đã tồn tại trong database chưa
  Future<bool> checkEmailExists(String email) async {
    try {
      Database db = await database;

      List<Map<String, dynamic>> user = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email.toLowerCase()],
      );

      return user.isNotEmpty;
    } catch (e) {
      print('Lỗi khi kiểm tra email: $e');
      return false;
    }
  }

  // Hàm băm mật khẩu bằng SHA256
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> updatePassword(String email, String newPassword) async {
    if (email.isEmpty || newPassword.isEmpty) {
      print('Email hoặc mật khẩu mới không được để trống.');
      return false;
    }

    try {
      final db = await database;

      int result = await db.update(
        'users', // hoặc dùng biến `usersTable` nếu bạn đã định nghĩa
        {
          'password': _hashPassword(newPassword), // dùng hash nếu đã có hàm
        },
        where: 'email = ?',
        whereArgs: [email.toLowerCase()],
      );

      return result > 0;
    } catch (e) {
      print('Lỗi khi cập nhật mật khẩu: $e');
      return false;
    }
  }

  Future<bool> registerUser(
    String email,
    String password, {
    String? name,
    String? phone,
    String? dob,
    String? gender,
  }) async {
    try {
      final db = await database;

      // Chuẩn hóa email
      final normalizedEmail = email.trim().toLowerCase();

      if (normalizedEmail.isEmpty || password.isEmpty) {
        print('Email và mật khẩu không được để trống.');
        return false;
      }

      // Kiểm tra email đã tồn tại
      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [normalizedEmail],
      );

      if (existingUser.isNotEmpty) {
        print('Email đã tồn tại.');
        return false;
      }

      // Thêm người dùng mới
      await db.insert('users', {
        'email': normalizedEmail,
        'password': _hashPassword(password),
        'fullName': name ?? '',
        'phone': phone ?? '',
        'birthDate': dob ?? '',
        'gender': gender ?? '',
      });

      return true;
    } catch (e) {
      print('Lỗi khi đăng ký người dùng: $e');
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final db = await database;

      final normalizedEmail = email.trim().toLowerCase();
      final hashedPassword = _hashPassword(password);

      if (normalizedEmail.isEmpty || password.isEmpty) {
        print('Email hoặc mật khẩu không được để trống.');
        return false;
      }

      final result = await db.query(
        'users', // hoặc dùng biến usersTable nếu đã khai báo
        where: 'email = ? AND password = ?',
        whereArgs: [normalizedEmail, hashedPassword],
      );

      return result.isNotEmpty;
    } catch (e) {
      print('Lỗi khi đăng nhập người dùng: $e');
      return false;
    }
  }

  Future<void> deleteDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'login_app.db');
    await databaseFactory.deleteDatabase(path);
    _database = null; // Reset database instance
  }
}
