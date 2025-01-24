//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingsMetrics {
  /// Returns a new [BookingsMetrics] instance.
  BookingsMetrics({
    this.overview,
    this.labels = const [],
    this.series = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Overview? overview;

  List<String> labels;

  Map<String, List<Series>> series;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingsMetrics &&
    other.overview == overview &&
    _deepEquality.equals(other.labels, labels) &&
    _deepEquality.equals(other.series, series);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (overview == null ? 0 : overview!.hashCode) +
    (labels.hashCode) +
    (series.hashCode);

  @override
  String toString() => 'BookingsMetrics[overview=$overview, labels=$labels, series=$series]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.overview != null) {
      json[r'overview'] = this.overview;
    } else {
      json[r'overview'] = null;
    }
      json[r'labels'] = this.labels;
      json[r'series'] = this.series;
    return json;
  }

  /// Returns a new [BookingsMetrics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingsMetrics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BookingsMetrics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BookingsMetrics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BookingsMetrics(
        overview: Overview.fromJson(json[r'overview']),
        labels: json[r'labels'] is Iterable
            ? (json[r'labels'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        series: json[r'series'] == null
          ? const {}
            : Series.mapListFromJson(json[r'series']),
      );
    }
    return null;
  }

  static List<BookingsMetrics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingsMetrics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingsMetrics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingsMetrics> mapFromJson(dynamic json) {
    final map = <String, BookingsMetrics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingsMetrics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingsMetrics-objects as value to a dart map
  static Map<String, List<BookingsMetrics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingsMetrics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingsMetrics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

