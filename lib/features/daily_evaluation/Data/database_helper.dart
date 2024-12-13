// import 'dart:async';
// import 'package:daily_ev/features/daily_evaluation/Data/models/daily_evaluation.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;

//   DatabaseHelper._internal();
//   factory DatabaseHelper() {
//     return _instance;
//   }
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'daily_evaluations.db');
//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE daily_evaluations (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         date TEXT NOT NULL,
//         spiritualScore INTEGER NOT NULL,
//         physicalScore INTEGER NOT NULL,
//         mentalScore INTEGER NOT NULL,
//         notes TEXT
//       )
//     ''');
//   }

//   Future<List<DailyEvaluation>> getAllEvaluations() async {
//     final db = await database;
//     final result = await db.query('daily_evaluations');
//     return result.map((e) => DailyEvaluation.fromMap(e)).toList();
//   }

//   Future<int> addEvaluation(DailyEvaluation evaluation) async {
//     final db = await database;
//     return db.insert('daily_evaluations', evaluation.toMap());
//   }

//   Future<void> deleteEvaluation(int id) async {
//     final db = await database;
//     await db.delete('daily_evaluations', where: 'id = ?', whereArgs: [id]);
//   }
// }
