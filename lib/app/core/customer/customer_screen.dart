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
        final List<CustomerHistoryDTO> customerHistoryList = customerStateManager.historicalCustomerData!;

        // Grouping and filtering customers
        Map<String, List<CustomerHistoryDTO>> groupedCustomers = {};
        for (var customerHist in customerHistoryList) {
          if (customerHist.customerDTO!.lastName != null &&
              (customerHist.customerDTO!.lastName!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                  customerHist.customerDTO!.firstName?.toLowerCase().contains(searchQuery.toLowerCase()) == true)) {
            String firstLetter = customerHist.customerDTO!.lastName![0].toUpperCase();
            groupedCustomers.putIfAbsent(firstLetter, () => []).add(customerHist);
          }
        }

        List<String> sortedKeys = groupedCustomers.keys.toList()..sort();

        // Preparing DataRow entries
        List<DataRow> customerRows = [];
        for (var key in sortedKeys) {
          List<CustomerHistoryDTO> customersGroup =
          groupedCustomers[key]!..sort((a, b) => a.customerDTO!.lastName!.compareTo(b.customerDTO!.lastName!));
          for (var customerHist in customersGroup) {
            customerRows.add(
              DataRow(
                cells: [
                  DataCell(
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ProfileImage(
                                            allowNavigation: true,
                                            customer: customerHist.customerDTO!,
                                            branchCode: customerStateManager.branchCode,
                                            avatarRadious: 30,
                          noShowBookings: customerHist.historicalNoShowsNumber!,
                                          ),
                      )),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${customerHist.customerDTO!.firstName} ${customerHist.customerDTO!.lastName}', style: testStyle),
                        Text(
                          '+ ${customerHist.customerDTO!.prefix ?? ""} ${customerHist.customerDTO!.phone ?? ""}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(customerHist.customerDTO!.email ?? "", style: testStyle)),
                  DataCell(Text(customerHist.historicalBookingsNumber!.toString(), style: testStyle)),
                ],
              ),
            );
          }
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('I miei clienti', style: TextStyle(color: Colors.grey[900], fontSize: 15)),
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

                    return RefreshIndicator(
                      onRefresh: () async {
                        await customerStateManager.refreshHistory();
                      },
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minWidth: tableWidth),
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('', style: testStyle)),
                                    DataColumn(label: Text('Nome', style: testStyle)),
                                    DataColumn(label: Text('Email', style: testStyle)),
                                    DataColumn(label: Text('Prenotazioni', style: testStyle)),
                                  ],
                                  rows: customerRows,
                                ),
                              ),
                            ),
                          ),
                        ],
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