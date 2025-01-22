//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendingCampainDTO {
  /// Returns a new [SendingCampainDTO] instance.
  SendingCampainDTO({
    this.sendingCampainId,
    this.campainName,
    this.branchCode,
    this.branchName,
    this.filterTags,
    this.campainCode,
    this.createdBy,
    this.templateWhatsApp,
    this.templateSms,
    this.templateEmailTitle,
    this.templateEmailBody,
    this.customerIds = const [],
    this.creationDate,
    this.campainStatus,
    this.messageChannel,
    this.customerCampainDetails = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? sendingCampainId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? campainName;

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
  String? branchName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? filterTags;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? campainCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? templateWhatsApp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? templateSms;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? templateEmailTitle;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? templateEmailBody;

  List<int> customerIds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? creationDate;

  SendingCampainDTOCampainStatusEnum? campainStatus;

  SendingCampainDTOMessageChannelEnum? messageChannel;

  List<CustomerCampainDetail> customerCampainDetails;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendingCampainDTO &&
    other.sendingCampainId == sendingCampainId &&
    other.campainName == campainName &&
    other.branchCode == branchCode &&
    other.branchName == branchName &&
    other.filterTags == filterTags &&
    other.campainCode == campainCode &&
    other.createdBy == createdBy &&
    other.templateWhatsApp == templateWhatsApp &&
    other.templateSms == templateSms &&
    other.templateEmailTitle == templateEmailTitle &&
    other.templateEmailBody == templateEmailBody &&
    _deepEquality.equals(other.customerIds, customerIds) &&
    other.creationDate == creationDate &&
    other.campainStatus == campainStatus &&
    other.messageChannel == messageChannel &&
    _deepEquality.equals(other.customerCampainDetails, customerCampainDetails);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (sendingCampainId == null ? 0 : sendingCampainId!.hashCode) +
    (campainName == null ? 0 : campainName!.hashCode) +
    (branchCode == null ? 0 : branchCode!.hashCode) +
    (branchName == null ? 0 : branchName!.hashCode) +
    (filterTags == null ? 0 : filterTags!.hashCode) +
    (campainCode == null ? 0 : campainCode!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (templateWhatsApp == null ? 0 : templateWhatsApp!.hashCode) +
    (templateSms == null ? 0 : templateSms!.hashCode) +
    (templateEmailTitle == null ? 0 : templateEmailTitle!.hashCode) +
    (templateEmailBody == null ? 0 : templateEmailBody!.hashCode) +
    (customerIds.hashCode) +
    (creationDate == null ? 0 : creationDate!.hashCode) +
    (campainStatus == null ? 0 : campainStatus!.hashCode) +
    (messageChannel == null ? 0 : messageChannel!.hashCode) +
    (customerCampainDetails.hashCode);

  @override
  String toString() => 'SendingCampainDTO[sendingCampainId=$sendingCampainId, campainName=$campainName, branchCode=$branchCode, branchName=$branchName, filterTags=$filterTags, campainCode=$campainCode, createdBy=$createdBy, templateWhatsApp=$templateWhatsApp, templateSms=$templateSms, templateEmailTitle=$templateEmailTitle, templateEmailBody=$templateEmailBody, customerIds=$customerIds, creationDate=$creationDate, campainStatus=$campainStatus, messageChannel=$messageChannel, customerCampainDetails=$customerCampainDetails]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.sendingCampainId != null) {
      json[r'sendingCampainId'] = this.sendingCampainId;
    } else {
      json[r'sendingCampainId'] = null;
    }
    if (this.campainName != null) {
      json[r'campainName'] = this.campainName;
    } else {
      json[r'campainName'] = null;
    }
    if (this.branchCode != null) {
      json[r'branchCode'] = this.branchCode;
    } else {
      json[r'branchCode'] = null;
    }
    if (this.branchName != null) {
      json[r'branchName'] = this.branchName;
    } else {
      json[r'branchName'] = null;
    }
    if (this.filterTags != null) {
      json[r'filterTags'] = this.filterTags;
    } else {
      json[r'filterTags'] = null;
    }
    if (this.campainCode != null) {
      json[r'campainCode'] = this.campainCode;
    } else {
      json[r'campainCode'] = null;
    }
    if (this.createdBy != null) {
      json[r'createdBy'] = this.createdBy;
    } else {
      json[r'createdBy'] = null;
    }
    if (this.templateWhatsApp != null) {
      json[r'templateWhatsApp'] = this.templateWhatsApp;
    } else {
      json[r'templateWhatsApp'] = null;
    }
    if (this.templateSms != null) {
      json[r'templateSms'] = this.templateSms;
    } else {
      json[r'templateSms'] = null;
    }
    if (this.templateEmailTitle != null) {
      json[r'templateEmailTitle'] = this.templateEmailTitle;
    } else {
      json[r'templateEmailTitle'] = null;
    }
    if (this.templateEmailBody != null) {
      json[r'templateEmailBody'] = this.templateEmailBody;
    } else {
      json[r'templateEmailBody'] = null;
    }
      json[r'customerIds'] = this.customerIds;
    if (this.creationDate != null) {
      json[r'creationDate'] = this.creationDate!.toUtc().toIso8601String();
    } else {
      json[r'creationDate'] = null;
    }
    if (this.campainStatus != null) {
      json[r'campainStatus'] = this.campainStatus;
    } else {
      json[r'campainStatus'] = null;
    }
    if (this.messageChannel != null) {
      json[r'messageChannel'] = this.messageChannel;
    } else {
      json[r'messageChannel'] = null;
    }
      json[r'customerCampainDetails'] = this.customerCampainDetails;
    return json;
  }

  /// Returns a new [SendingCampainDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendingCampainDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SendingCampainDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SendingCampainDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SendingCampainDTO(
        sendingCampainId: mapValueOfType<int>(json, r'sendingCampainId'),
        campainName: mapValueOfType<String>(json, r'campainName'),
        branchCode: mapValueOfType<String>(json, r'branchCode'),
        branchName: mapValueOfType<String>(json, r'branchName'),
        filterTags: mapValueOfType<String>(json, r'filterTags'),
        campainCode: mapValueOfType<String>(json, r'campainCode'),
        createdBy: mapValueOfType<String>(json, r'createdBy'),
        templateWhatsApp: mapValueOfType<String>(json, r'templateWhatsApp'),
        templateSms: mapValueOfType<String>(json, r'templateSms'),
        templateEmailTitle: mapValueOfType<String>(json, r'templateEmailTitle'),
        templateEmailBody: mapValueOfType<String>(json, r'templateEmailBody'),
        customerIds: json[r'customerIds'] is Iterable
            ? (json[r'customerIds'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        creationDate: mapDateTime(json, r'creationDate', r''),
        campainStatus: SendingCampainDTOCampainStatusEnum.fromJson(json[r'campainStatus']),
        messageChannel: SendingCampainDTOMessageChannelEnum.fromJson(json[r'messageChannel']),
        customerCampainDetails: CustomerCampainDetail.listFromJson(json[r'customerCampainDetails']),
      );
    }
    return null;
  }

  static List<SendingCampainDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendingCampainDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendingCampainDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendingCampainDTO> mapFromJson(dynamic json) {
    final map = <String, SendingCampainDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendingCampainDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendingCampainDTO-objects as value to a dart map
  static Map<String, List<SendingCampainDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendingCampainDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendingCampainDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class SendingCampainDTOCampainStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const SendingCampainDTOCampainStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CREATA = SendingCampainDTOCampainStatusEnum._(r'CREATA');
  static const AVVIATA = SendingCampainDTOCampainStatusEnum._(r'AVVIATA');
  static const TERMINATA = SendingCampainDTOCampainStatusEnum._(r'TERMINATA');

  /// List of all possible values in this [enum][SendingCampainDTOCampainStatusEnum].
  static const values = <SendingCampainDTOCampainStatusEnum>[
    CREATA,
    AVVIATA,
    TERMINATA,
  ];

  static SendingCampainDTOCampainStatusEnum? fromJson(dynamic value) => SendingCampainDTOCampainStatusEnumTypeTransformer().decode(value);

  static List<SendingCampainDTOCampainStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendingCampainDTOCampainStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendingCampainDTOCampainStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SendingCampainDTOCampainStatusEnum] to String,
/// and [decode] dynamic data back to [SendingCampainDTOCampainStatusEnum].
class SendingCampainDTOCampainStatusEnumTypeTransformer {
  factory SendingCampainDTOCampainStatusEnumTypeTransformer() => _instance ??= const SendingCampainDTOCampainStatusEnumTypeTransformer._();

  const SendingCampainDTOCampainStatusEnumTypeTransformer._();

  String encode(SendingCampainDTOCampainStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a SendingCampainDTOCampainStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SendingCampainDTOCampainStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CREATA': return SendingCampainDTOCampainStatusEnum.CREATA;
        case r'AVVIATA': return SendingCampainDTOCampainStatusEnum.AVVIATA;
        case r'TERMINATA': return SendingCampainDTOCampainStatusEnum.TERMINATA;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SendingCampainDTOCampainStatusEnumTypeTransformer] instance.
  static SendingCampainDTOCampainStatusEnumTypeTransformer? _instance;
}



class SendingCampainDTOMessageChannelEnum {
  /// Instantiate a new enum with the provided [value].
  const SendingCampainDTOMessageChannelEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const SMS = SendingCampainDTOMessageChannelEnum._(r'SMS');
  static const EMAIL = SendingCampainDTOMessageChannelEnum._(r'EMAIL');
  static const WHATSAPP = SendingCampainDTOMessageChannelEnum._(r'WHATSAPP');

  /// List of all possible values in this [enum][SendingCampainDTOMessageChannelEnum].
  static const values = <SendingCampainDTOMessageChannelEnum>[
    SMS,
    EMAIL,
    WHATSAPP,
  ];

  static SendingCampainDTOMessageChannelEnum? fromJson(dynamic value) => SendingCampainDTOMessageChannelEnumTypeTransformer().decode(value);

  static List<SendingCampainDTOMessageChannelEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendingCampainDTOMessageChannelEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendingCampainDTOMessageChannelEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SendingCampainDTOMessageChannelEnum] to String,
/// and [decode] dynamic data back to [SendingCampainDTOMessageChannelEnum].
class SendingCampainDTOMessageChannelEnumTypeTransformer {
  factory SendingCampainDTOMessageChannelEnumTypeTransformer() => _instance ??= const SendingCampainDTOMessageChannelEnumTypeTransformer._();

  const SendingCampainDTOMessageChannelEnumTypeTransformer._();

  String encode(SendingCampainDTOMessageChannelEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a SendingCampainDTOMessageChannelEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SendingCampainDTOMessageChannelEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SMS': return SendingCampainDTOMessageChannelEnum.SMS;
        case r'EMAIL': return SendingCampainDTOMessageChannelEnum.EMAIL;
        case r'WHATSAPP': return SendingCampainDTOMessageChannelEnum.WHATSAPP;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SendingCampainDTOMessageChannelEnumTypeTransformer] instance.
  static SendingCampainDTOMessageChannelEnumTypeTransformer? _instance;
}


