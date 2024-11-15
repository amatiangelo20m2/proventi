import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:proventi/global/style.dart';
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
  final TextEditingController _prefixController = TextEditingController();

  final FocusNode _minutesFocusNode = FocusNode();
  final int _waitingMinutes = 0;

  DateTime _bookingDate = DateTime.now();

  List<CustomerDTO> currentCustomerDTOList = [];

  String convertMinutesToHMMFormat(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return 'Arrivo alle ${hours}:${remainingMinutes.toString().padLeft(2, '0')}';
  }

  Country _currentSelectedCountry = Country.parse('IT');


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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            backgroundColor: globalGold,
            cardColor: Colors.black
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _bookingDate) {
      print('Selected date: ' + pickedDate.toLocal().toString());
      setState(() {
        _bookingDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
        print(_bookingDate.toLocal().toString());
      });
    }
  }


  List<String> _generateTimeSlots(TimeRange timeRange) {
    List<String> timeSlots = [];

    // Check if the time ranges are valid. If not, use default values.
    int startLunchHour = timeRange.openingHour ?? 12; // Default to 12 if null
    int startLunchMinute = timeRange.openingMinutes ?? 0; // Default to 0 if null
    int endLunchHour = timeRange.closingHour ?? 14; // Default to 14 (2 PM) if null
    int endLunchMinute = timeRange.closingMinutes ?? 0; // Default to 0 if null

    // Create time slots for lunch
    DateTime startLunch = DateTime(0, 0, 0, startLunchHour, startLunchMinute);
    DateTime endLunch = DateTime(0, 0, 0, endLunchHour, endLunchMinute);

    while (startLunch.isBefore(endLunch) || startLunch.isAtSameMomentAs(endLunch)) {
      timeSlots.add(DateFormat('H:mm').format(startLunch));
      startLunch = startLunch.add(const Duration(minutes: 15));
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


    return Material(
      child: Consumer<RestaurantStateManager>(
        builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {
          List<String> timeSlotLunch = _generateTimeSlots(restaurantStateManager.restaurantConfiguration!.daylyTimeWorkingRange!);
          List<String> timeSlotDinner = _generateTimeSlots(restaurantStateManager.restaurantConfiguration!.nightTimeWorkingRange!);
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text("Crea prenotazione"),
            ),
            child: Stack(
              children: [Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Consumer<CustomerStateManager>(
                      builder: (BuildContext context, CustomerStateManager customerStateManager, Widget? child) {
                        return Row(
                          children: [
                            CupertinoButton(onPressed: (){
                              showCountryPicker(
                                context: context,
                                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                exclude: <String>['KN', 'MF'],
                                favorite: <String>['IT'],
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {
                                    _currentSelectedCountry = country;
                                    _prefixController.text = _currentSelectedCountry.countryCode;
                                  });
                                },
                                moveAlongWithKeyboard: false,
                                countryListTheme: CountryListThemeData(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Ricerca nazione',

                                    prefixIcon: const Icon(CupertinoIcons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  searchTextStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            }, child: Text('${_currentSelectedCountry.flagEmoji} '
                                '+${_currentSelectedCountry.phoneCode}',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey[900]),)),
                            Expanded(
                              child: CupertinoTextField(
                                onChanged: (typingNumber){
                                  setState(() {
                                    currentCustomerDTOList.clear();
                                    if(typingNumber.length > 4){
                                      for (var element in customerStateManager.currentCustomersList!) {
                                        if(element.phone!.contains(typingNumber)){
                                          currentCustomerDTOList.add(element);
                                        }
                                      }
                                    }
                                  });
                                },
                                keyboardType: TextInputType.number,
                                controller: _phoneController,
                                placeholder: "Cellulare",
                                clearButtonMode: OverlayVisibilityMode.always,
                                style: const TextStyle(fontSize: 13),
                                padding: const EdgeInsets.all(8),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      placeholder: "Nome",
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      textCapitalization: TextCapitalization.words,
                      controller: _lastNameController,
                      placeholder: "Cognome",
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
                    CupertinoButton(
                      color: Colors.grey[900],
                      onPressed: () => _selectDate(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat("dd MMMM yyyy", "it_IT").format(_bookingDate).toUpperCase() + '  ',
                            style: const TextStyle(color: Colors.white, fontSize: 15),),
                          const Icon(CupertinoIcons.calendar_today, color: CupertinoColors.white,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Pranzo'),
                Wrap(
                  children: timeSlotLunch.map((time) {
                    final isSelected = time == selectedTime;
                    return GestureDetector(
                      onTap: () => _onChipTap(time),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(
                          label: Text(time),
                          backgroundColor: isSelected ? globalGold : Colors.orangeAccent.withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                    Text('Cena'),
                    Wrap(
                      children: timeSlotDinner.map((time) {
                        final isSelected = time == selectedTime;
                        return GestureDetector(
                          onTap: () => _onChipTap(time),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Chip(
                              label: Text(time),
                              backgroundColor: isSelected ? globalGold : Colors.blueAccent.withOpacity(0.1),
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
                      keyboardType: TextInputType.number,
                      controller: _guests,
                      placeholder: "Ospiti",
                      padding: const EdgeInsets.all(8),
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
                    CupertinoButton(
                      color: Colors.grey[900],
                      child: const Text("Crea"),
                      onPressed: () async {
                        // Call your API method to create the booking with the waiting time in minutes
                        BookingDTO? bookingDTO = await restaurantStateManager.bookingControllerApi.create(BookingDTO(
                            bookingId: 0,
                            branchName: restaurantStateManager.restaurantConfiguration!.restaurantName!,
                            formCode: '',
                            branchCode: restaurantStateManager.currentEmployee!.branchCode!,
                            bookingCode: '',
                            bookingDate: DateTime(_bookingDate.year, _bookingDate.month, _bookingDate.day, 1, 0).toUtc(),
                            noShow: false,
                            numGuestsAfterUpdate: 0,
                            bookingDateAfterUpdate: DateTime(_bookingDate.year, _bookingDate.month, _bookingDate.day, 1, 0),
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
                            bookingSource: BookingDTOBookingSourceEnum.APP,
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
                if(currentCustomerDTOList.isNotEmpty)  Positioned(bottom: 0,
                    left: 0,
                    right: 0,
                    child: Material(
                      child: Container(
                        height: 50,
                        color: Colors.grey.shade50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: currentCustomerDTOList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _nameController.text = currentCustomerDTOList[index].firstName!;
                                  _lastNameController.text = currentCustomerDTOList[index].lastName!;

                                  _prefixController.text = currentCustomerDTOList[index].prefix!;
                                  _emailController.text = currentCustomerDTOList[index].email!;
                                  _phoneController.text = currentCustomerDTOList[index].phone!;
                                  currentCustomerDTOList.clear();

                                });

                                FocusScope.of(context).unfocus();

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 3, left: 2),
                                child: Chip(
                                    label: Text('${currentCustomerDTOList[index].firstName!} '
                                        '${currentCustomerDTOList[index].lastName!} '
                                        '(+${currentCustomerDTOList[index].prefix!})${currentCustomerDTOList[index].phone!}', style: TextStyle(fontSize: 10),
                                    )
                                ),
                              ),
                            );
                          },),),
                    ))
              ]
            ),
          );
        },
      ),
    );
  }
}