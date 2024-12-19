//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticApproveRefusedBookConf {
  /// Returns a new [AutomaticApproveRefusedBookConf] instance.
  AutomaticApproveRefusedBookConf({
    this.date,
    this.doAcceptBookingLunch,
    this.doRefuseBookingLunch,
    this.doAcceptBookingDinner,
    this.doRefuseBookingDinner,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? date;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? doAcceptBookingLunch;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? doRefuseBookingLunch;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? doAcceptBookingDinner;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? doRefuseBookingDinner;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticApproveRefusedBookConf &&
    other.date == date &&
    other.doAcceptBookingLunch == doAcceptBookingLunch &&
    other.doRefuseBookingLunch == doRefuseBookingLunch &&
    other.doAcceptBookingDinner == doAcceptBookingDinner &&
    other.doRefuseBookingDinner == doRefuseBookingDinner;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (date == null ? 0 : date!.hashCode) +
    (doAcceptBookingLunch == null ? 0 : doAcceptBookingLunch!.hashCode) +
    (doRefuseBookingLunch == null ? 0 : doRefuseBookingLunch!.hashCode) +
    (doAcceptBookingDinner == null ? 0 : doAcceptBookingDinner!.hashCode) +
    (doRefuseBookingDinner == null ? 0 : doRefuseBookingDinner!.hashCode);

  @override
  String toString() => 'AutomaticApproveRefusedBookConf[date=$date, doAcceptBookingLunch=$doAcceptBookingLunch, doRefuseBookingLunch=$doRefuseBookingLunch, doAcceptBookingDinner=$doAcceptBookingDinner, doRefuseBookingDinner=$doRefuseBookingDinner]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.date != null) {
      json[r'date'] = _dateFormatter.format(this.date!.toUtc());
    } else {
      json[r'date'] = null;
    }
    if (this.doAcceptBookingLunch != null) {
      json[r'doAcceptBookingLunch'] = this.doAcceptBookingLunch;
    } else {
      json[r'doAcceptBookingLunch'] = null;
    }
    if (this.doRefuseBookingLunch != null) {
      json[r'doRefuseBookingLunch'] = this.doRefuseBookingLunch;
    } else {
      json[r'doRefuseBookingLunch'] = null;
    }
    if (this.doAcceptBookingDinner != null) {
      json[r'doAcceptBookingDinner'] = this.doAcceptBookingDinner;
    } else {
      json[r'doAcceptBookingDinner'] = null;
    }
    if (this.doRefuseBookingDinner != null) {
      json[r'doRefuseBookingDinner'] = this.doRefuseBookingDinner;
    } else {
      json[r'doRefuseBookingDinner'] = null;
    }
    return json;
  }

  /// Returns a new [AutomaticApproveRefusedBookConf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticApproveRefusedBookConf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AutomaticApproveRefusedBookConf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AutomaticApproveRefusedBookConf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AutomaticApproveRefusedBookConf(
        date: mapDateTime(json, r'date', r''),
        doAcceptBookingLunch: mapValueOfType<bool>(json, r'doAcceptBookingLunch'),
        doRefuseBookingLunch: mapValueOfType<bool>(json, r'doRefuseBookingLunch'),
        doAcceptBookingDinner: mapValueOfType<bool>(json, r'doAcceptBookingDinner'),
        doRefuseBookingDinner: mapValueOfType<bool>(json, r'doRefuseBookingDinner'),
      );
    }
    return null;
  }

  static List<AutomaticApproveRefusedBookConf> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticApproveRefusedBookConf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticApproveRefusedBookConf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticApproveRefusedBookConf> mapFromJson(dynamic json) {
    final map = <String, AutomaticApproveRefusedBookConf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticApproveRefusedBookConf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticApproveRefusedBookConf-objects as value to a dart map
  static Map<String, List<AutomaticApproveRefusedBookConf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticApproveRefusedBookConf>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticApproveRefusedBookConf.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

