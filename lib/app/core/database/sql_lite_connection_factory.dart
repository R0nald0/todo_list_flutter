
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/database/sql_lite_migration_factory.dart';

class SqlLiteConnectionFactory {
    static const _DATABASE_NAME ="todo_list.db";
    static const _DATABASE_VERSION =1;
    static SqlLiteConnectionFactory? _instance;
    
    Database? _db ;
    

    SqlLiteConnectionFactory._();

    factory SqlLiteConnectionFactory(){
        
       _instance ??= SqlLiteConnectionFactory._();
       return _instance!;  
    }

    Future<Database?> openConnection() async{
      final databasePath =  await getDatabasesPath();
      final databaseFinalPath = join(databasePath,_DATABASE_NAME);
       
        _db ??= await openDatabase(
             databaseFinalPath,
             version: _DATABASE_VERSION,
             onCreate: _onCreate,
             onConfigure: _onConfigure,
             onDowngrade: _onDownGrade,
             onUpgrade: _onUpGrade
        );

        return _db;
    }
  Future<void> _onConfigure(Database database) async{
       await database.execute('PRAGMA  foreign_keys = ON');
  }
  Future<void> _onCreate(Database db , int versio) async{
    final batch  = db.batch();
      
   final migrations = SqlLiteMigrationFactory().getCreateMigration();
   for (var migration in migrations) {
       migration.create(batch);
   }   
     
     batch.commit();
  }
 
  Future<void> _onDownGrade(Database db,int oldVersion,int version) async{
     final batch = db.batch();

     final migrations = SqlLiteMigrationFactory().upgradeMigration(oldVersion);

     for (var migration in migrations) {
         migration.upgrade(batch);
     }

     batch.commit();
  }
  Future<void> _onUpGrade(Database db,int oldVersion,int version) async{}

  void closeConnection(){
     if (_db != null) {
        _db?.close();
         _db = null;
     }
  }
    
}