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
  }

  Future<User> create(User user) async {
    final db = await instance.database;

        // final json = user.toJson();
    // final columns =
    //     '${UserFields.title}, ${UserFields.description}, ${UserFields.time}';
    // final values =
    //     '${json[UserFields.title]}, ${json[UserFields.description]}, ${json[UserFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
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
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableUsers ORDER BY $orderBy');
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

}