import 'package:bloc/bloc.dart';
import 'package:orm_floor/bloc/employee_event.dart';
import 'package:orm_floor/bloc/employee_state.dart';
import 'package:orm_floor/db/database.dart';
import 'package:orm_floor/emum/enum.dart';
import 'package:orm_floor/entity/employee.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeState()) {
    on<FetchEmployees>(_fetchEmployee);
    on<DeleteEmployee>(_deleteEmployee);
    on<CreateNewEmployee>(_createNewEmployee);
  }

  void _fetchEmployee(FetchEmployees event, Emitter<EmployeeState> emit) async {
    final database = await Database.getDataBase();

    try {
      final employees = await database!.employeeDao.getAllEmployee();
      emit(
        state.copyWith(
          employee: employees,
          status: Status.success,
          message: "Fetched all the data",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failed,
          message: "Error $e",
          employee: [],
        ),
      );
    }
  }

  // save new user
  void _createNewEmployee(
    CreateNewEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    final database = await Database.getDataBase();

    try {
      final Employee employee = event.emp;

      await database!.employeeDao.saveUser(employee);

      final updatedList = List<Employee>.from(state.employee ?? [])
        ..add(employee);

      emit(
        state.copyWith(
          status: Status.success,
          employee: updatedList,
          message: "New employee save successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failed,
          message: "Failed to create employee: $e",
        ),
      );
    }
  }

  // delete specific employee
  void _deleteEmployee(
    DeleteEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      final database = await Database.getDataBase();
      await database!.employeeDao.deleteEmployee(event.id);
      final updatedList = List<Employee>.from(state.employee ?? [])
        ..removeWhere((emp) => emp.id == event.id);
      emit(
        state.copyWith(
          status: Status.success,
          employee: updatedList,
          message: "deleted successfully",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failed, message: "error deleting $e"));
    }
  }
}
