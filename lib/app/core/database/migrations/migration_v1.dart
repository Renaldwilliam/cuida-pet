// ignore_for_file: file_names

import 'package:cuida_pet_modular_mobx/app/core/database/migrations/migration.dart';
import 'package:sqflite/sqflite.dart';


class MigrationV1 extends Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE address(
        id Integer primary key autoincrement,
        address text not null,
        lat text,
        lng text,
        additional text
      )
    ''');
  }

  @override
  void update(Batch batch) {}
}
