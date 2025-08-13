import 'package:floor/floor.dart';
import 'package:orm_floor/entity/employee.dart';

@dao
abstract class EmployeeDao {
  // Create a new employee
  @insert
  Future<void> saveUser(Employee employee);

  // Update an existing employee
  @update
  Future<void> updateUser(Employee employee);

  // Get a specific employee by id
  @Query("SELECT * FROM Employee WHERE id = :id")
  Future<Employee?> getSpecificEmployee(int id);

  // Get all employees
  @Query("SELECT * FROM Employee")
  Future<List<Employee>> getAllEmployee();

  // Delete a specific employee by id
  @Query("DELETE FROM Employee WHERE id = :id")
  Future<void> deleteEmployee(int id);
}
