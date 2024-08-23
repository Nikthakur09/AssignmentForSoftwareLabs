class SignUp {
  String fullName;
  String email;
  String phone;
  String password;

  SignUp({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
