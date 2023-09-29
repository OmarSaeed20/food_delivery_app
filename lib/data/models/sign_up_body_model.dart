class SignUpBodyModel {
  String? name;
  String? email;
  String? password;
  String? phone;

  SignUpBodyModel({
    this.name,
    this.email,
    this.password,
    this.phone,
  });

  factory SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    return SignUpBodyModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }
}
