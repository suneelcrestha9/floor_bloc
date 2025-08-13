import 'package:floor/floor.dart';
import 'package:orm_floor/entity/employee.dart';
import 'package:orm_floor/repo/employee_dao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
}
