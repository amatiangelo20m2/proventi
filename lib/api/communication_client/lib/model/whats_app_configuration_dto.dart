//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WhatsAppConfigurationDTO {
  /// Returns a new [WhatsAppConfigurationDTO] instance.
  WhatsAppConfigurationDTO({
    this.id,
    this.branchCode,
    this.phone,
    this.waApiInstanceId,
    this.waApiState,
    this.lastError,
    this.creationDate,
    this.qrCode,
    this.pairingCode,
    this.photoUrl,
    this.displayName,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? branchCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? phone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? waApiInstanceId;

  WhatsAppConfigurationDTOWaApiStateEnum? waApiState;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastError;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? creationDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? qrCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? pairingCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? photoUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? displayName;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WhatsAppConfigurationDTO &&
    other.id == id &&
    other.branchCode == branchCode &&
    other.phone == phone &&
    other.waApiInstanceId == waApiInstanceId &&
    other.waApiState == waApiState &&
    other.lastError == lastError &&
    other.creationDate == creationDate &&
    other.qrCode == qrCode &&
    other.pairingCode == pairingCode &&
    other.photoUrl == photoUrl &&
    other.displayName == displayName;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (branchCode == null ? 0 : branchCode!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (waApiInstanceId == null ? 0 : waApiInstanceId!.hashCode) +
    (waApiState == null ? 0 : waApiState!.hashCode) +
    (lastError == null ? 0 : lastError!.hashCode) +
    (creationDate == null ? 0 : creationDate!.hashCode) +
    (qrCode == null ? 0 : qrCode!.hashCode) +
    (pairingCode == null ? 0 : pairingCode!.hashCode) +
    (photoUrl == null ? 0 : photoUrl!.hashCode) +
    (displayName == null ? 0 : displayName!.hashCode);

  @override
  String toString() => 'WhatsAppConfigurationDTO[id=$id, branchCode=$branchCode, phone=$phone, waApiInstanceId=$waApiInstanceId, waApiState=$waApiState, lastError=$lastError, creationDate=$creationDate, qrCode=$qrCode, pairingCode=$pairingCode, photoUrl=$photoUrl, displayName=$displayName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.branchCode != null) {
      json[r'branchCode'] = this.branchCode;
    } else {
      json[r'branchCode'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.waApiInstanceId != null) {
      json[r'waApiInstanceId'] = this.waApiInstanceId;
    } else {
      json[r'waApiInstanceId'] = null;
    }
    if (this.waApiState != null) {
      json[r'waApiState'] = this.waApiState;
    } else {
      json[r'waApiState'] = null;
    }
    if (this.lastError != null) {
      json[r'lastError'] = this.lastError;
    } else {
      json[r'lastError'] = null;
    }
    if (this.creationDate != null) {
      json[r'creationDate'] = this.creationDate!.toUtc().toIso8601String();
    } else {
      json[r'creationDate'] = null;
    }
    if (this.qrCode != null) {
      json[r'qrCode'] = this.qrCode;
    } else {
      json[r'qrCode'] = null;
    }
    if (this.pairingCode != null) {
      json[r'pairingCode'] = this.pairingCode;
    } else {
      json[r'pairingCode'] = null;
    }
    if (this.photoUrl != null) {
      json[r'photoUrl'] = this.photoUrl;
    } else {
      json[r'photoUrl'] = null;
    }
    if (this.displayName != null) {
      json[r'displayName'] = this.displayName;
    } else {
      json[r'displayName'] = null;
    }
    return json;
  }

  /// Returns a new [WhatsAppConfigurationDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WhatsAppConfigurationDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WhatsAppConfigurationDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WhatsAppConfigurationDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WhatsAppConfigurationDTO(
        id: mapValueOfType<int>(json, r'id'),
        branchCode: mapValueOfType<String>(json, r'branchCode'),
        phone: mapValueOfType<String>(json, r'phone'),
        waApiInstanceId: mapValueOfType<String>(json, r'waApiInstanceId'),
        waApiState: WhatsAppConfigurationDTOWaApiStateEnum.fromJson(json[r'waApiState']),
        lastError: mapValueOfType<String>(json, r'lastError'),
        creationDate: mapDateTime(json, r'creationDate', r''),
        qrCode: mapValueOfType<String>(json, r'qrCode'),
        pairingCode: mapValueOfType<String>(json, r'pairingCode'),
        photoUrl: mapValueOfType<String>(json, r'photoUrl'),
        displayName: mapValueOfType<String>(json, r'displayName'),
      );
    }
    return null;
  }

  static List<WhatsAppConfigurationDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WhatsAppConfigurationDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WhatsAppConfigurationDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WhatsAppConfigurationDTO> mapFromJson(dynamic json) {
    final map = <String, WhatsAppConfigurationDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WhatsAppConfigurationDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WhatsAppConfigurationDTO-objects as value to a dart map
  static Map<String, List<WhatsAppConfigurationDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WhatsAppConfigurationDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WhatsAppConfigurationDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class WhatsAppConfigurationDTOWaApiStateEnum {
  /// Instantiate a new enum with the provided [value].
  const WhatsAppConfigurationDTOWaApiStateEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ISTANZA_CREATA = WhatsAppConfigurationDTOWaApiStateEnum._(r'ISTANZA_CREATA');
  static const QR = WhatsAppConfigurationDTOWaApiStateEnum._(r'QR');
  static const PRONTA = WhatsAppConfigurationDTOWaApiStateEnum._(r'PRONTA');
  static const NON_PRONTA = WhatsAppConfigurationDTOWaApiStateEnum._(r'NON_PRONTA');

  /// List of all possible values in this [enum][WhatsAppConfigurationDTOWaApiStateEnum].
  static const values = <WhatsAppConfigurationDTOWaApiStateEnum>[
    ISTANZA_CREATA,
    QR,
    PRONTA,
    NON_PRONTA,
  ];

  static WhatsAppConfigurationDTOWaApiStateEnum? fromJson(dynamic value) => WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer().decode(value);

  static List<WhatsAppConfigurationDTOWaApiStateEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WhatsAppConfigurationDTOWaApiStateEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WhatsAppConfigurationDTOWaApiStateEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WhatsAppConfigurationDTOWaApiStateEnum] to String,
/// and [decode] dynamic data back to [WhatsAppConfigurationDTOWaApiStateEnum].
class WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer {
  factory WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer() => _instance ??= const WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer._();

  const WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer._();

  String encode(WhatsAppConfigurationDTOWaApiStateEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a WhatsAppConfigurationDTOWaApiStateEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WhatsAppConfigurationDTOWaApiStateEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ISTANZA_CREATA': return WhatsAppConfigurationDTOWaApiStateEnum.ISTANZA_CREATA;
        case r'QR': return WhatsAppConfigurationDTOWaApiStateEnum.QR;
        case r'PRONTA': return WhatsAppConfigurationDTOWaApiStateEnum.PRONTA;
        case r'NON_PRONTA': return WhatsAppConfigurationDTOWaApiStateEnum.NON_PRONTA;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer] instance.
  static WhatsAppConfigurationDTOWaApiStateEnumTypeTransformer? _instance;
}


