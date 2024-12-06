//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EmployeeDTO {
  /// Returns a new [EmployeeDTO] instance.
  EmployeeDTO({
    this.employeeId,
    this.lastName,
    this.firstName,
    this.gender,
    this.jobDescription,
    this.dob,
    this.startDateInduction,
    this.endDateInduction,
    this.retribution,
    this.contractType,
    this.email,
    this.prefix,
    this.phone,
    this.branchCode,
    this.remunerationType,
    this.userName,
    this.password,
    this.mobileDeviceDetails = const [],
    this.visible,
    this.fired,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? employeeId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? firstName;

  EmployeeDTOGenderEnum? gender;

  EmployeeDTOJobDescriptionEnum? jobDescription;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dob;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startDateInduction;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? endDateInduction;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? retribution;

  EmployeeDTOContractTypeEnum? contractType;

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
  String? phone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? branchCode;

  EmployeeDTORemunerationTypeEnum? remunerationType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  List<MobileDeviceDetails> mobileDeviceDetails;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? visible;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? fired;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmployeeDTO &&
    other.employeeId == employeeId &&
    other.lastName == lastName &&
    other.firstName == firstName &&
    other.gender == gender &&
    other.jobDescription == jobDescription &&
    other.dob == dob &&
    other.startDateInduction == startDateInduction &&
    other.endDateInduction == endDateInduction &&
    other.retribution == retribution &&
    other.contractType == contractType &&
    other.email == email &&
    other.prefix == prefix &&
    other.phone == phone &&
    other.branchCode == branchCode &&
    other.remunerationType == remunerationType &&
    other.userName == userName &&
    other.password == password &&
    _deepEquality.equals(other.mobileDeviceDetails, mobileDeviceDetails) &&
    other.visible == visible &&
    other.fired == fired;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (employeeId == null ? 0 : employeeId!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (gender == null ? 0 : gender!.hashCode) +
    (jobDescription == null ? 0 : jobDescription!.hashCode) +
    (dob == null ? 0 : dob!.hashCode) +
    (startDateInduction == null ? 0 : startDateInduction!.hashCode) +
    (endDateInduction == null ? 0 : endDateInduction!.hashCode) +
    (retribution == null ? 0 : retribution!.hashCode) +
    (contractType == null ? 0 : contractType!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (prefix == null ? 0 : prefix!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (branchCode == null ? 0 : branchCode!.hashCode) +
    (remunerationType == null ? 0 : remunerationType!.hashCode) +
    (userName == null ? 0 : userName!.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (mobileDeviceDetails.hashCode) +
    (visible == null ? 0 : visible!.hashCode) +
    (fired == null ? 0 : fired!.hashCode);

  @override
  String toString() => 'EmployeeDTO[employeeId=$employeeId, lastName=$lastName, firstName=$firstName, gender=$gender, jobDescription=$jobDescription, dob=$dob, startDateInduction=$startDateInduction, endDateInduction=$endDateInduction, retribution=$retribution, contractType=$contractType, email=$email, prefix=$prefix, phone=$phone, branchCode=$branchCode, remunerationType=$remunerationType, userName=$userName, password=$password, mobileDeviceDetails=$mobileDeviceDetails, visible=$visible, fired=$fired]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.employeeId != null) {
      json[r'employeeId'] = this.employeeId;
    } else {
      json[r'employeeId'] = null;
    }
    if (this.lastName != null) {
      json[r'lastName'] = this.lastName;
    } else {
      json[r'lastName'] = null;
    }
    if (this.firstName != null) {
      json[r'firstName'] = this.firstName;
    } else {
      json[r'firstName'] = null;
    }
    if (this.gender != null) {
      json[r'gender'] = this.gender;
    } else {
      json[r'gender'] = null;
    }
    if (this.jobDescription != null) {
      json[r'jobDescription'] = this.jobDescription;
    } else {
      json[r'jobDescription'] = null;
    }
    if (this.dob != null) {
      json[r'dob'] = _dateFormatter.format(this.dob!.toUtc());
    } else {
      json[r'dob'] = null;
    }
    if (this.startDateInduction != null) {
      json[r'startDateInduction'] = _dateFormatter.format(this.startDateInduction!.toUtc());
    } else {
      json[r'startDateInduction'] = null;
    }
    if (this.endDateInduction != null) {
      json[r'endDateInduction'] = _dateFormatter.format(this.endDateInduction!.toUtc());
    } else {
      json[r'endDateInduction'] = null;
    }
    if (this.retribution != null) {
      json[r'retribution'] = this.retribution;
    } else {
      json[r'retribution'] = null;
    }
    if (this.contractType != null) {
      json[r'contractType'] = this.contractType;
    } else {
      json[r'contractType'] = null;
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
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.branchCode != null) {
      json[r'branchCode'] = this.branchCode;
    } else {
      json[r'branchCode'] = null;
    }
    if (this.remunerationType != null) {
      json[r'remunerationType'] = this.remunerationType;
    } else {
      json[r'remunerationType'] = null;
    }
    if (this.userName != null) {
      json[r'userName'] = this.userName;
    } else {
      json[r'userName'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
      json[r'mobileDeviceDetails'] = this.mobileDeviceDetails;
    if (this.visible != null) {
      json[r'visible'] = this.visible;
    } else {
      json[r'visible'] = null;
    }
    if (this.fired != null) {
      json[r'fired'] = this.fired;
    } else {
      json[r'fired'] = null;
    }
    return json;
  }

  /// Returns a new [EmployeeDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmployeeDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EmployeeDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EmployeeDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EmployeeDTO(
        employeeId: mapValueOfType<int>(json, r'employeeId'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        gender: EmployeeDTOGenderEnum.fromJson(json[r'gender']),
        jobDescription: EmployeeDTOJobDescriptionEnum.fromJson(json[r'jobDescription']),
        dob: mapDateTime(json, r'dob', r''),
        startDateInduction: mapDateTime(json, r'startDateInduction', r''),
        endDateInduction: mapDateTime(json, r'endDateInduction', r''),
        retribution: mapValueOfType<double>(json, r'retribution'),
        contractType: EmployeeDTOContractTypeEnum.fromJson(json[r'contractType']),
        email: mapValueOfType<String>(json, r'email'),
        prefix: mapValueOfType<String>(json, r'prefix'),
        phone: mapValueOfType<String>(json, r'phone'),
        branchCode: mapValueOfType<String>(json, r'branchCode'),
        remunerationType: EmployeeDTORemunerationTypeEnum.fromJson(json[r'remunerationType']),
        userName: mapValueOfType<String>(json, r'userName'),
        password: mapValueOfType<String>(json, r'password'),
        mobileDeviceDetails: MobileDeviceDetails.listFromJson(json[r'mobileDeviceDetails']),
        visible: mapValueOfType<bool>(json, r'visible'),
        fired: mapValueOfType<bool>(json, r'fired'),
      );
    }
    return null;
  }

  static List<EmployeeDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmployeeDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmployeeDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmployeeDTO> mapFromJson(dynamic json) {
    final map = <String, EmployeeDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmployeeDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmployeeDTO-objects as value to a dart map
  static Map<String, List<EmployeeDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmployeeDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmployeeDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class EmployeeDTOGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const EmployeeDTOGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const UOMO = EmployeeDTOGenderEnum._(r'UOMO');
  static const DONNA = EmployeeDTOGenderEnum._(r'DONNA');

  /// List of all possible values in this [enum][EmployeeDTOGenderEnum].
  static const values = <EmployeeDTOGenderEnum>[
    UOMO,
    DONNA,
  ];

  static EmployeeDTOGenderEnum? fromJson(dynamic value) => EmployeeDTOGenderEnumTypeTransformer().decode(value);

  static List<EmployeeDTOGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmployeeDTOGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmployeeDTOGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmployeeDTOGenderEnum] to String,
/// and [decode] dynamic data back to [EmployeeDTOGenderEnum].
class EmployeeDTOGenderEnumTypeTransformer {
  factory EmployeeDTOGenderEnumTypeTransformer() => _instance ??= const EmployeeDTOGenderEnumTypeTransformer._();

  const EmployeeDTOGenderEnumTypeTransformer._();

  String encode(EmployeeDTOGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a EmployeeDTOGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmployeeDTOGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'UOMO': return EmployeeDTOGenderEnum.UOMO;
        case r'DONNA': return EmployeeDTOGenderEnum.DONNA;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EmployeeDTOGenderEnumTypeTransformer] instance.
  static EmployeeDTOGenderEnumTypeTransformer? _instance;
}



class EmployeeDTOJobDescriptionEnum {
  /// Instantiate a new enum with the provided [value].
  const EmployeeDTOJobDescriptionEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const AMMINISTRATORE = EmployeeDTOJobDescriptionEnum._(r'AMMINISTRATORE');
  static const ACCOGLIENZA = EmployeeDTOJobDescriptionEnum._(r'ACCOGLIENZA');
  static const BARMAN = EmployeeDTOJobDescriptionEnum._(r'BARMAN');
  static const CAMERIERE = EmployeeDTOJobDescriptionEnum._(r'CAMERIERE');
  static const CUOCO = EmployeeDTOJobDescriptionEnum._(r'CUOCO');
  static const DIRETTORE = EmployeeDTOJobDescriptionEnum._(r'DIRETTORE');
  static const VICE_DIRETTORE = EmployeeDTOJobDescriptionEnum._(r'VICE_DIRETTORE');
  static const LAVAPIATTI = EmployeeDTOJobDescriptionEnum._(r'LAVAPIATTI');
  static const PIZZAIOLO = EmployeeDTOJobDescriptionEnum._(r'PIZZAIOLO');

  /// List of all possible values in this [enum][EmployeeDTOJobDescriptionEnum].
  static const values = <EmployeeDTOJobDescriptionEnum>[
    AMMINISTRATORE,
    ACCOGLIENZA,
    BARMAN,
    CAMERIERE,
    CUOCO,
    DIRETTORE,
    VICE_DIRETTORE,
    LAVAPIATTI,
    PIZZAIOLO,
  ];

  static EmployeeDTOJobDescriptionEnum? fromJson(dynamic value) => EmployeeDTOJobDescriptionEnumTypeTransformer().decode(value);

  static List<EmployeeDTOJobDescriptionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmployeeDTOJobDescriptionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmployeeDTOJobDescriptionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmployeeDTOJobDescriptionEnum] to String,
/// and [decode] dynamic data back to [EmployeeDTOJobDescriptionEnum].
class EmployeeDTOJobDescriptionEnumTypeTransformer {
  factory EmployeeDTOJobDescriptionEnumTypeTransformer() => _instance ??= const EmployeeDTOJobDescriptionEnumTypeTransformer._();

  const EmployeeDTOJobDescriptionEnumTypeTransformer._();

  String encode(EmployeeDTOJobDescriptionEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a EmployeeDTOJobDescriptionEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmployeeDTOJobDescriptionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AMMINISTRATORE': return EmployeeDTOJobDescriptionEnum.AMMINISTRATORE;
        case r'ACCOGLIENZA': return EmployeeDTOJobDescriptionEnum.ACCOGLIENZA;
        case r'BARMAN': return EmployeeDTOJobDescriptionEnum.BARMAN;
        case r'CAMERIERE': return EmployeeDTOJobDescriptionEnum.CAMERIERE;
        case r'CUOCO': return EmployeeDTOJobDescriptionEnum.CUOCO;
        case r'DIRETTORE': return EmployeeDTOJobDescriptionEnum.DIRETTORE;
        case r'VICE_DIRETTORE': return EmployeeDTOJobDescriptionEnum.VICE_DIRETTORE;
        case r'LAVAPIATTI': return EmployeeDTOJobDescriptionEnum.LAVAPIATTI;
        case r'PIZZAIOLO': return EmployeeDTOJobDescriptionEnum.PIZZAIOLO;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EmployeeDTOJobDescriptionEnumTypeTransformer] instance.
  static EmployeeDTOJobDescriptionEnumTypeTransformer? _instance;
}



class EmployeeDTOContractTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const EmployeeDTOContractTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const DETERMINATO = EmployeeDTOContractTypeEnum._(r'DETERMINATO');
  static const INDETERMINATO = EmployeeDTOContractTypeEnum._(r'INDETERMINATO');

  /// List of all possible values in this [enum][EmployeeDTOContractTypeEnum].
  static const values = <EmployeeDTOContractTypeEnum>[
    DETERMINATO,
    INDETERMINATO,
  ];

  static EmployeeDTOContractTypeEnum? fromJson(dynamic value) => EmployeeDTOContractTypeEnumTypeTransformer().decode(value);

  static List<EmployeeDTOContractTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmployeeDTOContractTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmployeeDTOContractTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmployeeDTOContractTypeEnum] to String,
/// and [decode] dynamic data back to [EmployeeDTOContractTypeEnum].
class EmployeeDTOContractTypeEnumTypeTransformer {
  factory EmployeeDTOContractTypeEnumTypeTransformer() => _instance ??= const EmployeeDTOContractTypeEnumTypeTransformer._();

  const EmployeeDTOContractTypeEnumTypeTransformer._();

  String encode(EmployeeDTOContractTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a EmployeeDTOContractTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmployeeDTOContractTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'DETERMINATO': return EmployeeDTOContractTypeEnum.DETERMINATO;
        case r'INDETERMINATO': return EmployeeDTOContractTypeEnum.INDETERMINATO;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EmployeeDTOContractTypeEnumTypeTransformer] instance.
  static EmployeeDTOContractTypeEnumTypeTransformer? _instance;
}



class EmployeeDTORemunerationTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const EmployeeDTORemunerationTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GIORNALIERA = EmployeeDTORemunerationTypeEnum._(r'GIORNALIERA');
  static const MENSILE = EmployeeDTORemunerationTypeEnum._(r'MENSILE');
  static const ORARIA = EmployeeDTORemunerationTypeEnum._(r'ORARIA');

  /// List of all possible values in this [enum][EmployeeDTORemunerationTypeEnum].
  static const values = <EmployeeDTORemunerationTypeEnum>[
    GIORNALIERA,
    MENSILE,
    ORARIA,
  ];

  static EmployeeDTORemunerationTypeEnum? fromJson(dynamic value) => EmployeeDTORemunerationTypeEnumTypeTransformer().decode(value);

  static List<EmployeeDTORemunerationTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmployeeDTORemunerationTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmployeeDTORemunerationTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmployeeDTORemunerationTypeEnum] to String,
/// and [decode] dynamic data back to [EmployeeDTORemunerationTypeEnum].
class EmployeeDTORemunerationTypeEnumTypeTransformer {
  factory EmployeeDTORemunerationTypeEnumTypeTransformer() => _instance ??= const EmployeeDTORemunerationTypeEnumTypeTransformer._();

  const EmployeeDTORemunerationTypeEnumTypeTransformer._();

  String encode(EmployeeDTORemunerationTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a EmployeeDTORemunerationTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmployeeDTORemunerationTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GIORNALIERA': return EmployeeDTORemunerationTypeEnum.GIORNALIERA;
        case r'MENSILE': return EmployeeDTORemunerationTypeEnum.MENSILE;
        case r'ORARIA': return EmployeeDTORemunerationTypeEnum.ORARIA;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EmployeeDTORemunerationTypeEnumTypeTransformer] instance.
  static EmployeeDTORemunerationTypeEnumTypeTransformer? _instance;
}


