import 'package:equatable/equatable.dart';
import 'package:orm_floor/entity/employee.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

// event to fetch all the employee
class FetchEmployees extends EmployeeEvent {}

// event to fetch specific employee
class FetchSpecificEmployee extends EmployeeEvent {
  final int id;

  const FetchSpecificEmployee({required this.id});

  @override
  List<Object?> get props => [id];
}

// deletespecific employee
class DeleteEmployee extends EmployeeEvent {
  final int id;
  const DeleteEmployee({required this.id});

  @override
  List<Object?> get props => [id];
}

// update employee
class UpdateEmployee extends EmployeeEvent {
  final Employee emp;
  const UpdateEmployee({required this.emp});

  @override
  List<Object?> get props => [emp];
}

// create new employee
class CreateNewEmployee extends EmployeeEvent {
  final Employee emp;
  const CreateNewEmployee({required this.emp});

  @override
  List<Object?> get props => [emp];
}
