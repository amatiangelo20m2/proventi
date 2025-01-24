//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WeekMetrics {
  /// Returns a new [WeekMetrics] instance.
  WeekMetrics({
    this.totBookings,
    this.totCustomers,
    this.arrived,
    this.refused,
    this.noShow,
    this.deleted,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totBookings;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totCustomers;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? arrived;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? refused;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? noShow;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? deleted;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WeekMetrics &&
    other.totBookings == totBookings &&
    other.totCustomers == totCustomers &&
    other.arrived == arrived &&
    other.refused == refused &&
    other.noShow == noShow &&
    other.deleted == deleted;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (totBookings == null ? 0 : totBookings!.hashCode) +
    (totCustomers == null ? 0 : totCustomers!.hashCode) +
    (arrived == null ? 0 : arrived!.hashCode) +
    (refused == null ? 0 : refused!.hashCode) +
    (noShow == null ? 0 : noShow!.hashCode) +
    (deleted == null ? 0 : deleted!.hashCode);

  @override
  String toString() => 'WeekMetrics[totBookings=$totBookings, totCustomers=$totCustomers, arrived=$arrived, refused=$refused, noShow=$noShow, deleted=$deleted]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.totBookings != null) {
      json[r'totBookings'] = this.totBookings;
    } else {
      json[r'totBookings'] = null;
    }
    if (this.totCustomers != null) {
      json[r'totCustomers'] = this.totCustomers;
    } else {
      json[r'totCustomers'] = null;
    }
    if (this.arrived != null) {
      json[r'arrived'] = this.arrived;
    } else {
      json[r'arrived'] = null;
    }
    if (this.refused != null) {
      json[r'refused'] = this.refused;
    } else {
      json[r'refused'] = null;
    }
    if (this.noShow != null) {
      json[r'noShow'] = this.noShow;
    } else {
      json[r'noShow'] = null;
    }
    if (this.deleted != null) {
      json[r'deleted'] = this.deleted;
    } else {
      json[r'deleted'] = null;
    }
    return json;
  }

  /// Returns a new [WeekMetrics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WeekMetrics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WeekMetrics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WeekMetrics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WeekMetrics(
        totBookings: mapValueOfType<int>(json, r'totBookings'),
        totCustomers: mapValueOfType<int>(json, r'totCustomers'),
        arrived: mapValueOfType<int>(json, r'arrived'),
        refused: mapValueOfType<int>(json, r'refused'),
        noShow: mapValueOfType<int>(json, r'noShow'),
        deleted: mapValueOfType<int>(json, r'deleted'),
      );
    }
    return null;
  }

  static List<WeekMetrics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WeekMetrics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WeekMetrics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WeekMetrics> mapFromJson(dynamic json) {
    final map = <String, WeekMetrics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WeekMetrics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WeekMetrics-objects as value to a dart map
  static Map<String, List<WeekMetrics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WeekMetrics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WeekMetrics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

