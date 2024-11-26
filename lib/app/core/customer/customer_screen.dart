import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';

import '../../../global/style.dart'; // Assuming you have a global file for styles

// Define a global text style
const TextStyle testStyle = TextStyle(
  fontSize: 12,
  color: Colors.black, // Default color for text
);

class CustomerScreen extends StatefulWidget {
  static const String routeName = 'customer_screen';

  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerStateManager>(
      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {
        final List<CustomerHistory> customers = customerStateManager.currentCustomersList!;

        Map<String, List<CustomerHistory>> groupedCustomers = {};
        for (var customer in customers) {
          if (customer.lastName != null &&
              (customer.lastName!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                  customer.firstName?.toLowerCase().contains(searchQuery.toLowerCase()) == true)) {
            String firstLetter = customer.lastName![0].toUpperCase();
            groupedCustomers.putIfAbsent(firstLetter, () => []).add(customer);
          }
        }

        List<String> sortedKeys = groupedCustomers.keys.toList()..sort();

        List<DataRow> customerRows = [];
        for (var key in sortedKeys) {
          List<CustomerHistory> customersGroup = groupedCustomers[key]!..sort((a, b) => a.lastName!.compareTo(b.lastName!));
          for (var customer in customersGroup) {
            customerRows.add(
              DataRow(
                cells: [
                  DataCell(ProfileImage(prefix: customer.prefix!,
                    phone: customer.phone!,
                    branchCode: customer.branchCode!,
                  ),),
                  DataCell(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${customer.firstName} ${customer.lastName}', style: testStyle),
                      Text('+ ${customer.prefix ?? ""} ${customer.phone ?? ""}', style: TextStyle(fontSize: 10),)
                    ],
                  )),


                  DataCell(Text('${customer.arrivatoCount ?? 0}', style: testStyle)),
                  DataCell(Text('${customer.nonArrivatoCount ?? 0}',
                    style: TextStyle(
                      color: customer.nonArrivatoCount! > 0 ? Colors.red : Colors.black,
                      fontSize: 12,
                    ),
                  )),
                  DataCell(Text('${customer.rifiutatoCount ?? 0}', style: testStyle)),
                  DataCell(Text('${customer.eliminatoCount ?? 0}', style: testStyle)),
                  DataCell(Text(italianDateFormat.format(customer.lastBookingDate!), style: testStyle)),
                  DataCell(Text(customer.email ?? "", style: testStyle)),
                ],
              ),
            );
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('I miei clienti', style: TextStyle(color: Colors.grey[900], fontSize: 15)),
            actions: [
              IconButton(onPressed: () async {
                await customerStateManager.refreshHistory();
              }, icon: Icon(Icons.refresh))
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  placeholder: 'Ricerca clienti...',
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: true,
                    headingRowHeight: 20,
                    columnSpacing: 10.0,
                    columns: const [
                      DataColumn(label: Text('', style: testStyle)),
                      DataColumn(label: Text('Nome', style: testStyle)),
                      DataColumn(label: Text('PRESENZE', style: testStyle)),
                      DataColumn(label: Text('NO SHOW', style: testStyle)),
                      DataColumn(label: Text('RIFIUTATO', style: testStyle)),
                      DataColumn(label: Text('ELIMINATO', style: testStyle)),
                      DataColumn(label: Text('ULTIMA PRESENZA', style: testStyle)),
                      DataColumn(label: Text('Email', style: testStyle)),
                    ],
                    rows: customerRows,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
