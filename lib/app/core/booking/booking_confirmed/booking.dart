import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/global/date_methods_utility.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/booking/crud_widget/create_booking_confermato.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:vibration/vibration.dart';
import '../../../../global/style.dart';
import 'package:badges/badges.dart' as badges;
import 'booking_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  late List<DateTime> _days;
  late ScrollController _scrollController;

  bool isTodaySelected = true;
  bool isTomorrowSelected = false;

  List<BookingDTOStatusEnum> currentBookingStatus = [ BookingDTOStatusEnum.CONFERMATO];

  int? index = 0;
  bool confermato = true;
  bool daily = true;

  int? dailiyIndexInfininte = 0;

  String queryString = '';

  @override
  void initState() {
    super.initState();
    _generateDays();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _generateDays() {
    _days = List<DateTime>.generate(
      30,
      (index) => DateTime.now().subtract(Duration(days: 1))
          .add(Duration(days: index)),
    );
  }

  Future<void> _onDaySelected(
      DateTime day, RestaurantStateManager restaurantStateManager) async {
    final today = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    setState(() {
      _selectedDate = day;
      isTodaySelected = day.day == today.day &&
          day.month == today.month &&
          day.year == today.year;

      isTomorrowSelected = day.day == tomorrow.day &&
          day.month == tomorrow.month &&
          day.year == tomorrow.year;

      _scrollToSelectedDay();
    });

    Fluttertoast.showToast(
      webShowClose: true,
      timeInSecForIosWeb: 1,
      msg: 'Prenotazioni di ${italianDateFormat.format(_selectedDate)}',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  void _scrollToSelectedDay() {
    final selectedIndex =
        _days.indexWhere((day) => day.isAtSameMomentAs(_selectedDate));
    if (selectedIndex != -1) {
      _scrollController.animateTo(
        selectedIndex * 60.0, // Adjust as needed based on your item width
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
  void _scrollToToday(RestaurantStateManager restaurantManager) {
    final todayIndex = _days.indexWhere((day) =>
        day.day == DateTime.now().day &&
        day.month == DateTime.now().month &&
        day.year == DateTime.now().year);
    if (todayIndex != -1) {
      setState(() {
        _selectedDate = _days[todayIndex];
        isTodaySelected = true;
        isTomorrowSelected = false;
        _scrollToSelectedDay();
        _onDaySelected(_selectedDate, restaurantManager);
      });
    }

    Fluttertoast.showToast(
      webShowClose: true,
      timeInSecForIosWeb: 6,
      msg: 'Prenotazioni del ' + italianDateFormat.format(_selectedDate),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }
  void _scrollToTomorrow(RestaurantStateManager restaurantManager) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowIndex = _days.indexWhere((day) =>
        day.day == tomorrow.day &&
        day.month == tomorrow.month &&
        day.year == tomorrow.year);
    if (tomorrowIndex != -1) {
      setState(() {
        _selectedDate = _days[tomorrowIndex];
        isTodaySelected = false;
        isTomorrowSelected = true;
        _scrollToSelectedDay();
        _onDaySelected(_selectedDate, restaurantManager);
      });
    }

    Fluttertoast.showToast(
      webShowClose: true,
      timeInSecForIosWeb: 6,
      msg: 'Prenotazioni data ' + italianDateFormat.format(_selectedDate),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }
  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<RestaurantStateManager>(
        builder: (BuildContext context, RestaurantStateManager restaurantManager,
            Widget? child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 3),
                      child: CupertinoTextField(
                        onChanged: (newQuery){
                          setState(() {
                            queryString = newQuery;
                          });
                        },
                        clearButtonMode: OverlayVisibilityMode.always,
                        style: TextStyle(fontSize: 16),
                        placeholder:
                        'Ricerca per nome o cellulare',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 3,),

                          FlutterSwitch(
                            width: 90.0,
                            height: 35.0,
                            valueFontSize: 5.0,
                            toggleSize: 30.0,
                            value: confermato,
                            activeColor: elegantGreen,
                            activeText: 'CONFERMATE',
                            inactiveText: 'RIFIUTATE',
                            activeIcon: Icon(Icons.check_circle, color: elegantGreen),
                            inactiveIcon: Icon(CupertinoIcons.clear_circled_solid, color: elegantRed),
                            inactiveColor: elegantRed,
                            borderRadius: 25.0,
                            padding: 1.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                confermato = !confermato;
                                if(confermato){
                                  currentBookingStatus =
                                      [BookingDTOStatusEnum.CONFERMATO];
                                  Fluttertoast.showToast(
                                      msg: 'Prenotazioni in stato ${currentBookingStatus}',
                                      backgroundColor: elegantGreen,
                                  );
                                }else{
                                  currentBookingStatus = [
                                      BookingDTOStatusEnum.RIFIUTATO ];
                                  Fluttertoast.showToast(
                                      backgroundColor: elegantRed,
                                      msg:
                                      'Prenotazioni in stato ${currentBookingStatus}');
                                }
                              });
                            },
                          ),

                        ],
                      ),

                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Vibration.vibrate(duration: 1000);
                              _scrollToToday(restaurantManager);
                            },
                            child: Text(
                              'Oggi',
                              style: TextStyle(
                                fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isTodaySelected
                                      ? globalGold
                                      : Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Vibration.vibrate(duration: 1000);
                              _scrollToTomorrow(restaurantManager);
                            },
                            child: Text(
                              'Domani',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: isTomorrowSelected
                                      ? globalGold
                                      : Colors.grey),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _selectDate(
                                    context, _selectedDate, restaurantManager);
                                // _pickDateRange(context);
                              },
                              icon: const Icon(CupertinoIcons.calendar,
                                  color: Colors.blueGrey)),

                          //IconButton(
                          //    onPressed: () {
                          //      _showSortMenu(context);
                          //    },
                          //    icon: const Icon(CupertinoIcons.sort_down,
                          //        color: Colors.blueGrey)),
                          //IconButton(
                          //    onPressed: () {
                          //      setState(() {
                          //        _searchField = !_searchField;
                          //      });
                          //    },
                          //    icon: const Icon(CupertinoIcons.search)
                          //),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 2, top: 2, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${italianDateFormat.format(_selectedDate)}'
                              .toUpperCase(),
                          style: TextStyle(fontSize: 12, color: globalGoldDark,),
                        ),
                        Row(
                          children: [
                            Text(restaurantManager
                                .retrieveTotalGuestsNumberForDayAndActiveBookings(
                                _selectedDate), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: globalGoldDark),),
                            Text(
                                ' / ${restaurantManager
                                    .restaurantConfiguration!.capacity}  ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),

                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,

                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          final firstVisibleIndex = (scrollNotification
                                      .metrics.pixels /
                                  (scrollNotification.metrics.maxScrollExtent /
                                      (_days.length - 1)))
                              .floor();
                          if (firstVisibleIndex >= 0 &&
                              firstVisibleIndex < _days.length) {
                            final visibleDay = _days[firstVisibleIndex];
                            // Check if the selected date is outside the visible range
                            if (!_days.contains(_selectedDate)) {
                              // Only update _selectedDate if the user taps on a different day
                              setState(() {
                                _selectedDate = visibleDay;
                              });
                            }
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _days.length,
                        itemBuilder: (context, index) {
                          final day = _days[index];
                          final isSelected = _selectedDate.day == day.day &&
                              _selectedDate.month == day.month &&
                              _selectedDate.year == day.year;
                          return GestureDetector(
                            onTap: () => _onDaySelected(day, restaurantManager),
                            child: Container(
                              width: 110,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? globalGold
                                    : Colors.grey[100],

                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    capitalizeFirstLetter(DateFormat.E('it')
                                            .format(day)
                                            .substring(0, 3))
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    '${day.day}.${day.month}',
                                    style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 12),
                                  ),
                                  _buildCurrentDaySituationWidget(
                                      restaurantManager.allBookings!
                                          .where((element) => isSameDay(
                                              element.bookingDate!, day))
                                          .toList(),
                                      isSelected),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),


                  dailiyIndexInfininte == 0 ? Expanded(
                    flex: 5,
                    child: RefreshIndicator(
                    onRefresh: () async {
                    await restaurantManager.refresh(_selectedDate);
                    },
                    child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 160),
                    itemCount: restaurantManager.bookingFilteredByCurrentDate(_selectedDate)
                        .where((bookingDTO) => currentBookingStatus.contains(bookingDTO.status))
                        .where((element) => element.customer!.firstName!.toLowerCase().contains(queryString.toLowerCase())
                        || element.customer!.phone!.toLowerCase().contains(queryString.toLowerCase())).length,

          itemBuilder: (context, index) {

          return ReservationCard(
          booking: restaurantManager.bookingFilteredByCurrentDate(_selectedDate)
              .where((booking) =>
          currentBookingStatus.contains(booking.status)).where((element) => element.customer!.firstName!.toLowerCase().contains(queryString.toLowerCase())
              || element.customer!.phone!.toLowerCase().contains(queryString.toLowerCase()))
              .toList()[index],
          formDTOs: restaurantManager.currentBranchForms!,
          restaurantDTO: restaurantManager.restaurantConfiguration!, shadeColor: globalGoldDark,);

          },
          ),
          ),
          ) : Expanded(
                    flex: 5,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await restaurantManager.refresh(_selectedDate);
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 160),
                        itemCount: restaurantManager.bookingFilteredByCurrentDate(_selectedDate)
                            .where((bookingDTO) => currentBookingStatus.contains(bookingDTO.status)
                            && (isLunchTime(bookingDTO, restaurantManager.restaurantConfiguration!) == daily)).length,

                        itemBuilder: (context, index) {

                          return ReservationCard(
                              booking: restaurantManager.bookingFilteredByCurrentDate(_selectedDate)
                                  .where((booking) =>
                                  currentBookingStatus.contains(booking.status) && (isLunchTime(booking, restaurantManager.restaurantConfiguration!) == daily) )
                                  .toList()[index],
                              formDTOs: restaurantManager.currentBranchForms!,
                            restaurantDTO: restaurantManager.restaurantConfiguration!, shadeColor: globalGoldDark,);

                          },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: FloatingActionButton(
                      backgroundColor: globalGold,
                      child: const Icon(
                        CupertinoIcons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                          expand: true,

                          elevation: 10,
                          context: context,
                          builder: (BuildContext context) {
                            return const CreateBookingStatusConfirmed();
                          },
                        );
                      },
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }

  void _showSortMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Ordina prenotazioni per'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'arrival_time');
              print("Sorting by arrival time");
            },
            child: const Text('Ordina per ora arrivo'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'booking_date');
              print("Sorting by booking date");
            },
            child: const Text('Ordina per data prenotazione'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'name');
              print("Sorting by name");
            },
            child: const Text('Ordina per nome'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'status');
              print("Sorting by status");
            },
            child: const Text('Ordina per stato prenotazione'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, null); // Close without any action
          },
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context, DateTime currentDate,
      RestaurantStateManager restaurantStateManager) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Header background color
            hintColor: Colors.blueGrey, // Header text color
            colorScheme: const ColorScheme.light(
              primary: Colors.blueGrey, // selection color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(const Duration(days: 200)),
      lastDate: DateTime(2100),
      locale: const Locale('it', 'IT'),
    );
    if (picked != null) {
      final DateTime selectedDate =
          DateTime(picked.year, picked.month, picked.day, 10);
      setState(() {
        _selectedDate = selectedDate;
        _onDaySelected(_selectedDate, restaurantStateManager);
      });
      return selectedDate;
    } else {
      return DateTime.now();
    }
  }

  _buildCurrentDaySituationWidget(List<BookingDTO> list, bool isSelected) {
    int tables = list
        .where((element) => element.status == BookingDTOStatusEnum.CONFERMATO)
        .length;
    int currentGuestNumber = (list
        .where((element) => element.status == BookingDTOStatusEnum.CONFERMATO)
        .fold(0, (total, booking) => total + (booking.numGuests ?? 0)));
    int refused = list
        .where((element) => element.status == BookingDTOStatusEnum.RIFIUTATO)
        .length;

    if(tables == 0 && refused == 0 && currentGuestNumber == 0){
      return SizedBox(height: 0,);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          if(currentGuestNumber> 0) Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: elegantBlue,
                shape: BoxShape.circle, // Makes the container circular
              ),

              child: Column(
                children: [
                  const Icon(Icons.people_outline, size: 15, color: CupertinoColors.white,),
                  Text(
                    currentGuestNumber.toString(),
                    style: const TextStyle(fontSize: 10, color: CupertinoColors.white),
                  ),
                ],
              ),
            ),
          ),
          if(tables > 0) Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: elegantGreen,
                shape: BoxShape.circle, // Makes the container circular
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.table_restaurant, size: 15, color: CupertinoColors.white,),
                  Text(
                    tables.toString().toString(),
                    style: const TextStyle(fontSize: 10, color: CupertinoColors.white),
                  ),
                ],
              ),
            ),
          ),
          if (refused > 0) Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: elegantRed,
                shape: BoxShape.circle, // Makes the container circular
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.clear_circled, size: 15, color: CupertinoColors.white,),
                  Text(
                    refused.toString(),
                    style: const TextStyle(fontSize: 10, color: CupertinoColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
