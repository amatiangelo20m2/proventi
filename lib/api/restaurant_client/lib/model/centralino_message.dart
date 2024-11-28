//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CentralinoMessage {
  /// Returns a new [CentralinoMessage] instance.
  CentralinoMessage({
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

  CentralinoMessageTypeEnum? type;

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
  bool operator ==(Object other) => identical(this, other) || other is CentralinoMessage &&
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
    (whatsAppEnabled == null ? 0 : whatsAppEnabled!.hashCode) +
    (smsEnabled == null ? 0 : smsEnabled!.hashCode) +
    (emailEnabled == null ? 0 : emailEnabled!.hashCode);

  @override
  String toString() => 'CentralinoMessage[messageCode=$messageCode, type=$type, description=$description, active=$active, deletable=$deletable, contentSms=$contentSms, contentWhatsapp=$contentWhatsapp, contentEmailTitle=$contentEmailTitle, contentEmail=$contentEmail, createdAt=$createdAt, updatedAt=$updatedAt, whatsAppEnabled=$whatsAppEnabled, smsEnabled=$smsEnabled, emailEnabled=$emailEnabled]';

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

  /// Returns a new [CentralinoMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CentralinoMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CentralinoMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CentralinoMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CentralinoMessage(
        messageCode: mapValueOfType<String>(json, r'messageCode'),
        type: CentralinoMessageTypeEnum.fromJson(json[r'type']),
        description: mapValueOfType<String>(json, r'description'),
        active: mapValueOfType<bool>(json, r'active'),
        deletable: mapValueOfType<bool>(json, r'deletable'),
        contentSms: mapValueOfType<String>(json, r'contentSms'),
        contentWhatsapp: mapValueOfType<String>(json, r'contentWhatsapp'),
        contentEmailTitle: mapValueOfType<String>(json, r'contentEmailTitle'),
        contentEmail: mapValueOfType<String>(json, r'contentEmail'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
        whatsAppEnabled: mapValueOfType<bool>(json, r'whatsAppEnabled'),
        smsEnabled: mapValueOfType<bool>(json, r'smsEnabled'),
        emailEnabled: mapValueOfType<bool>(json, r'emailEnabled'),
      );
    }
    return null;
  }

  static List<CentralinoMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CentralinoMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CentralinoMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CentralinoMessage> mapFromJson(dynamic json) {
    final map = <String, CentralinoMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CentralinoMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CentralinoMessage-objects as value to a dart map
  static Map<String, List<CentralinoMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CentralinoMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CentralinoMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class CentralinoMessageTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const CentralinoMessageTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const n0 = CentralinoMessageTypeEnum._(r'TASTO_0');
  static const n1 = CentralinoMessageTypeEnum._(r'TASTO_1');
  static const n2 = CentralinoMessageTypeEnum._(r'TASTO_2');
  static const n3 = CentralinoMessageTypeEnum._(r'TASTO_3');
  static const n4 = CentralinoMessageTypeEnum._(r'TASTO_4');
  static const n5 = CentralinoMessageTypeEnum._(r'TASTO_5');
  static const n6 = CentralinoMessageTypeEnum._(r'TASTO_6');
  static const n7 = CentralinoMessageTypeEnum._(r'TASTO_7');
  static const n8 = CentralinoMessageTypeEnum._(r'TASTO_8');
  static const n9 = CentralinoMessageTypeEnum._(r'TASTO_9');

  /// List of all possible values in this [enum][CentralinoMessageTypeEnum].
  static const values = <CentralinoMessageTypeEnum>[
    n0,
    n1,
    n2,
    n3,
    n4,
    n5,
    n6,
    n7,
    n8,
    n9,
  ];

  static CentralinoMessageTypeEnum? fromJson(dynamic value) => CentralinoMessageTypeEnumTypeTransformer().decode(value);

  static List<CentralinoMessageTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CentralinoMessageTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CentralinoMessageTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CentralinoMessageTypeEnum] to String,
/// and [decode] dynamic data back to [CentralinoMessageTypeEnum].
class CentralinoMessageTypeEnumTypeTransformer {
  factory CentralinoMessageTypeEnumTypeTransformer() => _instance ??= const CentralinoMessageTypeEnumTypeTransformer._();

  const CentralinoMessageTypeEnumTypeTransformer._();

  String encode(CentralinoMessageTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CentralinoMessageTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CentralinoMessageTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'TASTO_0': return CentralinoMessageTypeEnum.n0;
        case r'TASTO_1': return CentralinoMessageTypeEnum.n1;
        case r'TASTO_2': return CentralinoMessageTypeEnum.n2;
        case r'TASTO_3': return CentralinoMessageTypeEnum.n3;
        case r'TASTO_4': return CentralinoMessageTypeEnum.n4;
        case r'TASTO_5': return CentralinoMessageTypeEnum.n5;
        case r'TASTO_6': return CentralinoMessageTypeEnum.n6;
        case r'TASTO_7': return CentralinoMessageTypeEnum.n7;
        case r'TASTO_8': return CentralinoMessageTypeEnum.n8;
        case r'TASTO_9': return CentralinoMessageTypeEnum.n9;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CentralinoMessageTypeEnumTypeTransformer] instance.
  static CentralinoMessageTypeEnumTypeTransformer? _instance;
}


