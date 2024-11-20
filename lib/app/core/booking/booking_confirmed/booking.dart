import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_refused/booking_refused_archive.dart';
import 'package:proventi/global/date_methods_utility.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/booking/crud_widget/create_booking_confermato.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:vibration/vibration.dart';
import '../../../../global/bookings_utils.dart';
import '../../../../global/style.dart';
import 'package:badges/badges.dart' as badges;
import '../../../custom_widgets/appinio_animated_toggle_tab.dart';
import 'confirmed_booking_card.dart';
import 'filter_daily_type.dart';

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
  int? index = 0;
  String queryString = '';

  FilterDailyType filterDailyType = FilterDailyType.ALL_DAY;

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
      90,
      (index) =>
          DateTime.now().subtract(Duration(days: 1)).add(Duration(days: index)),
    );
  }
  Future<void> _onDaySelected(
      DateTime day, RestaurantStateManager restaurantStateManager) async {
    final today = DateTime.now();

    setState(() {
      _selectedDate = day;
      isTodaySelected = day.day == today.day &&
          day.month == today.month &&
          day.year == today.year;
      _scrollToSelectedDay();
    });
    //await restaurantStateManager.refresh(_selectedDate);
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
        selectedIndex * 80.0, // Adjust as needed based on your item width
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: Consumer<RestaurantStateManager>(
        builder: (BuildContext context,
            RestaurantStateManager restaurantManager, Widget? child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 0),
                      child: CupertinoTextField(
                        onChanged: (newQuery) {
                          setState(() {
                            queryString = newQuery;
                          });
                        },
                        clearButtonMode: OverlayVisibilityMode.always,
                        style: TextStyle(fontSize: 16),
                        placeholder: '🔎 Ricerca per nome o cellulare',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SwitchPro20(
                          callback: (int i) {
                            switch(i){
                              case 0:
                                setState(() {
                                  filterDailyType = FilterDailyType.ALL_DAY;
                                });
                              Fluttertoast.showToast(
                                  msg: "Prenotazioni di tutta la giornata",
                                  backgroundColor: globalGoldDark,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1);

                              break;
                              case 1:
                                setState(() {
                                  filterDailyType = FilterDailyType.LUNCH;
                                });
                                Fluttertoast.showToast(
                                    msg: "Prenotazioni pranzo",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: globalGold,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);

                                break;
                              case 2:
                                setState(() {
                                  filterDailyType = FilterDailyType.DINNER;
                                });
                                Fluttertoast.showToast(
                                    msg: "Prenotazioni cena",
                                    backgroundColor: elegantBlue,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);
                                break;
                            }
                          },
                          tabTexts: [
                            badges.Badge(
                                badgeStyle: badges.BadgeStyle(badgeColor: Colors.grey.shade800),
                                badgeContent: Text(restaurantManager
                                    .retrieveTotalGuestsNumberForDayAndActiveBookings(_selectedDate).toString(), style: TextStyle(fontSize: 10, color: CupertinoColors.white),),
                                badgeAnimation: const badges.BadgeAnimation.rotation(),
                                child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(CupertinoIcons.infinite, size: 25,)
                                )),
                            badges.Badge(
                                badgeStyle: badges.BadgeStyle(badgeColor: globalGold),
                                badgeContent: Text(restaurantManager
                                    .retrieveTotalGuestsNumberForDayAndActiveBookingsLunchTime(_selectedDate, restaurantManager.restaurantConfiguration!).toString(),
                                  style: TextStyle(fontSize: 10, color: CupertinoColors.white),),
                                badgeAnimation: badges.BadgeAnimation.rotation(),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(CupertinoIcons.sun_max, size: 25, color: globalGoldDark,)
                                )),
                            badges.Badge(
                                badgeStyle: badges.BadgeStyle(badgeColor: elegantBlue),
                                badgeContent: Text(restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsDinnerTime(_selectedDate, restaurantManager.restaurantConfiguration!).toString(), style: TextStyle(fontSize: 10, color: CupertinoColors.white),),
                                badgeAnimation: badges.BadgeAnimation.rotation(),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(CupertinoIcons.moon_stars, color: elegantBlue, size: 25,)
                                )),
                          ],
                          height: 40,
                          width: 130,
                          boxDecoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          animatedBoxDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          activeStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          inactiveStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Vibration.vibrate(duration: 1000);
                                _scrollToToday(restaurantManager);
                              },
                              child: Text(
                                'OGGI',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: isTodaySelected
                                        ? globalGoldDark
                                        : Colors.grey),
                              ),
                            ),

                            IconButton(
                                onPressed: () {

                                  _selectDate(context, _selectedDate, restaurantManager);
                                  // _pickDateRange(context);
                                },
                                icon: const Icon(CupertinoIcons.calendar,
                                    color: Colors.blueGrey)),
                            IconButton(
                                onPressed: () {
                                  _showSortMenu(context);
                                },
                                icon: const Icon(CupertinoIcons.sort_down,
                                    color: Colors.blueGrey)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 98,
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
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    elevation: isSelected ? 2 : 5,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: 95,

                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? globalGold
                                              : Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat.E('it')
                                                .format(day)
                                                .substring(0, 3)
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Text(
                                            '${day.day}',
                                            style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            months[day.month - 1].toUpperCase(),
                                            style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 10),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15, left: 15),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: LinearProgressWidget(restaurantManager,
                                                  day,
                                                  FilterDailyType.LUNCH)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15, left: 15, top: 2, bottom: 2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: LinearProgressWidget(restaurantManager, day, FilterDailyType.DINNER)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                _buildCurrentDaySituationWidget(
                                    restaurantManager.allBookings!
                                        .where((element) => isSameDay(
                                            element.bookingDate!, day))
                                        .toList(),
                                    isSelected),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            Text(restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookings(_selectedDate).toString(), style: TextStyle(fontSize: 18, color: globalGoldDark),),
                            Text('/${restaurantManager.restaurantConfiguration!.capacity}  ', style: TextStyle(fontSize: 13, color: Colors.grey.shade900),),
                            Icon(CupertinoIcons.person_2_fill, size: 25, color: Colors.grey.shade900,),
                          ],
                        ),
                      ),
                      RefusedBookingArchive(bookingList:
                      restaurantManager.allBookings!.where((element) => isSameDay(
                        element.bookingDate!, _selectedDate)).toList(), dateTime: _selectedDate,)
                    ],
                  ),
                  Builder(
                    builder: (context) {

                      List<BookingDTO>? filteredBooking = restaurantManager
                          .bookingFilteredByCurrentDate(_selectedDate)
                          .where((bookingDTO) => bookingDTO.status == BookingDTOStatusEnum.CONFERMATO)
                          .where((bookingDTO) => bookingDTO.customer!.firstName!.toLowerCase().contains(queryString.toLowerCase()) || bookingDTO.customer!.phone!.toLowerCase().contains(queryString.toLowerCase()))
                          .where((bookingDTO) {
                        if (filterDailyType == FilterDailyType.LUNCH) {
                          return isLunchTime(bookingDTO, restaurantManager.restaurantConfiguration!);
                        } else if (filterDailyType == FilterDailyType.DINNER) {
                          return !isLunchTime(bookingDTO, restaurantManager.restaurantConfiguration!);
                        } else {
                          // No filtering if `filterDailyType` is neither LUNCH nor DINNER
                          return true;
                        }
                      }).toList();

                      return Expanded(
                        flex: 5,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await restaurantManager.refresh(_selectedDate);
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 160),
                            itemCount: filteredBooking.length,
                            itemBuilder: (context, index) {
                              return ReservationCard(
                                booking: filteredBooking[index],
                                formDTOs: restaurantManager.currentBranchForms!,
                                restaurantDTO:
                                    restaurantManager.restaurantConfiguration!,
                                shadeColor: globalGoldDark,
                              );
                            },
                          ),
                        ),
                      );
                    }
                  )
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
            child: const Text('Ordina per nome cliente (A->Z)'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'status');
              print("Sorting by status");
            },
            child: const Text('Ordina per numero coperti'),
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
    int bookings = getBookingListFilteredByStatus(list, BookingDTOStatusEnum.CONFERMATO).length;

    int refused = getBookingListFilteredByStatus(list, BookingDTOStatusEnum.RIFIUTATO).length;

    if (bookings == 0 && refused == 0) {
      return SizedBox(
        height: 0,
      );
    }
    return Positioned(
        right: 0,
        child: Column(
          children: [
            if (bookings > 0)
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(
                      5), // Half of width/height for a circular effect
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.book,
                          size: 13, // Set the size of the icon
                          color: Colors.white),
                      Text(
                        ' ' +
                            bookings
                                .toString(), // Text to display inside the circle
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 2,
            ),
            if(refused > 0) Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(
                    5), // Half of width/height for a circular effect
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.clear_circled,
                        size: 13, // Set the size of the icon
                        color: Colors.white),
                    Text(
                      ' $refused', // Text to display inside the circle
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  LinearProgressWidget(RestaurantStateManager restaurantManager, DateTime day, FilterDailyType filterDailyType) {

    if(restaurantManager.restaurantConfiguration!.capacity! == 0){
      return SizedBox(height: 0,);
    }
    int pax = 0;
    if(filterDailyType == FilterDailyType.LUNCH){
      pax = restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsLunchTime(day, restaurantManager.restaurantConfiguration!);
    }else if(filterDailyType == FilterDailyType.DINNER){
      pax = restaurantManager.retrieveTotalGuestsNumberForDayAndActiveBookingsDinnerTime(day, restaurantManager.restaurantConfiguration!);
    }

    double currentProgressValue = pax
        / restaurantManager.restaurantConfiguration!.capacity!;

    return LinearProgressIndicator(
      color: currentProgressValue > 1 ? Colors.redAccent : filterDailyType == FilterDailyType.LUNCH ? globalGoldDark : elegantBlue,
      value: currentProgressValue,
    );
  }
}
