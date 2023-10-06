import 'package:cuida_pet_modular_mobx/app/core/database/migrations/migration.dart';
import 'package:cuida_pet_modular_mobx/app/core/database/migrations/migration_V1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [
        MigrationV1(),
      ];

  List<Migration> getUpdateMigrations(int version) {
    return [];
  }
}
