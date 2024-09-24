
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:todo_list_provider/app/core/database/migrations/migrationV1.dart';

class SqlLiteMigrationFactory {

   List<Migration> getCreateMigration()=>[
    MigrationV1(),
   ];  
 
   List<Migration> upgradeMigration(int version)=>[];
}