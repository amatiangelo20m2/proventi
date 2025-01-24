//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomersMetrics {
  /// Returns a new [CustomersMetrics] instance.
  CustomersMetrics({
    this.newVsReturning,
    this.refusedVsNoShow,
    this.age,
    this.language,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Metric? newVsReturning;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Metric? refusedVsNoShow;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Metric? age;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Metric? language;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomersMetrics &&
    other.newVsReturning == newVsReturning &&
    other.refusedVsNoShow == refusedVsNoShow &&
    other.age == age &&
    other.language == language;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (newVsReturning == null ? 0 : newVsReturning!.hashCode) +
    (refusedVsNoShow == null ? 0 : refusedVsNoShow!.hashCode) +
    (age == null ? 0 : age!.hashCode) +
    (language == null ? 0 : language!.hashCode);

  @override
  String toString() => 'CustomersMetrics[newVsReturning=$newVsReturning, refusedVsNoShow=$refusedVsNoShow, age=$age, language=$language]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.newVsReturning != null) {
      json[r'newVsReturning'] = this.newVsReturning;
    } else {
      json[r'newVsReturning'] = null;
    }
    if (this.refusedVsNoShow != null) {
      json[r'refusedVsNoShow'] = this.refusedVsNoShow;
    } else {
      json[r'refusedVsNoShow'] = null;
    }
    if (this.age != null) {
      json[r'age'] = this.age;
    } else {
      json[r'age'] = null;
    }
    if (this.language != null) {
      json[r'language'] = this.language;
    } else {
      json[r'language'] = null;
    }
    return json;
  }

  /// Returns a new [CustomersMetrics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomersMetrics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomersMetrics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomersMetrics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomersMetrics(
        newVsReturning: Metric.fromJson(json[r'newVsReturning']),
        refusedVsNoShow: Metric.fromJson(json[r'refusedVsNoShow']),
        age: Metric.fromJson(json[r'age']),
        language: Metric.fromJson(json[r'language']),
      );
    }
    return null;
  }

  static List<CustomersMetrics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomersMetrics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomersMetrics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomersMetrics> mapFromJson(dynamic json) {
    final map = <String, CustomersMetrics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomersMetrics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomersMetrics-objects as value to a dart map
  static Map<String, List<CustomersMetrics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomersMetrics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomersMetrics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

