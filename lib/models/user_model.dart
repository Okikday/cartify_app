class UserModel {
  final String id;
  final String userName;
  final String fullName;
  final String email;
  final String role;
  final String phoneNumber;
  final String apiKey;

  UserModel(
      {required this.id,
      required this.userName,
      required this.fullName,
      required this.email,
      required this.role,
      required this.apiKey,
      required this.phoneNumber});

  factory UserModel.fromMap(Map<String, dynamic> json) {

    return UserModel(
        id: json['_id'],
        userName: json['username'],
        fullName: json['fullname'],
        email: json['email'],
        role: json['role'],
        apiKey: json['accesstoken'],
        phoneNumber: json['phoneNumber'].toString(),
        );
  }
}
