
final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id,
    userName,
    firstName,
    lastName,
    employeeId,
    phoneNumber,
    password
  ];

  static final String id = '_id';
  static final String userName = 'userName';
  static final String firstName = 'firstName';
  static final String lastName = 'lastName';
  static final String employeeId = 'employeeId';
  static final String phoneNumber = 'phoneNumber';
  static final String password = 'password';
}

class User {
  final int? id;
  final String userName;
  final String firstName;
  final String lastName;
  final String employeeId;
  final String phoneNumber;
  final String password;
  
  const User({
    this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.employeeId,
    required this.password,
  }); 
  
  User copy({
    int? id,
    String? userName,
    String? firstName,
    String? lastName,
    String? employeeId,
    String? phoneNumber,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      employeeId: employeeId ?? this.employeeId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json[UserFields.id] as int,
      userName: json[UserFields.userName] as String,
      firstName: json[UserFields.firstName] as String,
      lastName: json[UserFields.lastName] as String,
      employeeId: json[UserFields.employeeId] as String,
      phoneNumber: json[UserFields.phoneNumber] as String,
      password: json[UserFields.password] as String,
    );
  }

  Map<String, Object?> toJson() => {
  UserFields.id: id,
  UserFields.userName: userName,
  UserFields.firstName: firstName,
  UserFields.lastName: lastName,
  UserFields.employeeId: employeeId,
  UserFields.phoneNumber: phoneNumber,
  UserFields.password: password,
};

}