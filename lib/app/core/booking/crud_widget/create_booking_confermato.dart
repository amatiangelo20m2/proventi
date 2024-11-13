import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../api/restaurant_client/lib/api.dart';
import '../../../../state_manager/restaurant_state_manager.dart';
import '../../customer/customer_state_manager.dart';

class CreateBookingStatusConfirmed extends StatefulWidget {
  const CreateBookingStatusConfirmed({super.key});

  @override
  State<CreateBookingStatusConfirmed> createState() => _CreateBookingStatusConfirmedState();
}

class _CreateBookingStatusConfirmedState extends State<CreateBookingStatusConfirmed> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _guests = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialRequests = TextEditingController();

  final FocusNode _minutesFocusNode = FocusNode();
  int _waitingMinutes = 0;

  DateTime _bookingDate = DateTime.now();


  String convertMinutesToHMMFormat(int minutes) {
    int hours = minutes ~/ 60; // Integer division to get the number of hours
    int remainingMinutes = minutes % 60; // Get the remainder for minutes
    return 'Arrivo alle ${hours}:${remainingMinutes.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _minutesFocusNode.addListener(() {
      if (_minutesFocusNode.hasFocus) {
        _minutesFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _minutesFocusNode.dispose();
    super.dispose();
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _bookingDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _bookingDate) {
      setState(() {
        _bookingDate = pickedDate;
      });
    }
  }

  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    DateTime startTime = DateTime(0, 0, 0, 12, 0); // Starting from 4:00 AM
    DateTime endTime = DateTime(0, 0, 0, 23, 59); // Until midnight

    while (startTime.isBefore(endTime)) {
      timeSlots.add(DateFormat('H:mm').format(startTime));
      startTime = startTime.add(const Duration(minutes: 15)); // Move to the next 2-hour interval
    }

    return timeSlots;
  }

  String? selectedTime;
  int? selectedHour;
  int? selectedMinute;

  void _onChipTap(String time) {
    // Parse the time string to extract hour and minute
    DateTime parsedTime = DateFormat('H:mm').parse(time);
    setState(() {
      selectedTime = time;
      selectedHour = parsedTime.hour;
      selectedMinute = parsedTime.minute;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = _generateTimeSlots();

    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: const Text(''),
              middle: const Text("Crea prenotazione"),
              trailing: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(CupertinoIcons.clear),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  Consumer<CustomerStateManager>(
                    builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {

                      return Autocomplete<CustomerDTO>(
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                            ) {
                          return CupertinoTextField(
                            placeholder: "Cellulare",
                            keyboardType: TextInputType.number,
                            controller: textEditingController,
                            focusNode: focusNode,
                          );
                        },
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          // If the input is empty, return an empty list
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<CustomerDTO>.empty();
                          }else if(textEditingValue.text.length < 5){
                            return const Iterable<CustomerDTO>.empty();
                          }

                          // Filter the customers based on the input text
                          return customerStateManager.currentCustomersList!
                              .where((customer) => customer.phone!
                              .contains(textEditingValue.text.toLowerCase()) ||
                              customer.firstName!.toLowerCase().contains(textEditingValue.text.toLowerCase()) ||
                              customer.lastName!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                        },

                        displayStringForOption: (CustomerDTO option) {
                          // Define how to display the complex object as a string
                          return '${option.firstName} ${option.lastName} - ${option.phone}';
                        },
                        onSelected: (CustomerDTO selectedCustomer) {
                          // Do something with the selected customer
                          setState(() {
                            _nameController.text = selectedCustomer.firstName ?? '';
                            _lastNameController.text = selectedCustomer.lastName ?? '';
                            _emailController.text = selectedCustomer.email ?? '';
                            _phoneController.text = selectedCustomer.phone ?? '';
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _nameController,
                    placeholder: "Nome",
                    padding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _lastNameController,
                    placeholder: "Cognome",
                    padding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _guests,
                    placeholder: "Ospiti",
                    padding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _emailController,
                    placeholder: "Email",
                    keyboardType: TextInputType.emailAddress,
                    padding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),
                    onPressed: () => _selectDate(context),
                    child: Text(DateFormat("dd MMMM yyyy", "it_IT").format(_bookingDate).toUpperCase(),
                      style: const TextStyle(color: Colors.black),),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    children: timeSlots.map((time) {
                      final isSelected = time == selectedTime;
                      return GestureDetector(
                        onTap: () => _onChipTap(time),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(time),
                            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _specialRequests,
                    placeholder: "Note",
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    child: Text("Crea"),
                    onPressed: () async {
                      // Call your API method to create the booking with the waiting time in minutes
                      BookingDTO? bookingDTO = await restaurantStateManager.bookingControllerApi.create(BookingDTO(
                          bookingId: 0,
                          formCode: '',
                          branchCode: restaurantStateManager.currentEmployee!.branchCode!,
                          bookingCode: '',
                          bookingDate: _bookingDate,
                          noShow: false,
                          numGuestsAfterUpdate: 0,
                          bookingDateAfterUpdate: _bookingDate,

                          timeSlot: TimeSlot(
                            bookingHour: selectedHour,
                            bookingMinutes: selectedMinute,
                          ),
                          numGuests: double.parse(_guests.text).toInt(),
                          status: BookingDTOStatusEnum.CONFERMATO,
                          specialRequests: _specialRequests.text,
                          customer: CustomerDTO(
                              firstName: _nameController.text,
                              lastName: _lastNameController.text,
                              phone: _phoneController.text,
                              prefix: '39',
                              email: _emailController.text
                          ),
                          createdAt: DateTime.now(),
                          timeWaitingFastQueueMinutes: _waitingMinutes, // Use the selected waiting minutes
                          bookingSource: BookingDTOBookingSourceEnum.WEB,
                          comingWithDogs: false));

                      if (bookingDTO != null) {
                        restaurantStateManager.refresh(DateTime.now());
                      } else {
                        Fluttertoast.showToast(
                          webShowClose: true,
                          timeInSecForIosWeb: 6,
                          msg: 'Ho riscontrato un problema durante l\'operazione. Riprova',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 12.0,
                        );
                      }

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}