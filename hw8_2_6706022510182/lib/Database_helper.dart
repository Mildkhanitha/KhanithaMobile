import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'User.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();
  Future<Database> get db async{
    _database ??= await initDb();
    return _database!;
  }
  Future <Database> initDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,"appDBbmi2.db");

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }
  Future _onCreate(Database db,int version) async{
    await db.execute(
      '''CREATE TABLE tbUsers (
      id INTEGER PRIMARY KEY,
      username TEXT,
      email TEXT,
      pwd TEXT,
      weight REAL,
      height REAL,
      bmi REAL,
      bmi_type TEXT,
      weight_adj TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db,int oldVersion ,int newVersion) async{
    if (oldVersion < 4) {
      await db.execute("ALTER TABLE tbUsers ADD COLUMN weight_adj TEXT");
      await db.execute("ALTER TABLE tbUsers ADD COLUMN bmi REAL") ;
      await db.execute("ALTER TABLE tbUsers ADD COLUMN bmi_type REAL");
      await updateAllbmi();
    }

  }
  Future <int> insertUser(User user) async{
    Database db = await instance.db;
    return await db.insert('tbUsers', user.toMap());
  }
  Future<List<Map<String,dynamic>>> queryAllUsers()async{
    Database db = await instance.db;
    return await db.query("tbUsers");
  }
  Future<List<User>> getUsers() async {
    List<Map<String ,dynamic>> usersMap = await queryAllUsers();
    return usersMap.map((map) => User.fromMap(map)).toList();
  }

  Future<int> updateUser(User user) async {
    Database db = await instance.db;
    return await db.update(
      "tbUsers", user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
      );
  }

  Future<int> deleteUser(int id) async{
    Database db = await instance.db;
    return await db.delete('tbUsers',where: "id = ?",whereArgs: [id]);
  }
  Future<void> deleteAllUser() async{
    Database db = await instance.db;
    await db.delete('tbUsers');
  }

  Future<void> updateAllbmi() async {
    Database db = await instance.db;
    List<User> users = await getUsers();

    for (User user in users){
      double bmi = User.calculatebmi(user.weight, user.height);
      String bmiType = User.determineBmiType(bmi);

      await db.update("tbUsers", {"bmi":bmi,"bmi_type":bmiType},where: "id = ?",whereArgs: [user.id]);
    }
    }
    Future<void> initializeUsers() async{
      // 1. ดึงข้อมูลผู้ใช้ทั้งหมดมาเช็คก่อน
    List<User> existingUsers = await getUsers(); 
    
    // 2. ถ้ามีข้อมูลอยู่แล้ว (ไม่ว่างเปล่า) ให้ return ออกไปเลย ไม่ต้องทำคำสั่งข้างล่างต่อ
    if (existingUsers.isNotEmpty) {
      return; 
    }

    List<User> userToAdd = [
      User(username: "Khanitha", email: "khanitha@email.com", pwd: "9999", height: 170, weight: 60),
      User(username: "Milan", email: "milan@email.com", pwd: "1234", height: 160, weight: 60)
    ];
    for (User user in userToAdd){
      await insertUser(user);
    }
  }
  }
  