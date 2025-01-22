//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomerHistoryDTO {
  /// Returns a new [CustomerHistoryDTO] instance.
  CustomerHistoryDTO({
    this.customerDTO,
    this.historicalBookingsNumber,
    this.historicalArrivedNumber,
    this.historicalNoShowsNumber,
    this.historicalRefusedNumber,
    this.historicalCancellationsNumber,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CustomerDTO? customerDTO;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? historicalBookingsNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? historicalArrivedNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? historicalNoShowsNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? historicalRefusedNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? historicalCancellationsNumber;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomerHistoryDTO &&
    other.customerDTO == customerDTO &&
    other.historicalBookingsNumber == historicalBookingsNumber &&
    other.historicalArrivedNumber == historicalArrivedNumber &&
    other.historicalNoShowsNumber == historicalNoShowsNumber &&
    other.historicalRefusedNumber == historicalRefusedNumber &&
    other.historicalCancellationsNumber == historicalCancellationsNumber;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (customerDTO == null ? 0 : customerDTO!.hashCode) +
    (historicalBookingsNumber == null ? 0 : historicalBookingsNumber!.hashCode) +
    (historicalArrivedNumber == null ? 0 : historicalArrivedNumber!.hashCode) +
    (historicalNoShowsNumber == null ? 0 : historicalNoShowsNumber!.hashCode) +
    (historicalRefusedNumber == null ? 0 : historicalRefusedNumber!.hashCode) +
    (historicalCancellationsNumber == null ? 0 : historicalCancellationsNumber!.hashCode);

  @override
  String toString() => 'CustomerHistoryDTO[customerDTO=$customerDTO, historicalBookingsNumber=$historicalBookingsNumber, historicalArrivedNumber=$historicalArrivedNumber, historicalNoShowsNumber=$historicalNoShowsNumber, historicalRefusedNumber=$historicalRefusedNumber, historicalCancellationsNumber=$historicalCancellationsNumber]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.customerDTO != null) {
      json[r'customerDTO'] = this.customerDTO;
    } else {
      json[r'customerDTO'] = null;
    }
    if (this.historicalBookingsNumber != null) {
      json[r'historicalBookingsNumber'] = this.historicalBookingsNumber;
    } else {
      json[r'historicalBookingsNumber'] = null;
    }
    if (this.historicalArrivedNumber != null) {
      json[r'historicalArrivedNumber'] = this.historicalArrivedNumber;
    } else {
      json[r'historicalArrivedNumber'] = null;
    }
    if (this.historicalNoShowsNumber != null) {
      json[r'historicalNoShowsNumber'] = this.historicalNoShowsNumber;
    } else {
      json[r'historicalNoShowsNumber'] = null;
    }
    if (this.historicalRefusedNumber != null) {
      json[r'historicalRefusedNumber'] = this.historicalRefusedNumber;
    } else {
      json[r'historicalRefusedNumber'] = null;
    }
    if (this.historicalCancellationsNumber != null) {
      json[r'historicalCancellationsNumber'] = this.historicalCancellationsNumber;
    } else {
      json[r'historicalCancellationsNumber'] = null;
    }
    return json;
  }

  /// Returns a new [CustomerHistoryDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomerHistoryDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomerHistoryDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomerHistoryDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomerHistoryDTO(
        customerDTO: CustomerDTO.fromJson(json[r'customerDTO']),
        historicalBookingsNumber: mapValueOfType<int>(json, r'historicalBookingsNumber'),
        historicalArrivedNumber: mapValueOfType<int>(json, r'historicalArrivedNumber'),
        historicalNoShowsNumber: mapValueOfType<int>(json, r'historicalNoShowsNumber'),
        historicalRefusedNumber: mapValueOfType<int>(json, r'historicalRefusedNumber'),
        historicalCancellationsNumber: mapValueOfType<int>(json, r'historicalCancellationsNumber'),
      );
    }
    return null;
  }

  static List<CustomerHistoryDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerHistoryDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerHistoryDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomerHistoryDTO> mapFromJson(dynamic json) {
    final map = <String, CustomerHistoryDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomerHistoryDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomerHistoryDTO-objects as value to a dart map
  static Map<String, List<CustomerHistoryDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomerHistoryDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomerHistoryDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

