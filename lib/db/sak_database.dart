import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sak_app/model/sak.dart';

class SakDatabase {
  static final SakDatabase instance = SakDatabase._init();

  static Database? _database;

  SakDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sak.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    //final integerType = 'INTEGER NOT NULL';

// create tables below after deinfining them in the model
    await db.execute('''
CREATE TABLE $tableUsers(
${UserFields.id} $idType,
${UserFields.userName} $textType,
${UserFields.firstName} $textType,
${UserFields.lastName} $textType,
${UserFields.employeeId} $textType,
${UserFields.phoneNumber} $textType,
${UserFields.password} $textType
)
'''); 

    await db.execute('''
CREATE TABLE $tableSensors(
${SensorFields.id} $idType,
${SensorFields.sensor} $textType,
${SensorFields.name} $textType,
${SensorFields.xAxis} $textType,
${SensorFields.yAxis} $textType,
${SensorFields.zAxis} $textType,
${SensorFields.time} $textType
)
'''); 
  }

  ////////////////////////////////////////////////////////////////////////////////
  ///Users
  ///////////////////////////////////////////////////////////////////////////////
  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;
    final orderBy = '${UserFields.id} DESC';   
    final result = await db.query(tableUsers, orderBy: orderBy);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<void> update(User user) async {
    final db = await instance.database;

    await db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await instance.database;

    await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }


  ////////////////////////////////////////////////////////////////////////////////
  ///Sensor
  ///////////////////////////////////////////////////////////////////////////////
  
    Future<Sensor> createSensor(Sensor sensor) async {
    final db = await instance.database;
    final id = await db.insert(tableSensors, sensor.toJson());
    return sensor.copy(id: id);
  }

  Future<Sensor> readSensor(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSensors,
      columns: SensorFields.values,
      where: '${SensorFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Sensor.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<void> createSensors(List<dynamic> list, String codeDialog, String livesensor) async {
    final db = await instance.database;
    for (var i = 0; i < list.length; i++) {
      final columns = 
      "${SensorFields.sensor},${SensorFields.name}, ${SensorFields.xAxis}, ${SensorFields.yAxis}, ${SensorFields.zAxis}, ${SensorFields.time}";
      String values = "'$livesensor','$codeDialog', '${list[i][0]}', '${list[i][1]}', '${list[i][2]}', '${list[i][3]}'";
      await db.rawInsert("""INSERT INTO $tableSensors ($columns) VALUES ($values)""");
      }
    }

  Future<List<Sensor>> readAllSensors() async {
    final db = await instance.database;
    final orderBy = '${SensorFields.id} DESC';   
    final result = await db.query(tableSensors, orderBy: orderBy);

    return result.map((json) => Sensor.fromJson(json)).toList();
  }

  Future<List<Sensor>> downloadSensor(String name) async {
    final db = await instance.database;
    final orderBy = '${SensorFields.id} DESC'; 
    final where = '${SensorFields.name} = ?';
    final whereArgs = [name];
    final result = await db.query(tableSensors, where: where, whereArgs: whereArgs, orderBy: orderBy);
    return result.map((json) => Sensor.fromJson(json)).toList();
  }


  Future<void> updateSensor(Sensor sensor) async {
    final db = await instance.database;

    await db.update(
      tableSensors,
      sensor.toJson(),
      where: '${SensorFields.id} = ?',
      whereArgs: [sensor.id],
    );
  }

  Future<void> deleteSensor(int id) async {
    final db = await instance.database;

    await db.delete(
      tableSensors,
      where: '${SensorFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeSensor() async {
    final db = await instance.database;
    db.close();
  }

}