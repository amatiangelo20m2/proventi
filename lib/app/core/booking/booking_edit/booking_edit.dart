import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:proventi/app/custom_widgets/profile_image.dart';
import 'package:proventi/global/date_methods_utility.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';

import '../../../../api/restaurant_client/lib/api.dart';
import '../../../../state_manager/restaurant_state_manager.dart';

class BookingEdit extends StatefulWidget {
  final BookingDTO bookingDTO;
  final RestaurantDTO restaurantDTO;

  BookingEdit({required this.bookingDTO, required this.restaurantDTO});

  @override
  _BookingEditState createState() => _BookingEditState();
}

class _BookingEditState extends State<BookingEdit> {
  late TextEditingController _timeSlotController;
  late TextEditingController _numGuestsController;
  late TextEditingController _specialRequestsController;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailCustomerController;
  late TextEditingController _prefixController;
  late TextEditingController _phoneController;
  late TextEditingController _capController;

  final Country _currentSelectedCountry = Country.parse('IT');


  String? selectedTime;
  int? selectedHour;
  int? selectedMinute;

  DateTime _selectedNewDate = DateTime.now();

  String _currentImageUrl = '';


  @override
  void initState() {
    super.initState();

    selectedTime = widget.bookingDTO.timeSlot!.bookingHour!.toString()
        +':' + NumberFormat("00").format(widget.bookingDTO.timeSlot!.bookingMinutes!).toString();

    selectedHour = widget.bookingDTO.timeSlot!.bookingHour!;
    selectedMinute = widget.bookingDTO.timeSlot!.bookingMinutes!;

    _firstNameController = TextEditingController(text: widget.bookingDTO.customer!.firstName!);
    _lastNameController = TextEditingController(text: widget.bookingDTO.customer!.lastName!);

    _emailCustomerController = TextEditingController(text: widget.bookingDTO.customer!.email ?? '');
    _prefixController = TextEditingController(text: widget.bookingDTO.customer!.prefix ?? '');
    _phoneController = TextEditingController(text: widget.bookingDTO.customer!.phone ?? '');
    _capController = TextEditingController(text: widget.bookingDTO.customer!.postalCode ?? '');

    _timeSlotController = TextEditingController(text: '${widget.bookingDTO.timeSlot!.bookingHour!}:${widget.bookingDTO.timeSlot!.bookingMinutes!}');

    _numGuestsController = TextEditingController(text: widget.bookingDTO.numGuests?.toString());
    _specialRequestsController = TextEditingController(text: widget.bookingDTO.specialRequests);
    _selectedNewDate = DateTime(widget.bookingDTO.bookingDate!.year, widget.bookingDTO.bookingDate!.month, widget.bookingDTO.bookingDate!.day, 2);
  }

  @override
  void dispose() {
    // Dispose the controllers
    _timeSlotController.dispose();
    _numGuestsController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  Future<void> _saveBooking() async {
    try{


      await Provider.of<RestaurantStateManager>(context, listen: false).updateBooking(
          BookingDTO(
              bookingId: widget.bookingDTO.bookingId,
              bookingCode: widget.bookingDTO.bookingCode,
              numGuests: int.parse(_numGuestsController.text),
              bookingDate: _selectedNewDate,
              specialRequests: _specialRequestsController.text,
              status: widget.bookingDTO.status,
              timeSlot: TimeSlot(
                timeRangeCode: widget.bookingDTO.timeSlot!.timeRangeCode,
                bookingHour: selectedHour,
                bookingMinutes: selectedMinute,
              ),
              noShow: false
          )
      );

      await Provider.of<RestaurantStateManager>(context, listen: false)
          .customerControllerApi
          .updateCustomer(CustomerDTO(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        prefix: _prefixController.text,
        phone: _phoneController.text,
        email: _emailCustomerController.text,
        postalCode: _capController.text,
        customerId: widget.bookingDTO.customer!.customerId!,
        registrationDate: DateTime.now().toUtc(),
        notes: '',
        profilingConsent: true,
        presenceCount: 0,
        flames: 0,
        origin: 'WEB',
        birthDate: DateTime.now().toUtc(),
        lastPresence: DateTime.now().toUtc(),
      ));

      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Aggiornamento riuscito",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text('Aggiorna prenotazione', style: TextStyle(fontWeight: FontWeight.normal)),
            onPressed: _saveBooking,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Display Customer Information in a non-editable mode using CustomFormRow
              CupertinoFormSection(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Informazioni cliente', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                    ProfileImage(prefix: widget.bookingDTO.customer!.prefix!,
                      phone: widget.bookingDTO.customer!.phone!,
                      branchCode: widget.bookingDTO.branchCode!,
                      avatarRadious: 30,
                    ),
                  ],
                ),
                children: [
                  CustomFormRow(
                    label: 'Nome',
                    controller: _firstNameController,
                    isEditable: true,
                  ),
                  CustomFormRow(
                    label: 'Cognome',
                    controller: _lastNameController,
                    isEditable: true,
                  ),
                  CustomFormRow(
                    label: 'Email',
                    controller: _emailCustomerController,
                    isEditable: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Prefisso', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
                        CupertinoButton(onPressed: (){
                          showCountryPicker(
                            context: context,
                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            exclude: <String>['KN', 'MF'],
                            favorite: <String>['IT'],
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              setState(() {
                                _prefixController.text = country.countryCode;
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
                          style:
                          TextStyle(fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[900]),)),
                      ],
                    ),
                  ),
                  CustomFormRow(
                    label: 'Cellulare',
                    controller: _phoneController,
                    isEditable: true,
                  ),
                  CustomFormRow(
                    label: 'Cap',
                    controller: _capController,
                    isEditable: true,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Data prenotazione'),
                    Row(
                      children: [
                        Text(italianDateFormat.format(_selectedNewDate!), style: TextStyle(fontSize: 14),),
                        IconButton(onPressed: (){

                          _selectDate(context, widget.bookingDTO.bookingDate!);

                        }, icon: Icon(CupertinoIcons.calendar_today)),
                      ],
                    )
                  ],
                ),
              ),

              Row(
                children: [
                  Text('Ora arrivo'),
                ],
              ),
              Wrap(
                children: generateTimeSlots(widget.restaurantDTO.daylyTimeWorkingRange!).map((time) {
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
              Wrap(
                children: generateTimeSlots(widget.restaurantDTO.nightTimeWorkingRange!).map((time) {
                  final isSelected = time == selectedTime;
                  return GestureDetector(
                    onTap: () => _onChipTap(time),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text(time),
                        backgroundColor: isSelected ? globalGold : elegantBlue.withOpacity(0.1),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              CustomFormRow(
                label: 'Prenotati',
                controller: _numGuestsController,
                placeholder: 'Enter number of guests',
                keyboardType: TextInputType.number,
              ),
              CustomFormRow(
                label: 'Note',
                controller: _specialRequestsController,
                placeholder: 'Enter special requests or notes',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context, DateTime currentDate) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(// Header background color
            hintColor:  Colors.blueGrey, // Header text color
            colorScheme: ColorScheme.light(
              primary:  Colors.blueGrey, // selection color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(Duration(days: 200)),
      lastDate: DateTime(2100),
      locale: const Locale('it', 'IT'),
    );
    if (picked != null) {
      final DateTime selectedDate = DateTime(picked.year, picked.month, picked.day, 10);
      setState(() {
        _selectedNewDate = selectedDate;
      });
      return selectedDate;
    } else {
      return DateTime.now();
    }
  }

  void _onChipTap(String time) {
    // Parse the time string to extract hour and minute
    DateTime parsedTime = DateFormat('H:mm').parse(time);
    setState(() {
      selectedTime = time;
      selectedHour = parsedTime.hour;
      selectedMinute = parsedTime.minute;
    });
  }
}
class CustomFormRow extends StatelessWidget {
  final String label;
  final String? value;
  final TextEditingController? controller;
  final bool isEditable;
  final TextInputType? keyboardType;
  final String? placeholder;

  CustomFormRow({
    required this.label,
    this.value,
    this.controller,
    this.isEditable = true,
    this.keyboardType,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      prefix: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),
      child: isEditable
          ? CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        keyboardType: keyboardType,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        textAlign: TextAlign.end,
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14,),
      )
          : Text(
        value ?? '',
        style: const TextStyle(color: CupertinoColors.inactiveGray, fontWeight: FontWeight.w300, fontSize: 14),
      ),
    );
  }
}