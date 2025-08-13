import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orm_floor/bloc/employee_bloc.dart';
import 'package:orm_floor/bloc/employee_event.dart';
import 'package:orm_floor/bloc/employee_state.dart';
import 'package:orm_floor/emum/enum.dart';
import 'package:orm_floor/ui/add_dialog_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EmployeeBloc>().add(FetchEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Locally stored employees")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddDialogBox();
                  },
                );
              },
              child: Icon(size: 40, color: Colors.green, Icons.add_box_rounded),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("All data")),
          BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.loading:
                  return Center(child: CircularProgressIndicator());
                case Status.failed:
                  return Center(child: Text(state.message.toString()));
                case Status.success:
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.employee!.length,
                      itemBuilder: (context, index) {
                        final item = state.employee![index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(item.name),
                                    Text(item.address),
                                    Text(item.salary.toString()),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    context.read<EmployeeBloc>().add(
                                      DeleteEmployee(id: item.id),
                                    );
                                  },
                                  child: Icon(color: Colors.red, Icons.delete),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.read<EmployeeBloc>().add(
                                      DeleteEmployee(id: item.id),
                                    );
                                  },
                                  child: Icon(color: Colors.red, Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
