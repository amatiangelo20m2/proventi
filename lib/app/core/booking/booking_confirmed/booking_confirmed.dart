import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proventi/app/core/booking/booking_refused/booking_refused_archive.dart';
import 'package:proventi/app/core/customer/customer_state_manager.dart';
import 'package:proventi/app/core/floor/accessories/floor_icon_button.dart';
import 'package:proventi/global/date_methods_utility.dart';
import 'package:provider/provider.dart';
import 'package:proventi/api/restaurant_client/lib/api.dart';
import 'package:proventi/app/core/booking/crud_widget/create_booking_confermato.dart';
import 'package:proventi/state_manager/restaurant_state_manager.dart';
import 'package:vibration/vibration.dart';
import '../../../../global/style.dart';
import 'automatic_book_manager/auto_booking_manager.dart';
import 'automatic_book_manager/range_time_selector.dart';
import 'confirmed_booking_card.dart';
import 'confirmedcard_extra/filter_booking_type.dart';
import 'confirmedcard_extra/linear_progressor.dart';
import 'confirmedcard_extra/filter_daily_type.dart';
import 'confirmedlist_extra/current_day_situation.dart';
import 'confirmedlist_extra/current_guest_situation.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();

  final List<DateTime> _days = List<DateTime>.generate(90, (index) => DateTime.now().subtract(const Duration(days: 1)).add(Duration(days: index)),);

  late ScrollController _scrollController;
  late ScrollController _scrollBookingsController;
  bool _isScrolledDown = false;

  bool isTodaySelected = true;
  bool _isSearchEnable = false;
  int? index = 0;
  String queryString = '';

  FilterDailyType filterDailyType = FilterDailyType.TUTTO_IL_GIORNO;
  FilterBookingType filterBookingType = FilterBookingType.TIME_SLOT;

  @override
  void initState() {

    super.initState();
    _selectedDate = widget.dateTime;
    _scrollController = ScrollController();
    _scrollBookingsController = ScrollController();
    _scrollBookingsController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollBookingsController.removeListener(_scrollListener);
    _scrollBookingsController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  void _scrollListener() {
    if (_scrollBookingsController.position.pixels > 20) {
      if (!_isScrolledDown) {
        setState(() {
          _isScrolledDown = true;
        });
      }
    } else {
      if (_isScrolledDown) {
        setState(() {
          _isScrolledDown = false;
        });
      }
    }
  }

  void _updateFilterDailyType(FilterDailyType newType) {
    setState(() {
      filterDailyType = newType;
    });
  }

  Future<void> _onDaySelected(DateTime day, RestaurantStateManager restaurantStateManager) async {
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
        selectedIndex * 90.0, // Adjust as needed based on your item width
        duration: const Duration(milliseconds: 200),
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
      msg: 'Prenotazioni del ${italianDateFormat.format(_selectedDate)}',
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
      color: Colors.white,
      child: Consumer<RestaurantStateManager>(
        builder: (BuildContext context,
            RestaurantStateManager restaurantManager, Widget? child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  if(!_isScrolledDown) Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AutoBookingManager(currentDate: _selectedDate),
                            RangeTimeSelector(onFilterDailyTypeChanged: _updateFilterDailyType, selectedDate: _selectedDate,),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onDoubleTap: () {
                                Vibration.vibrate(duration: 1000);
                                _scrollToToday(restaurantManager);
                              },
                              onTap: () {
                                _selectDate(context, _selectedDate, restaurantManager);
                              }, child: Icon(CupertinoIcons.calendar_today),

                            ),
                            IconButton(onPressed: (){
                              setState(() {
                                _isSearchEnable = !_isSearchEnable;
                              });
                            }, icon: Icon(CupertinoIcons.search)),
                            RefusedBookingArchive(dateTime: _selectedDate),

                            if(MediaQuery.of(context).size.shortestSide >= 600)
                              FloorIconButton(branchCode: restaurantManager.restaurantConfiguration!.branchCode!,
                                bookingList: restaurantManager.allBookings!
                                    .where((element) => isSameDay(element.bookingDate!, _selectedDate))
                                    .toList(), selectedDate: _selectedDate),

                          ],
                        ),
                      ],
                    ),
                  ),
                  if(!_isScrolledDown) SizedBox(
                    height: 75,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          final firstVisibleIndex = (scrollNotification.metrics.pixels / (scrollNotification.metrics.maxScrollExtent / (_days.length - 1))).floor();
                          if (firstVisibleIndex >= 0 &&
                              firstVisibleIndex < _days.length) {
                            final visibleDay = _days[firstVisibleIndex];
                            if (!_days.contains(_selectedDate)) {
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
                                  padding: const EdgeInsets.all(5.0),
                                  child: Material(
                                    shadowColor: Colors.grey,
                                    elevation: isSelected ? 1 : 3,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? blackDir
                                              : Colors.white,
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 7,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Text(
                                            '${day.day}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            months[day.month - 1].toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 5),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15, left: 15),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: LinearProgressWidget(restaurantManager,
                                                    day,
                                                    FilterDailyType.PRANZO)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15, left: 15, top: 2, bottom: 2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: LinearProgressWidget(restaurantManager,
                                                    day,
                                                    FilterDailyType.CENA)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                buildCurrentDaySituationWidget(
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
                  if(!_isScrolledDown && _isSearchEnable) Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            onChanged: (newQuery) {
                              setState(() {
                                queryString = newQuery;
                              });
                            },
                            clearButtonMode: OverlayVisibilityMode.always,
                            style: TextStyle(fontSize: 15, fontFamily: globalFontFamily),
                            placeholder: '🔎 Cerca per nome o cellulare',
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _showSortMenu(context);
                          },
                          icon: const Icon(CupertinoIcons.sort_down,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      List<BookingDTO>? filteredBooking = restaurantManager
                          .bookingFilteredByCurrentDate(_selectedDate)
                          .where((bookingDTO) => bookingDTO.status == BookingDTOStatusEnum.CONFERMATO
                          || bookingDTO.status == BookingDTOStatusEnum.MODIFICA_CONFERMATA
                          || bookingDTO.status == BookingDTOStatusEnum.MODIFICA_RIFIUTATA)
                          .where((bookingDTO) => bookingDTO.customer!.firstName!.toLowerCase().contains(queryString.toLowerCase()) || bookingDTO.customer!.phone!.toLowerCase().contains(queryString.toLowerCase()))
                          .where((bookingDTO) {
                        if (filterDailyType == FilterDailyType.PRANZO) {
                          return isLunchTime(bookingDTO, restaurantManager.restaurantConfiguration!);
                        } else if (filterDailyType == FilterDailyType.CENA) {
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
                          child: filteredBooking.isNotEmpty ? ListView.builder(
                            controller: _scrollBookingsController,
                            padding: EdgeInsets.only(bottom: filteredBooking.length > 5 ? 300 : 700),
                            itemCount: filteredBooking.length,
                            itemBuilder: (context, index) {
                              return BookingConfirmedCard(
                                booking: sortBookings(filteredBooking, filterBookingType)[index],
                                restaurantDTO: restaurantManager.restaurantConfiguration!,
                                forms: restaurantManager.currentBranchForms!,
                              );
                            },

                          ) :
                          SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10), // Ensure some spacing
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/lotties/nocalendar.json', height: 100),
                                    Text('Non ci sono prenotazioni ${filterDailyType == FilterDailyType.TUTTO_IL_GIORNO ? '' : 'per ${filterDailyType.name.toString().toLowerCase()}'}'
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CurrentGuestSituation(restaurantManager: restaurantManager,
                      selectedDate: _selectedDate,
                      filterDailyType: filterDailyType,),
                  ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        FloatingActionButton(
                          backgroundColor: blackDir,
                          child: const Icon(
                            CupertinoIcons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await Provider.of<CustomerStateManager>(context, listen: false).refreshHistory();

                            showCupertinoModalBottomSheet(
                              expand: true,
                              elevation: 10,
                              context: context,
                              builder: (BuildContext context) {
                                return CreateBooking(currentSelectedDate: _selectedDate);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }


  Widget _buildActionSheetAction({
    required BuildContext context,
    required String text,
    required FilterBookingType type,
    required String toastMessage,
  }) {
    return CupertinoActionSheetAction(
      onPressed: () {
        setState(() {
          filterBookingType = type;
        });
        Navigator.pop(context, type.toString());
        _showToast(toastMessage);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: filterBookingType == type ? blackDir : Colors.grey[900],
              fontFamily: globalFontFamily,
              fontSize: 12,
            ),
          ),
          Icon(
            filterBookingType == type
                ? CupertinoIcons.check_mark_circled_solid
                : CupertinoIcons.circle,
            color: filterBookingType == type ? blackDir : Colors.grey[900],
          ),
        ],
      ),
    );
  }
  void _showSortMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Ordina prenotazioni per', style: TextStyle(fontFamily: globalFontFamily),),
        actions: [
          _buildActionSheetAction(
            context: context,
            text: 'ORA ARRIVO',
            type: FilterBookingType.TIME_SLOT,
            toastMessage: 'Prenotazioni ordinate per ora di arrivo',
          ),
          _buildActionSheetAction(
            context: context,
            text: 'DATA INSERIMENTO',
            type: FilterBookingType.CREATED_AT,
            toastMessage: 'Prenotazioni ordinate per data di inserimento',
          ),
          _buildActionSheetAction(
            context: context,
            text: 'ORDINE ALFABETICO (A->Z)',
            type: FilterBookingType.NAME,
            toastMessage: 'Prenotazioni ordinate per nome cliente',
          ),
          _buildActionSheetAction(
            context: context,
            text: 'NUMERO COPERTI',
            type: FilterBookingType.GUESTS,
            toastMessage: 'Prenotazioni ordinate per numero coperti',
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, null); // Close without any action
          },
          isDefaultAction: true,
          child: Text('Indietro', style: TextStyle(fontFamily: globalFontFamily, fontSize: 12),),
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
  void _showToast(String text) {
    Fluttertoast.showToast(
      webShowClose: true,
      timeInSecForIosWeb: 1,
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: blackDir,
      textColor: Colors.white,
      fontSize: 15.0,
    );
  }
  List<BookingDTO> sortBookings(List<BookingDTO> bookings, FilterBookingType filterBookingType) {
    // Create a copy of the list to avoid modifying the original list
    List<BookingDTO> sortedBookings = List.from(bookings);

    sortedBookings.sort((a, b) {
      switch (filterBookingType) {
        case FilterBookingType.CREATED_AT:
        // Sort by createdAt, earliest to latest
          return a.createdAt!.compareTo(b.createdAt!);
        case FilterBookingType.GUESTS:
        // Sort by numGuests
          return a.numGuests!.compareTo(b.numGuests!);
        case FilterBookingType.NAME:
        // Sort by numGuests
          return a.customer!.lastName!.toLowerCase().compareTo(b.customer!.lastName!.toLowerCase());
        case FilterBookingType.TIME_SLOT:
        // Sort by timeSlot (hour and minute)
          if (a.timeSlot != null && b.timeSlot != null) {
            int hourComparison = a.timeSlot!.bookingHour!.compareTo(b.timeSlot!.bookingHour!);
            if (hourComparison != 0) {
              return hourComparison; // Compare hours
            }
            return a.timeSlot!.bookingMinutes!.compareTo(b.timeSlot!.bookingMinutes!); // Compare minutes
          } else if (a.timeSlot != null) {
            return -1; // a has timeSlot, b does not
          } else if (b.timeSlot != null) {
            return 1; // b has timeSlot, a does not
          }
          return 0; // Both have null timeSlot
        default:
          print('Invalid sortBy value: $filterBookingType');
          return 0;
      }
    });

    return sortedBookings;
  }

}
