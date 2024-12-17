// ignore_for_file: file_names

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String phoneNumber;
  final String password;
  final String role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.phoneNumber,
    required this.password,
    required this.role,
  });

  // Factory constructor to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      city: json['city'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      role: json['role'],
    );
  }

  // Method to convert a User object to JSON (useful for registration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'city': city,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
