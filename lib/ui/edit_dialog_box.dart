import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orm_floor/bloc/employee_bloc.dart';
import 'package:orm_floor/bloc/employee_event.dart';
import 'package:orm_floor/bloc/employee_state.dart';
import 'package:orm_floor/entity/employee.dart';

class EditDialogBox extends StatefulWidget {
  const EditDialogBox({super.key});

  @override
  State<EditDialogBox> createState() => _EditDialogBoxState();
}

class _EditDialogBoxState extends State<EditDialogBox> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text("Update Employee Info"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                  validator: (value) => value!.isEmpty ? "Name required" : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(hintText: "Address"),
                  validator: (value) => value!.isEmpty ? "Enter address" : null,
                ),
                TextFormField(
                  controller: _salaryController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Salary"),
                  validator: (value) => value!.isEmpty ? "Enter salary" : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final Employee emp = Employee(
                    0,
                    _nameController.text,
                    _addressController.text,
                    double.tryParse(_salaryController.text) ?? 0.0,
                  );

                  context.read<EmployeeBloc>().add(CreateNewEmployee(emp: emp));
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
