class UserModel {
  late String name, email, image, phone, token;

  UserModel(
      {required this.name,
      required this.email,
      required this.image,
      required this.phone,
      required this.token});

  factory UserModel.fromUser(Map m1) {
    return UserModel(
        name: m1['name'],
        email: m1['email'],
        image: m1['image'],
        phone: m1['phone'],
        token: m1['token']);
  }

  Map<String, String?> toMap(UserModel user) {
    return {
      'email': user.email,
      'name': user.name,
      'image': user.image,
      'token': user.token,
      'phone': user.phone
    };
  }
}
