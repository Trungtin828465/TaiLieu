class User {
  final int? id;
  final String fullName;  // Họ và tên
  final String email;     // Email
  final String phone;     // Số điện thoại
  final DateTime birthDate; // Ngày sinh
  final String gender;    // Giới tính (Nam, Nữ, Khác)
  final String password;  // Mật khẩu

  // Constructor
  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.password,
  });

  // Phương thức tạo đối tượng User từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      birthDate: DateTime.parse(json['birthDate']),
      gender: json['gender'],
      password: json['password'],
    );
  }

  // Phương thức chuyển đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'password': password,
    };
  }

  // Phương thức kiểm tra tính hợp lệ của email
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Phương thức kiểm tra tính hợp lệ của số điện thoại
  bool isValidPhone() {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phone);
  }

  // Phương thức kiểm tra tính hợp lệ của mật khẩu (ít nhất 6 ký tự)
  bool isValidPassword() {
    return password.length >= 6;
  }
}
