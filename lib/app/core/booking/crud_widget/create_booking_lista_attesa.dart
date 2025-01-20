import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';

import 'package:proventi/api/restaurant_client/lib/api.dart';

import '../../../../global/style.dart';

class CreateBookingListAttesa extends StatefulWidget {

  @override
  _CreateBookingListAttesaState createState() => _CreateBookingListAttesaState();
}

class _CreateBookingListAttesaState extends State<CreateBookingListAttesa> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _guests = TextEditingController();

  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _minutesToWait = TextEditingController();
  final TextEditingController _specialRequests = TextEditingController();

  Country _currentSelectedCountry = Country.parse('IT');

  final FocusNode _minutesFocusNode = FocusNode();
  int _waitingMinutes = 0;
  String searchQuery = '';

  void _showWaitingTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: Container(
            height: 300,
            color: CupertinoColors.systemBackground,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Seleziona il tempo di attesa', style: TextStyle(fontSize: 10, color: elegantBlue),),
                ),
                CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(minutes: _waitingMinutes),
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      _minutesToWait.text = convertMinutesToHMMFormat(newDuration.inMinutes);
                      _waitingMinutes = newDuration.inMinutes;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  String convertMinutesToHMMFormat(int minutes) {
    int hours = minutes ~/ 60; // Integer division to get the number of hours
    int remainingMinutes = minutes % 60; // Get the remainder for minutes

    if(hours > 0){
      return 'Attesa di ${hours} ore e ${remainingMinutes.toString().padLeft(2, '0')} minuti';
    }else{
      return 'Attesa di ${remainingMinutes.toString().padLeft(2, '0')} minuti';
    }

  }
  CustomerDTO customerDTO = CustomerDTO();
  List<CustomerDTO> currentCustomerDTOList = [];

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


  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (BuildContext context, RestaurantStateManager restaurantStateManager, Widget? child) {
        return CupertinoPageScaffold(

          navigationBar: CupertinoNavigationBar(
            leading: const Text(''),
            middle: const Text("Inserisci cliente in lista d\'attesa"),
            trailing: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(CupertinoIcons.clear),
            ),
          ),
          child: Stack(
            children: [
              Padding(
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
                                      for (var element in customerStateManager.historicalCustomerData!) {
                                        if(element.customerDTO!.phone!.contains(typingNumber)){
                                          currentCustomerDTOList.add(element.customerDTO!);
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
                      style: const TextStyle(fontSize: 13),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 13),
                      controller: _lastNameController,
                      placeholder: "Cognome",
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      controller: _emailController,
                      placeholder: "Email",
                      style: const TextStyle(fontSize: 13),
                      keyboardType: TextInputType.emailAddress,
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      style: const TextStyle(fontSize: 13),
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      controller: _guests,
                      placeholder: "Ospiti",
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      controller: _minutesToWait,
                      focusNode: _minutesFocusNode, // Attach the focus node here
                      placeholder: "Tempo di attesa",
                      style: const TextStyle(fontSize: 13),
                      keyboardType: TextInputType.none, // Prevent the keyboard from opening
                      onTap: () {
                        _showWaitingTimePicker(context); // Show the time picker on tap
                      },
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      controller: _specialRequests,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 13),
                      placeholder: "Richieste particolari e info",
                      keyboardType: TextInputType.text,
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton.filled(
                      child: const Text("Crea"),
                      onPressed: () async {
                        // Call your API method to create the booking with the waiting time in minutes
                        BookingDTO? bookingDTO = await restaurantStateManager.bookingControllerApi.create(BookingDTO(
                          bookingId: 0,
                          formCode: '',
                          branchName: restaurantStateManager.restaurantConfiguration!.restaurantName!,
                          branchCode: restaurantStateManager.restaurantConfiguration!.branchCode!,
                          bookingCode: '',
                          bookingDate: DateTime.now(),
                          timeSlot: TimeSlot(
                            bookingHour: DateTime.now().hour,
                            bookingMinutes: DateTime.now().minute + 1,
                          ),
                          numGuests: double.parse(_guests.text).toInt(),
                          status: BookingDTOStatusEnum.LISTA_ATTESA,
                          specialRequests: _specialRequests.text,
                          customer: CustomerDTO(
                              firstName: _nameController.text,
                              lastName: _lastNameController.text,
                              phone: _phoneController.text,
                              prefix: _currentSelectedCountry.phoneCode,
                              email: _emailController.text
                          ),
                          createdAt: DateTime.now(),
                          timeWaitingFastQueueMinutes: _waitingMinutes, // Use the selected waiting minutes
                          bookingSource: BookingDTOBookingSourceEnum.APP,
                          comingWithDogs: false,
                          timeSlotAfterUpdate: TimeSlot(
                            bookingHour: 0,
                            bookingMinutes: 0,
                          ),
                          numGuestsAfterUpdate: 0,
                          bookingDateAfterUpdate: DateTime.now(),
                        ));

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
            ],
          ),
        );
      },
    );
  }
}
