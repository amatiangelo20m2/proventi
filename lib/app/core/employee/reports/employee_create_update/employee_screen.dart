import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import '../report_employee_presence.dart';
import '../state_manager/employee_state_manager.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  static const String routeName = 'employee_screen';

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeStateManager>(
      builder: (BuildContext context, EmployeeStateManager employeeStateManager, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: _buildEmployeeList(employeeStateManager),

          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            leading: IconButton(onPressed: () {
              Navigator.of(context).pushNamed(ReportEmployeePresence.routeName);
            }, icon: const Icon(Icons.arrow_back),),
            title: Text('Lista Dipendenti', style: const TextStyle(fontSize: 12),),
          ),
        );
      },
    );
  }

  _buildEmployeeList(EmployeeStateManager employeeStateManager) {

    return RefreshIndicator(
      onRefresh: () async {
        employeeStateManager.retrieveCurrentEmployee();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 140),
        itemCount: employeeStateManager.currentEmployeeList!.length!,
        itemBuilder: (BuildContext context, int index) {

          EmployeeDTO? employeeDTO = employeeStateManager.currentEmployeeList![index];
          return ListTile(
            tileColor: index.isEven ? Colors.white : Colors.grey.shade100,
            leading: IconButton(onPressed: () async {
              try{

                await employeeStateManager.turnIsVisibleValueToEmployee(employeeDTO);

                Fluttertoast.showToast(
                  webShowClose: true,
                  timeInSecForIosWeb: 6,
                  msg: 'Visibilità modificata per ${employeeDTO.firstName!} ${employeeDTO.lastName!}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.blueGrey,
                  textColor: Colors.white,
                  fontSize: 12.0,
                );

              }catch(e){

                Fluttertoast.showToast(
                  webShowClose: true,
                  timeInSecForIosWeb: 6,
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 12.0,
                );
              }
            },
                icon: Icon(employeeDTO.visible! ? CupertinoIcons.eye : CupertinoIcons.eye_slash), color: !employeeDTO.visible! ? Colors.grey : Colors.green.shade600, iconSize: 35,),

            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${employeeDTO.lastName!} ${employeeDTO.firstName!}', style: const TextStyle(fontSize: 13),),
                    Text('(id: ${employeeDTO.employeeId!})', style: const TextStyle(fontSize: 5),),
                  ],
                ),
                Text(employeeDTO.jobDescription!.value.replaceAll('_', ' '), style: const TextStyle(fontSize: 8),),
                //Text('Assunto dal: ${italianDateFormat.format(employeeDTO.startDateInduction!)}', style: const TextStyle(fontSize: 12)),

              ],
            ),

          );
        },
      ),
    );
  }
}
