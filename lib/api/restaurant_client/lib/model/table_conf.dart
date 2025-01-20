//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TableConf {
  /// Returns a new [TableConf] instance.
  TableConf({
    this.name,
    this.code,
    this.partyNumber,
    this.orientation,
    this.offsetY,
    this.offsetX,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;
  String? code;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? partyNumber;

  TableConfOrientationEnum? orientation;

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

  @override
  bool operator ==(Object other) => identical(this, other) || other is TableConf &&
    other.name == name &&
    other.code == code &&
    other.partyNumber == partyNumber &&
    other.orientation == orientation &&
    other.offsetY == offsetY &&
    other.offsetX == offsetX;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (code == null ? 0 : code!.hashCode) +
    (partyNumber == null ? 0 : partyNumber!.hashCode) +
    (orientation == null ? 0 : orientation!.hashCode) +
    (offsetY == null ? 0 : offsetY!.hashCode) +
    (offsetX == null ? 0 : offsetX!.hashCode);

  @override
  String toString() => 'TableConf[code=$code, partyNumber=$partyNumber, orientation=$orientation, offsetY=$offsetY, offsetX=$offsetX]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.code != null) {
      json[r'code'] = this.code;
    } else {
      json[r'code'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
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
    return json;
  }

  /// Returns a new [TableConf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TableConf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TableConf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TableConf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TableConf(
        code: mapValueOfType<String>(json, r'code'),
        partyNumber: mapValueOfType<int>(json, r'partyNumber'),
        orientation: TableConfOrientationEnum.fromJson(json[r'orientation']),
        offsetY: mapValueOfType<double>(json, r'offsetY'),
        offsetX: mapValueOfType<double>(json, r'offsetX'),
      );
    }
    return null;
  }

  static List<TableConf> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TableConf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TableConf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TableConf> mapFromJson(dynamic json) {
    final map = <String, TableConf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TableConf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TableConf-objects as value to a dart map
  static Map<String, List<TableConf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TableConf>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TableConf.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class TableConfOrientationEnum {
  /// Instantiate a new enum with the provided [value].
  const TableConfOrientationEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const VERTICAL = TableConfOrientationEnum._(r'VERTICAL');
  static const HORIZONTAL = TableConfOrientationEnum._(r'HORIZONTAL');

  /// List of all possible values in this [enum][TableConfOrientationEnum].
  static const values = <TableConfOrientationEnum>[
    VERTICAL,
    HORIZONTAL,
  ];

  static TableConfOrientationEnum? fromJson(dynamic value) => TableConfOrientationEnumTypeTransformer().decode(value);

  static List<TableConfOrientationEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TableConfOrientationEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TableConfOrientationEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TableConfOrientationEnum] to String,
/// and [decode] dynamic data back to [TableConfOrientationEnum].
class TableConfOrientationEnumTypeTransformer {
  factory TableConfOrientationEnumTypeTransformer() => _instance ??= const TableConfOrientationEnumTypeTransformer._();

  const TableConfOrientationEnumTypeTransformer._();

  String encode(TableConfOrientationEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TableConfOrientationEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TableConfOrientationEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'VERTICAL': return TableConfOrientationEnum.VERTICAL;
        case r'HORIZONTAL': return TableConfOrientationEnum.HORIZONTAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TableConfOrientationEnumTypeTransformer] instance.
  static TableConfOrientationEnumTypeTransformer? _instance;
}


