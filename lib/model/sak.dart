final String tableUsers = 'users';
final String tableSensors = 'sensors';

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

class SensorFields {
  static final List<String> values = [
    id,
    sensor,
    name,
    xAxis,
    yAxis,
    zAxis,
    time
  ];

  static final String id = '_id';
  static final String sensor = 'sensor';
  static final String name = 'name';
  static final String xAxis = 'xAxis';
  static final String yAxis = 'yAxis';
  static final String zAxis = 'zAxis';
  static final String time = 'time';
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


class Sensor {
  final int? id;
  final String sensor;
  final String name;
  final String xAxis;
  final String yAxis;
  final String zAxis;
  final DateTime time;
  
  const Sensor({
    this.id,
    required this.sensor,
    required this.name,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
    required this.time,
  }); 
  
  Sensor copy({
    int? id,
    String? sensor,
    String? name,
    String? xAxis,
    String? yAxis,
    String? zAxis,
    DateTime? time,
  }) {
    return Sensor(
      id: id ?? this.id,
      sensor: sensor ?? this.sensor,
      name: name ?? this.name,
      xAxis: xAxis ?? this.xAxis,
      yAxis: yAxis ?? this.yAxis,
      zAxis: zAxis ?? this.zAxis,
      time: time ?? this.time,
    );
  }

  static Sensor fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json[SensorFields.id] as int,
      sensor: json[SensorFields.sensor] as String,
      name: json[SensorFields.name] as String,
      xAxis: json[SensorFields.xAxis] as String,
      yAxis: json[SensorFields.yAxis] as String,
      zAxis: json[SensorFields.zAxis] as String,
      time: DateTime.parse(json[SensorFields.time] as String),
    );
  }

  Map<String, Object?> toJson() => {
  SensorFields.id: id,
  SensorFields.sensor: sensor,
  SensorFields.name: name,
  SensorFields.xAxis: xAxis,
  SensorFields.yAxis: yAxis,
  SensorFields.zAxis: zAxis,
  SensorFields.time: time.toIso8601String(),  
};

}