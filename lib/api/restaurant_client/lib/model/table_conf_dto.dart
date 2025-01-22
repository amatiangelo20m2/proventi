//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TableConfDTO {
  /// Returns a new [TableConfDTO] instance.
  TableConfDTO({
    this.tableConfId,
    this.tableCode,
    this.tableName,
    this.partyNumber,
    this.orientation,
    this.offsetY,
    this.offsetX,
    this.tableBookingCalendarConf = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? tableConfId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tableCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tableName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? partyNumber;

  TableConfDTOOrientationEnum? orientation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? offsetY;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? offsetX;

  List<TableBookingCalendar> tableBookingCalendarConf;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TableConfDTO &&
    other.tableConfId == tableConfId &&
    other.tableCode == tableCode &&
    other.tableName == tableName &&
    other.partyNumber == partyNumber &&
    other.orientation == orientation &&
    other.offsetY == offsetY &&
    other.offsetX == offsetX &&
    _deepEquality.equals(other.tableBookingCalendarConf, tableBookingCalendarConf);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tableConfId == null ? 0 : tableConfId!.hashCode) +
    (tableCode == null ? 0 : tableCode!.hashCode) +
    (tableName == null ? 0 : tableName!.hashCode) +
    (partyNumber == null ? 0 : partyNumber!.hashCode) +
    (orientation == null ? 0 : orientation!.hashCode) +
    (offsetY == null ? 0 : offsetY!.hashCode) +
    (offsetX == null ? 0 : offsetX!.hashCode) +
    (tableBookingCalendarConf.hashCode);

  @override
  String toString() => 'TableConfDTO[tableConfId=$tableConfId, tableCode=$tableCode, tableName=$tableName, partyNumber=$partyNumber, orientation=$orientation, offsetY=$offsetY, offsetX=$offsetX, tableBookingCalendarConf=$tableBookingCalendarConf]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.tableConfId != null) {
      json[r'tableConfId'] = this.tableConfId;
    } else {
      json[r'tableConfId'] = null;
    }
    if (this.tableCode != null) {
      json[r'tableCode'] = this.tableCode;
    } else {
      json[r'tableCode'] = null;
    }
    if (this.tableName != null) {
      json[r'tableName'] = this.tableName;
    } else {
      json[r'tableName'] = null;
    }
    if (this.partyNumber != null) {
      json[r'partyNumber'] = this.partyNumber;
    } else {
      json[r'partyNumber'] = null;
    }
    if (this.orientation != null) {
      json[r'orientation'] = this.orientation;
    } else {
      json[r'orientation'] = null;
    }
    if (this.offsetY != null) {
      json[r'offsetY'] = this.offsetY;
    } else {
      json[r'offsetY'] = null;
    }
    if (this.offsetX != null) {
      json[r'offsetX'] = this.offsetX;
    } else {
      json[r'offsetX'] = null;
    }
      json[r'tableBookingCalendarConf'] = this.tableBookingCalendarConf;
    return json;
  }

  /// Returns a new [TableConfDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TableConfDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TableConfDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TableConfDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TableConfDTO(
        tableConfId: mapValueOfType<int>(json, r'tableConfId'),
        tableCode: mapValueOfType<String>(json, r'tableCode'),
        tableName: mapValueOfType<String>(json, r'tableName'),
        partyNumber: mapValueOfType<int>(json, r'partyNumber'),
        orientation: TableConfDTOOrientationEnum.fromJson(json[r'orientation']),
        offsetY: mapValueOfType<double>(json, r'offsetY'),
        offsetX: mapValueOfType<double>(json, r'offsetX'),
        tableBookingCalendarConf: TableBookingCalendar.listFromJson(json[r'tableBookingCalendarConf']),
      );
    }
    return null;
  }

  static List<TableConfDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TableConfDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TableConfDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TableConfDTO> mapFromJson(dynamic json) {
    final map = <String, TableConfDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TableConfDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TableConfDTO-objects as value to a dart map
  static Map<String, List<TableConfDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TableConfDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TableConfDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class TableConfDTOOrientationEnum {
  /// Instantiate a new enum with the provided [value].
  const TableConfDTOOrientationEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const VERTICAL = TableConfDTOOrientationEnum._(r'VERTICAL');
  static const HORIZONTAL = TableConfDTOOrientationEnum._(r'HORIZONTAL');

  /// List of all possible values in this [enum][TableConfDTOOrientationEnum].
  static const values = <TableConfDTOOrientationEnum>[
    VERTICAL,
    HORIZONTAL,
  ];

  static TableConfDTOOrientationEnum? fromJson(dynamic value) => TableConfDTOOrientationEnumTypeTransformer().decode(value);

  static List<TableConfDTOOrientationEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TableConfDTOOrientationEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TableConfDTOOrientationEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TableConfDTOOrientationEnum] to String,
/// and [decode] dynamic data back to [TableConfDTOOrientationEnum].
class TableConfDTOOrientationEnumTypeTransformer {
  factory TableConfDTOOrientationEnumTypeTransformer() => _instance ??= const TableConfDTOOrientationEnumTypeTransformer._();

  const TableConfDTOOrientationEnumTypeTransformer._();

  String encode(TableConfDTOOrientationEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TableConfDTOOrientationEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TableConfDTOOrientationEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'VERTICAL': return TableConfDTOOrientationEnum.VERTICAL;
        case r'HORIZONTAL': return TableConfDTOOrientationEnum.HORIZONTAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TableConfDTOOrientationEnumTypeTransformer] instance.
  static TableConfDTOOrientationEnumTypeTransformer? _instance;
}


