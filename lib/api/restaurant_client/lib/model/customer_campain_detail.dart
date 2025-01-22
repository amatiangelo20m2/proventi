//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomerCampainDetail {
  /// Returns a new [CustomerCampainDetail] instance.
  CustomerCampainDetail({
    this.customerId,
    this.customerFirstName,
    this.customerLastName,
    this.email,
    this.prefix,
    this.phoneNumber,
    this.message,
    this.error,
    this.messageChannel,
    this.outcomeSms,
    this.outcomeWhatsapp,
    this.outcomeEmail,
    this.localDateTime,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? customerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? customerFirstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? customerLastName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? prefix;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? phoneNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? error;

  CustomerCampainDetailMessageChannelEnum? messageChannel;

  CustomerCampainDetailOutcomeSmsEnum? outcomeSms;

  CustomerCampainDetailOutcomeWhatsappEnum? outcomeWhatsapp;

  CustomerCampainDetailOutcomeEmailEnum? outcomeEmail;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? localDateTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomerCampainDetail &&
    other.customerId == customerId &&
    other.customerFirstName == customerFirstName &&
    other.customerLastName == customerLastName &&
    other.email == email &&
    other.prefix == prefix &&
    other.phoneNumber == phoneNumber &&
    other.message == message &&
    other.error == error &&
    other.messageChannel == messageChannel &&
    other.outcomeSms == outcomeSms &&
    other.outcomeWhatsapp == outcomeWhatsapp &&
    other.outcomeEmail == outcomeEmail &&
    other.localDateTime == localDateTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (customerId == null ? 0 : customerId!.hashCode) +
    (customerFirstName == null ? 0 : customerFirstName!.hashCode) +
    (customerLastName == null ? 0 : customerLastName!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (prefix == null ? 0 : prefix!.hashCode) +
    (phoneNumber == null ? 0 : phoneNumber!.hashCode) +
    (message == null ? 0 : message!.hashCode) +
    (error == null ? 0 : error!.hashCode) +
    (messageChannel == null ? 0 : messageChannel!.hashCode) +
    (outcomeSms == null ? 0 : outcomeSms!.hashCode) +
    (outcomeWhatsapp == null ? 0 : outcomeWhatsapp!.hashCode) +
    (outcomeEmail == null ? 0 : outcomeEmail!.hashCode) +
    (localDateTime == null ? 0 : localDateTime!.hashCode);

  @override
  String toString() => 'CustomerCampainDetail[customerId=$customerId, customerFirstName=$customerFirstName, customerLastName=$customerLastName, email=$email, prefix=$prefix, phoneNumber=$phoneNumber, message=$message, error=$error, messageChannel=$messageChannel, outcomeSms=$outcomeSms, outcomeWhatsapp=$outcomeWhatsapp, outcomeEmail=$outcomeEmail, localDateTime=$localDateTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.customerId != null) {
      json[r'customerId'] = this.customerId;
    } else {
      json[r'customerId'] = null;
    }
    if (this.customerFirstName != null) {
      json[r'customerFirstName'] = this.customerFirstName;
    } else {
      json[r'customerFirstName'] = null;
    }
    if (this.customerLastName != null) {
      json[r'customerLastName'] = this.customerLastName;
    } else {
      json[r'customerLastName'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.prefix != null) {
      json[r'prefix'] = this.prefix;
    } else {
      json[r'prefix'] = null;
    }
    if (this.phoneNumber != null) {
      json[r'phoneNumber'] = this.phoneNumber;
    } else {
      json[r'phoneNumber'] = null;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    } else {
      json[r'message'] = null;
    }
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
    if (this.messageChannel != null) {
      json[r'messageChannel'] = this.messageChannel;
    } else {
      json[r'messageChannel'] = null;
    }
    if (this.outcomeSms != null) {
      json[r'outcomeSms'] = this.outcomeSms;
    } else {
      json[r'outcomeSms'] = null;
    }
    if (this.outcomeWhatsapp != null) {
      json[r'outcomeWhatsapp'] = this.outcomeWhatsapp;
    } else {
      json[r'outcomeWhatsapp'] = null;
    }
    if (this.outcomeEmail != null) {
      json[r'outcomeEmail'] = this.outcomeEmail;
    } else {
      json[r'outcomeEmail'] = null;
    }
    if (this.localDateTime != null) {
      json[r'localDateTime'] = this.localDateTime!.toUtc().toIso8601String();
    } else {
      json[r'localDateTime'] = null;
    }
    return json;
  }

  /// Returns a new [CustomerCampainDetail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomerCampainDetail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomerCampainDetail[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomerCampainDetail[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomerCampainDetail(
        customerId: mapValueOfType<int>(json, r'customerId'),
        customerFirstName: mapValueOfType<String>(json, r'customerFirstName'),
        customerLastName: mapValueOfType<String>(json, r'customerLastName'),
        email: mapValueOfType<String>(json, r'email'),
        prefix: mapValueOfType<String>(json, r'prefix'),
        phoneNumber: mapValueOfType<String>(json, r'phoneNumber'),
        message: mapValueOfType<String>(json, r'message'),
        error: mapValueOfType<String>(json, r'error'),
        messageChannel: CustomerCampainDetailMessageChannelEnum.fromJson(json[r'messageChannel']),
        outcomeSms: CustomerCampainDetailOutcomeSmsEnum.fromJson(json[r'outcomeSms']),
        outcomeWhatsapp: CustomerCampainDetailOutcomeWhatsappEnum.fromJson(json[r'outcomeWhatsapp']),
        outcomeEmail: CustomerCampainDetailOutcomeEmailEnum.fromJson(json[r'outcomeEmail']),
        localDateTime: mapDateTime(json, r'localDateTime', r''),
      );
    }
    return null;
  }

  static List<CustomerCampainDetail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerCampainDetail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerCampainDetail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomerCampainDetail> mapFromJson(dynamic json) {
    final map = <String, CustomerCampainDetail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomerCampainDetail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomerCampainDetail-objects as value to a dart map
  static Map<String, List<CustomerCampainDetail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomerCampainDetail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomerCampainDetail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class CustomerCampainDetailMessageChannelEnum {
  /// Instantiate a new enum with the provided [value].
  const CustomerCampainDetailMessageChannelEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const SMS = CustomerCampainDetailMessageChannelEnum._(r'SMS');
  static const EMAIL = CustomerCampainDetailMessageChannelEnum._(r'EMAIL');
  static const WHATSAPP = CustomerCampainDetailMessageChannelEnum._(r'WHATSAPP');

  /// List of all possible values in this [enum][CustomerCampainDetailMessageChannelEnum].
  static const values = <CustomerCampainDetailMessageChannelEnum>[
    SMS,
    EMAIL,
    WHATSAPP,
  ];

  static CustomerCampainDetailMessageChannelEnum? fromJson(dynamic value) => CustomerCampainDetailMessageChannelEnumTypeTransformer().decode(value);

  static List<CustomerCampainDetailMessageChannelEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerCampainDetailMessageChannelEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerCampainDetailMessageChannelEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomerCampainDetailMessageChannelEnum] to String,
/// and [decode] dynamic data back to [CustomerCampainDetailMessageChannelEnum].
class CustomerCampainDetailMessageChannelEnumTypeTransformer {
  factory CustomerCampainDetailMessageChannelEnumTypeTransformer() => _instance ??= const CustomerCampainDetailMessageChannelEnumTypeTransformer._();

  const CustomerCampainDetailMessageChannelEnumTypeTransformer._();

  String encode(CustomerCampainDetailMessageChannelEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomerCampainDetailMessageChannelEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomerCampainDetailMessageChannelEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SMS': return CustomerCampainDetailMessageChannelEnum.SMS;
        case r'EMAIL': return CustomerCampainDetailMessageChannelEnum.EMAIL;
        case r'WHATSAPP': return CustomerCampainDetailMessageChannelEnum.WHATSAPP;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomerCampainDetailMessageChannelEnumTypeTransformer] instance.
  static CustomerCampainDetailMessageChannelEnumTypeTransformer? _instance;
}



class CustomerCampainDetailOutcomeSmsEnum {
  /// Instantiate a new enum with the provided [value].
  const CustomerCampainDetailOutcomeSmsEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const INVIATO = CustomerCampainDetailOutcomeSmsEnum._(r'INVIATO');
  static const NON_INVIATO = CustomerCampainDetailOutcomeSmsEnum._(r'NON_INVIATO');
  static const ERRORE = CustomerCampainDetailOutcomeSmsEnum._(r'ERRORE');

  /// List of all possible values in this [enum][CustomerCampainDetailOutcomeSmsEnum].
  static const values = <CustomerCampainDetailOutcomeSmsEnum>[
    INVIATO,
    NON_INVIATO,
    ERRORE,
  ];

  static CustomerCampainDetailOutcomeSmsEnum? fromJson(dynamic value) => CustomerCampainDetailOutcomeSmsEnumTypeTransformer().decode(value);

  static List<CustomerCampainDetailOutcomeSmsEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerCampainDetailOutcomeSmsEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerCampainDetailOutcomeSmsEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomerCampainDetailOutcomeSmsEnum] to String,
/// and [decode] dynamic data back to [CustomerCampainDetailOutcomeSmsEnum].
class CustomerCampainDetailOutcomeSmsEnumTypeTransformer {
  factory CustomerCampainDetailOutcomeSmsEnumTypeTransformer() => _instance ??= const CustomerCampainDetailOutcomeSmsEnumTypeTransformer._();

  const CustomerCampainDetailOutcomeSmsEnumTypeTransformer._();

  String encode(CustomerCampainDetailOutcomeSmsEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomerCampainDetailOutcomeSmsEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomerCampainDetailOutcomeSmsEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'INVIATO': return CustomerCampainDetailOutcomeSmsEnum.INVIATO;
        case r'NON_INVIATO': return CustomerCampainDetailOutcomeSmsEnum.NON_INVIATO;
        case r'ERRORE': return CustomerCampainDetailOutcomeSmsEnum.ERRORE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomerCampainDetailOutcomeSmsEnumTypeTransformer] instance.
  static CustomerCampainDetailOutcomeSmsEnumTypeTransformer? _instance;
}



class CustomerCampainDetailOutcomeWhatsappEnum {
  /// Instantiate a new enum with the provided [value].
  const CustomerCampainDetailOutcomeWhatsappEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const INVIATO = CustomerCampainDetailOutcomeWhatsappEnum._(r'INVIATO');
  static const NON_INVIATO = CustomerCampainDetailOutcomeWhatsappEnum._(r'NON_INVIATO');
  static const ERRORE = CustomerCampainDetailOutcomeWhatsappEnum._(r'ERRORE');

  /// List of all possible values in this [enum][CustomerCampainDetailOutcomeWhatsappEnum].
  static const values = <CustomerCampainDetailOutcomeWhatsappEnum>[
    INVIATO,
    NON_INVIATO,
    ERRORE,
  ];

  static CustomerCampainDetailOutcomeWhatsappEnum? fromJson(dynamic value) => CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer().decode(value);

  static List<CustomerCampainDetailOutcomeWhatsappEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerCampainDetailOutcomeWhatsappEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerCampainDetailOutcomeWhatsappEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomerCampainDetailOutcomeWhatsappEnum] to String,
/// and [decode] dynamic data back to [CustomerCampainDetailOutcomeWhatsappEnum].
class CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer {
  factory CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer() => _instance ??= const CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer._();

  const CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer._();

  String encode(CustomerCampainDetailOutcomeWhatsappEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomerCampainDetailOutcomeWhatsappEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomerCampainDetailOutcomeWhatsappEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'INVIATO': return CustomerCampainDetailOutcomeWhatsappEnum.INVIATO;
        case r'NON_INVIATO': return CustomerCampainDetailOutcomeWhatsappEnum.NON_INVIATO;
        case r'ERRORE': return CustomerCampainDetailOutcomeWhatsappEnum.ERRORE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer] instance.
  static CustomerCampainDetailOutcomeWhatsappEnumTypeTransformer? _instance;
}



class CustomerCampainDetailOutcomeEmailEnum {
  /// Instantiate a new enum with the provided [value].
  const CustomerCampainDetailOutcomeEmailEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const INVIATO = CustomerCampainDetailOutcomeEmailEnum._(r'INVIATO');
  static const NON_INVIATO = CustomerCampainDetailOutcomeEmailEnum._(r'NON_INVIATO');
  static const ERRORE = CustomerCampainDetailOutcomeEmailEnum._(r'ERRORE');

  /// List of all possible values in this [enum][CustomerCampainDetailOutcomeEmailEnum].
  static const values = <CustomerCampainDetailOutcomeEmailEnum>[
    INVIATO,
    NON_INVIATO,
    ERRORE,
  ];

  static CustomerCampainDetailOutcomeEmailEnum? fromJson(dynamic value) => CustomerCampainDetailOutcomeEmailEnumTypeTransformer().decode(value);

  static List<CustomerCampainDetailOutcomeEmailEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerCampainDetailOutcomeEmailEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerCampainDetailOutcomeEmailEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomerCampainDetailOutcomeEmailEnum] to String,
/// and [decode] dynamic data back to [CustomerCampainDetailOutcomeEmailEnum].
class CustomerCampainDetailOutcomeEmailEnumTypeTransformer {
  factory CustomerCampainDetailOutcomeEmailEnumTypeTransformer() => _instance ??= const CustomerCampainDetailOutcomeEmailEnumTypeTransformer._();

  const CustomerCampainDetailOutcomeEmailEnumTypeTransformer._();

  String encode(CustomerCampainDetailOutcomeEmailEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomerCampainDetailOutcomeEmailEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomerCampainDetailOutcomeEmailEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'INVIATO': return CustomerCampainDetailOutcomeEmailEnum.INVIATO;
        case r'NON_INVIATO': return CustomerCampainDetailOutcomeEmailEnum.NON_INVIATO;
        case r'ERRORE': return CustomerCampainDetailOutcomeEmailEnum.ERRORE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomerCampainDetailOutcomeEmailEnumTypeTransformer] instance.
  static CustomerCampainDetailOutcomeEmailEnumTypeTransformer? _instance;
}


