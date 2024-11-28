//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AfterBookingSchedulerMessage {
  /// Returns a new [AfterBookingSchedulerMessage] instance.
  AfterBookingSchedulerMessage({
    this.messageCode,
    this.type,
    this.description,
    this.active,
    this.deletable,
    this.contentSms,
    this.contentWhatsapp,
    this.contentEmailTitle,
    this.contentEmail,
    this.createdAt,
    this.updatedAt,
    this.howManyDaysAfter,
    this.dayHour,
    this.whatsAppEnabled,
    this.smsEnabled,
    this.emailEnabled,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? messageCode;

  AfterBookingSchedulerMessageTypeEnum? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? active;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? deletable;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contentSms;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contentWhatsapp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contentEmailTitle;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contentEmail;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? updatedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? howManyDaysAfter;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? dayHour;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? whatsAppEnabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? smsEnabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AfterBookingSchedulerMessage &&
    other.messageCode == messageCode &&
    other.type == type &&
    other.description == description &&
    other.active == active &&
    other.deletable == deletable &&
    other.contentSms == contentSms &&
    other.contentWhatsapp == contentWhatsapp &&
    other.contentEmailTitle == contentEmailTitle &&
    other.contentEmail == contentEmail &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.howManyDaysAfter == howManyDaysAfter &&
    other.dayHour == dayHour &&
    other.whatsAppEnabled == whatsAppEnabled &&
    other.smsEnabled == smsEnabled &&
    other.emailEnabled == emailEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messageCode == null ? 0 : messageCode!.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (active == null ? 0 : active!.hashCode) +
    (deletable == null ? 0 : deletable!.hashCode) +
    (contentSms == null ? 0 : contentSms!.hashCode) +
    (contentWhatsapp == null ? 0 : contentWhatsapp!.hashCode) +
    (contentEmailTitle == null ? 0 : contentEmailTitle!.hashCode) +
    (contentEmail == null ? 0 : contentEmail!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (howManyDaysAfter == null ? 0 : howManyDaysAfter!.hashCode) +
    (dayHour == null ? 0 : dayHour!.hashCode) +
    (whatsAppEnabled == null ? 0 : whatsAppEnabled!.hashCode) +
    (smsEnabled == null ? 0 : smsEnabled!.hashCode) +
    (emailEnabled == null ? 0 : emailEnabled!.hashCode);

  @override
  String toString() => 'AfterBookingSchedulerMessage[messageCode=$messageCode, type=$type, description=$description, active=$active, deletable=$deletable, contentSms=$contentSms, contentWhatsapp=$contentWhatsapp, contentEmailTitle=$contentEmailTitle, contentEmail=$contentEmail, createdAt=$createdAt, updatedAt=$updatedAt, howManyDaysAfter=$howManyDaysAfter, dayHour=$dayHour, whatsAppEnabled=$whatsAppEnabled, smsEnabled=$smsEnabled, emailEnabled=$emailEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.messageCode != null) {
      json[r'messageCode'] = this.messageCode;
    } else {
      json[r'messageCode'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.active != null) {
      json[r'active'] = this.active;
    } else {
      json[r'active'] = null;
    }
    if (this.deletable != null) {
      json[r'deletable'] = this.deletable;
    } else {
      json[r'deletable'] = null;
    }
    if (this.contentSms != null) {
      json[r'contentSms'] = this.contentSms;
    } else {
      json[r'contentSms'] = null;
    }
    if (this.contentWhatsapp != null) {
      json[r'contentWhatsapp'] = this.contentWhatsapp;
    } else {
      json[r'contentWhatsapp'] = null;
    }
    if (this.contentEmailTitle != null) {
      json[r'contentEmailTitle'] = this.contentEmailTitle;
    } else {
      json[r'contentEmailTitle'] = null;
    }
    if (this.contentEmail != null) {
      json[r'contentEmail'] = this.contentEmail;
    } else {
      json[r'contentEmail'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updatedAt'] = null;
    }
    if (this.howManyDaysAfter != null) {
      json[r'howManyDaysAfter'] = this.howManyDaysAfter;
    } else {
      json[r'howManyDaysAfter'] = null;
    }
    if (this.dayHour != null) {
      json[r'dayHour'] = this.dayHour;
    } else {
      json[r'dayHour'] = null;
    }
    if (this.whatsAppEnabled != null) {
      json[r'whatsAppEnabled'] = this.whatsAppEnabled;
    } else {
      json[r'whatsAppEnabled'] = null;
    }
    if (this.smsEnabled != null) {
      json[r'smsEnabled'] = this.smsEnabled;
    } else {
      json[r'smsEnabled'] = null;
    }
    if (this.emailEnabled != null) {
      json[r'emailEnabled'] = this.emailEnabled;
    } else {
      json[r'emailEnabled'] = null;
    }
    return json;
  }

  /// Returns a new [AfterBookingSchedulerMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AfterBookingSchedulerMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AfterBookingSchedulerMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AfterBookingSchedulerMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AfterBookingSchedulerMessage(
        messageCode: mapValueOfType<String>(json, r'messageCode'),
        type: AfterBookingSchedulerMessageTypeEnum.fromJson(json[r'type']),
        description: mapValueOfType<String>(json, r'description'),
        active: mapValueOfType<bool>(json, r'active'),
        deletable: mapValueOfType<bool>(json, r'deletable'),
        contentSms: mapValueOfType<String>(json, r'contentSms'),
        contentWhatsapp: mapValueOfType<String>(json, r'contentWhatsapp'),
        contentEmailTitle: mapValueOfType<String>(json, r'contentEmailTitle'),
        contentEmail: mapValueOfType<String>(json, r'contentEmail'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
        howManyDaysAfter: mapValueOfType<int>(json, r'howManyDaysAfter'),
        dayHour: mapValueOfType<int>(json, r'dayHour'),
        whatsAppEnabled: mapValueOfType<bool>(json, r'whatsAppEnabled'),
        smsEnabled: mapValueOfType<bool>(json, r'smsEnabled'),
        emailEnabled: mapValueOfType<bool>(json, r'emailEnabled'),
      );
    }
    return null;
  }

  static List<AfterBookingSchedulerMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AfterBookingSchedulerMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AfterBookingSchedulerMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AfterBookingSchedulerMessage> mapFromJson(dynamic json) {
    final map = <String, AfterBookingSchedulerMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AfterBookingSchedulerMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AfterBookingSchedulerMessage-objects as value to a dart map
  static Map<String, List<AfterBookingSchedulerMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AfterBookingSchedulerMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AfterBookingSchedulerMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class AfterBookingSchedulerMessageTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const AfterBookingSchedulerMessageTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const AAD = AfterBookingSchedulerMessageTypeEnum._(r'AAD');
  static const CBP = AfterBookingSchedulerMessageTypeEnum._(r'CBP');
  static const BRP = AfterBookingSchedulerMessageTypeEnum._(r'BRP');

  /// List of all possible values in this [enum][AfterBookingSchedulerMessageTypeEnum].
  static const values = <AfterBookingSchedulerMessageTypeEnum>[
    AAD,
    CBP,
    BRP,
  ];

  static AfterBookingSchedulerMessageTypeEnum? fromJson(dynamic value) => AfterBookingSchedulerMessageTypeEnumTypeTransformer().decode(value);

  static List<AfterBookingSchedulerMessageTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AfterBookingSchedulerMessageTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AfterBookingSchedulerMessageTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AfterBookingSchedulerMessageTypeEnum] to String,
/// and [decode] dynamic data back to [AfterBookingSchedulerMessageTypeEnum].
class AfterBookingSchedulerMessageTypeEnumTypeTransformer {
  factory AfterBookingSchedulerMessageTypeEnumTypeTransformer() => _instance ??= const AfterBookingSchedulerMessageTypeEnumTypeTransformer._();

  const AfterBookingSchedulerMessageTypeEnumTypeTransformer._();

  String encode(AfterBookingSchedulerMessageTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AfterBookingSchedulerMessageTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AfterBookingSchedulerMessageTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AAD': return AfterBookingSchedulerMessageTypeEnum.AAD;
        case r'CBP': return AfterBookingSchedulerMessageTypeEnum.CBP;
        case r'BRP': return AfterBookingSchedulerMessageTypeEnum.BRP;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AfterBookingSchedulerMessageTypeEnumTypeTransformer] instance.
  static AfterBookingSchedulerMessageTypeEnumTypeTransformer? _instance;
}


