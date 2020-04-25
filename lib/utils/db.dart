import 'dart:async';

import 'package:cmdtarefas/models/model_base.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB{
  
  static Database _dbInstance;
  static int get _versionDB => 1;

  static Future<void> init() async{

    if(_dbInstance != null) return;

    String _pathDB = await getDatabasesPath() + "tarefas.db";
    _dbInstance = await openDatabase(
      _pathDB, 
      version: _versionDB, 
      onCreate: _onCreate,
            );
        }
      
        static FutureOr<void> _onCreate(Database db, int version) async {
          await db.execute(
          'CREATE TABLE tarefas (id INTERGER PRIMARY KEY NOT NULL,'
          'tarefa STRING, completo BOOLEAN');
        }

        static Future<int> insert(String table, BaseModel model) async{
          await _dbInstance.insert(table, model.toMap());
        }

        static Future<int> delete(String table, BaseModel model) async{
          await _dbInstance.delete(table, where: 'id = ?', whereArgs: [model.id]);
        }

        static Future<int> update(String table, BaseModel model) async{
          await _dbInstance.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);
        }

         static Future<List<Map<String, dynamic>>> query(String sql, List<dynamic> args) async{
          return await _dbInstance.rawQuery(sql, args);
        }
        



}