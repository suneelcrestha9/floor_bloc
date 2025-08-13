import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orm_floor/bloc/employee_bloc.dart';
import 'package:orm_floor/bloc/employee_event.dart';
import 'package:orm_floor/entity/employee.dart';

class AddDialogBox extends StatefulWidget {
  const AddDialogBox({super.key});

  @override
  State<AddDialogBox> createState() => _AddDialogBoxState();
}

class _AddDialogBoxState extends State<AddDialogBox> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _eidController = TextEditingController();
  final _addressController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Employee"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _eidController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "EID"),
              validator: (value) => value!.isEmpty ? "EID required" : null,
            ),
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
                int.tryParse(_eidController.text) ?? 0,
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
  }
}
