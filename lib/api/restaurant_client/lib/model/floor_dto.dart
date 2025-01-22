//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FloorDTO {
  /// Returns a new [FloorDTO] instance.
  FloorDTO({
    this.floorId,
    this.floorCode,
    this.branchCode,
    this.floorName,
    this.floorDescription,
    this.tables = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? floorId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? floorCode;

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
  String? floorName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? floorDescription;

  List<TableConfDTO> tables;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FloorDTO &&
    other.floorId == floorId &&
    other.floorCode == floorCode &&
    other.branchCode == branchCode &&
    other.floorName == floorName &&
    other.floorDescription == floorDescription &&
    _deepEquality.equals(other.tables, tables);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (floorId == null ? 0 : floorId!.hashCode) +
    (floorCode == null ? 0 : floorCode!.hashCode) +
    (branchCode == null ? 0 : branchCode!.hashCode) +
    (floorName == null ? 0 : floorName!.hashCode) +
    (floorDescription == null ? 0 : floorDescription!.hashCode) +
    (tables.hashCode);

  @override
  String toString() => 'FloorDTO[floorId=$floorId, floorCode=$floorCode, branchCode=$branchCode, floorName=$floorName, floorDescription=$floorDescription, tables=$tables]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.floorId != null) {
      json[r'floorId'] = this.floorId;
    } else {
      json[r'floorId'] = null;
    }
    if (this.floorCode != null) {
      json[r'floorCode'] = this.floorCode;
    } else {
      json[r'floorCode'] = null;
    }
    if (this.branchCode != null) {
      json[r'branchCode'] = this.branchCode;
    } else {
      json[r'branchCode'] = null;
    }
    if (this.floorName != null) {
      json[r'floorName'] = this.floorName;
    } else {
      json[r'floorName'] = null;
    }
    if (this.floorDescription != null) {
      json[r'floorDescription'] = this.floorDescription;
    } else {
      json[r'floorDescription'] = null;
    }
      json[r'tables'] = this.tables;
    return json;
  }

  /// Returns a new [FloorDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FloorDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FloorDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FloorDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FloorDTO(
        floorId: mapValueOfType<int>(json, r'floorId'),
        floorCode: mapValueOfType<String>(json, r'floorCode'),
        branchCode: mapValueOfType<String>(json, r'branchCode'),
        floorName: mapValueOfType<String>(json, r'floorName'),
        floorDescription: mapValueOfType<String>(json, r'floorDescription'),
        tables: TableConfDTO.listFromJson(json[r'tables']),
      );
    }
    return null;
  }

  static List<FloorDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FloorDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FloorDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FloorDTO> mapFromJson(dynamic json) {
    final map = <String, FloorDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FloorDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FloorDTO-objects as value to a dart map
  static Map<String, List<FloorDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FloorDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FloorDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

