class AppUser {
  final String email;
  final String name;
  final String phoneNumber;
  final String password;

  AppUser({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password, required String uid,
  });

  String? get uid => null;

  AppUser copyWith({
    String? email,
    String? name,
    String? phoneNumber,
    String? password,
    String? uid,

  }) {
    return AppUser(
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password, uid: '',
    );
  }

  @override
  String toString() {
    return 'AppUser(name: $name, email: $email, phone: $phoneNumber)';
  }
}
