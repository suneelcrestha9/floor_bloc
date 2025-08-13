import 'package:floor/floor.dart';

@entity
class Employee {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;
  String address;
  double salary;

  Employee(this.id, this.name, this.address, this.salary);
}
