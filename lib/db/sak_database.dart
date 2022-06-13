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
    return await openDatabase(path, version: 2, onCreate: _createDB);
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
CREATE TABLE $tableAcceleromtr(
${AcceleromtrFields.id} $idType,
${AcceleromtrFields.sensor} $textType,
${AcceleromtrFields.name} $textType,
${AcceleromtrFields.xAxis} $textType,
${AcceleromtrFields.yAxis} $textType,
${AcceleromtrFields.zAxis} $textType,
${AcceleromtrFields.time} $textType,
)
'''); 

    await db.execute('''
CREATE TABLE $tableGyro(
${GyroFields.id} $idType,
${GyroFields.sensor} $textType,
${GyroFields.name} $textType,
${GyroFields.xAxis} $textType,
${GyroFields.yAxis} $textType,
${GyroFields.zAxis} $textType,
${GyroFields.time} $textType,
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
  ///Acceleromtr
  ///////////////////////////////////////////////////////////////////////////////
  
    Future<Acceleromtr> createAcceleromtr(Acceleromtr acceleromtr) async {
    final db = await instance.database;
    final id = await db.insert(tableAcceleromtr, acceleromtr.toJson());
    return acceleromtr.copy(id: id);
  }

  Future<Acceleromtr> readAcceleromtr(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAcceleromtr,
      columns: AcceleromtrFields.values,
      where: '${AcceleromtrFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Acceleromtr.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Acceleromtr>> readAllAcceleromtrs() async {
    final db = await instance.database;
    final orderBy = '${AcceleromtrFields.id} DESC';   
    final result = await db.query(tableAcceleromtr, orderBy: orderBy);

    return result.map((json) => Acceleromtr.fromJson(json)).toList();
  }

  Future<void> updateAcceleromtr(Acceleromtr acceleromtr) async {
    final db = await instance.database;

    await db.update(
      tableAcceleromtr,
      acceleromtr.toJson(),
      where: '${AcceleromtrFields.id} = ?',
      whereArgs: [acceleromtr.id],
    );
  }

  Future<void> deleteAcceleromtr(int id) async {
    final db = await instance.database;

    await db.delete(
      tableAcceleromtr,
      where: '${AcceleromtrFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeAcceleromtr() async {
    final db = await instance.database;
    db.close();
  }

  ////////////////////////////////////////////////////////////////////////////////
  ///Gyroscope
  ////////////////////////////////////////////////////////////////////////////////
  
    Future<Gyro> createGyro(Gyro gyro) async {
    final db = await instance.database;
    final id = await db.insert(tableGyro, gyro.toJson());
    return gyro.copy(id: id);
  }

  Future<Gyro> readGyro(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGyro,
      columns: GyroFields.values,
      where: '${GyroFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Gyro.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Gyro>> readAllGyros() async {
    final db = await instance.database;
    final orderBy = '${GyroFields.id} DESC';   
    final result = await db.query(tableGyro, orderBy: orderBy);

    return result.map((json) => Gyro.fromJson(json)).toList();
  }

  Future<void> updateGyro(Gyro gyro) async {
    final db = await instance.database;

    await db.update(
      tableGyro,
      gyro.toJson(),
      where: '${GyroFields.id} = ?',
      whereArgs: [gyro.id],
    );
  }

  Future<void> deleteGyro(int id) async {
    final db = await instance.database;

    await db.delete(
      tableGyro,
      where: '${GyroFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeGyro() async {
    final db = await instance.database;
    db.close();
  }

}