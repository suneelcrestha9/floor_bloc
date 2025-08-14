import 'package:equatable/equatable.dart';
import 'package:orm_floor/emum/enum.dart';
import 'package:orm_floor/entity/employee.dart';

class EmployeeState extends Equatable {
  final Status status;
  final List<Employee>? employee;
  final String message;

  const EmployeeState({
    this.status = Status.loading,
    this.employee = const <Employee>[],
    this.message = "",
  });

  EmployeeState copyWith({
    Status? status,
    List<Employee>? employee,
    String? message,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      message: message ?? this.message,
      employee: employee ?? this.employee,
    );
  }

  @override
  List<Object?> get props => [status, message, employee];
}
