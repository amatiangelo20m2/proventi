import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';

const TextStyle testStyle = TextStyle(
  fontSize: 12,
  color: Colors.black,
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
        final List<CustomerDTO> customers = customerStateManager.currentCustomerDTOList!;

        // Grouping and filtering customers
        Map<String, List<CustomerDTO>> groupedCustomers = {};
        for (var customer in customers) {
          if (customer.lastName != null &&
              (customer.lastName!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                  customer.firstName?.toLowerCase().contains(searchQuery.toLowerCase()) == true)) {
            String firstLetter = customer.lastName![0].toUpperCase();
            groupedCustomers.putIfAbsent(firstLetter, () => []).add(customer);
          }
        }

        List<String> sortedKeys = groupedCustomers.keys.toList()..sort();

        // Preparing DataRow entries
        List<DataRow> customerRows = [];
        for (var key in sortedKeys) {
          List<CustomerDTO> customersGroup =
          groupedCustomers[key]!..sort((a, b) => a.lastName!.compareTo(b.lastName!));
          for (var customer in customersGroup) {
            customerRows.add(
              DataRow(
                cells: [
                  DataCell(ProfileImage(
                    allowNavigation: true,
                    customer: customer,
                    branchCode: customerStateManager.branchCode,
                    avatarRadious: 30,
                  )),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${customer.firstName} ${customer.lastName}', style: testStyle),
                        Text(
                          '+ ${customer.prefix ?? ""} ${customer.phone ?? ""}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
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
              IconButton(
                onPressed: () async {
                  await customerStateManager.refreshHistory();
                },
                icon: const Icon(Icons.refresh),
              ),
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the width for the table
                    double tableWidth = constraints.maxWidth;

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: tableWidth),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('', style: testStyle)),
                              DataColumn(label: Text('Nome', style: testStyle)),
                              DataColumn(label: Text('Email', style: testStyle)),
                            ],
                            rows: customerRows,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
