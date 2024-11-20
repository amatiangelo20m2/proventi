
import '../api/restaurant_client/lib/api.dart';

List<BookingDTO> getBookingListFilteredByStatus(List<BookingDTO> list, BookingDTOStatusEnum bookingStatus){
  return list
      .where((element) => element.status == bookingStatus).toList();
}