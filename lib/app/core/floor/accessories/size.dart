import 'dart:ui';

Size getTableSize(int partySize) {
  if (partySize <= 4) {
    return const Size(70, 70);
  } else if (partySize <= 7) {
    return const Size(100, 70);
  } else if (partySize <= 12) {
    return const Size(140, 70);
  } else if (partySize <= 16) {
    return const Size(180, 70);
  } else {
    return const Size(220, 70);
  }
}