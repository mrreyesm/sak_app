
final String tableUsers = 'users';
final String tableAcceleromtr = 'acceleromtr';
final String tableGyro = 'gyro';

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

class AcceleromtrFields {
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

class GyroFields {
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


class Acceleromtr {
  final int? id;
  final String sensor;
  final String name;
  final String xAxis;
  final String yAxis;
  final String zAxis;
  final String time;
  
  const Acceleromtr({
    this.id,
    required this.sensor,
    required this.name,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
    required this.time,
  }); 
  
  Acceleromtr copy({
    int? id,
    String? sensor,
    String? name,
    String? xAxis,
    String? yAxis,
    String? zAxis,
    String? time,
  }) {
    return Acceleromtr(
      id: id ?? this.id,
      sensor: sensor ?? this.sensor,
      name: name ?? this.name,
      xAxis: xAxis ?? this.xAxis,
      yAxis: yAxis ?? this.yAxis,
      zAxis: zAxis ?? this.zAxis,
      time: time ?? this.time,
    );
  }

  static Acceleromtr fromJson(Map<String, dynamic> json) {
    return Acceleromtr(
      id: json[AcceleromtrFields.id] as int,
      sensor: json[AcceleromtrFields.sensor] as String,
      name: json[AcceleromtrFields.name] as String,
      xAxis: json[AcceleromtrFields.xAxis] as String,
      yAxis: json[AcceleromtrFields.yAxis] as String,
      zAxis: json[AcceleromtrFields.zAxis] as String,
      time: json[AcceleromtrFields.time] as String,
    );
  }

  Map<String, Object?> toJson() => {
  AcceleromtrFields.id: id,
  AcceleromtrFields.sensor: sensor,
  AcceleromtrFields.name: name,
  AcceleromtrFields.xAxis: xAxis,
  AcceleromtrFields.yAxis: yAxis,
  AcceleromtrFields.zAxis: zAxis,
  AcceleromtrFields.time: time,  
};

}


class Gyro {
  final int? id;
  final String sensor;
  final String name;
  final String xAxis;
  final String yAxis;
  final String zAxis;
  final String time;
  
  const Gyro({
    this.id,
    required this.sensor,
    required this.name,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
    required this.time,
  }); 
  
  Gyro copy({
    int? id,
    String? sensor,
    String? name,
    String? xAxis,
    String? yAxis,
    String? zAxis,
    String? time,
  }) {
    return Gyro(
      id: id ?? this.id,
      sensor: sensor ?? this.sensor,
      name: name ?? this.name,
      xAxis: xAxis ?? this.xAxis,
      yAxis: yAxis ?? this.yAxis,
      zAxis: zAxis ?? this.zAxis,
      time: time ?? this.time,
    );
  }

  static Gyro fromJson(Map<String, dynamic> json) {
    return Gyro(
      id: json[GyroFields.id] as int,
      sensor: json[GyroFields.sensor] as String,
      name: json[GyroFields.name] as String,
      xAxis: json[GyroFields.xAxis] as String,
      yAxis: json[GyroFields.yAxis] as String,
      zAxis: json[GyroFields.zAxis] as String,
      time: json[GyroFields.time] as String,
    );
  }

  Map<String, Object?> toJson() => {
  GyroFields.id: id,
  GyroFields.sensor: sensor,
  GyroFields.name: name,
  GyroFields.xAxis: xAxis,
  GyroFields.yAxis: yAxis,
  GyroFields.zAxis: zAxis,
  GyroFields.time: time,  
};

}