//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GeneralMessage {
  /// Returns a new [GeneralMessage] instance.
  GeneralMessage({
    this.whatsAppEnabled,
    this.emailEnabled,
    this.smsEnabled,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? whatsAppEnabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailEnabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? smsEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GeneralMessage &&
    other.whatsAppEnabled == whatsAppEnabled &&
    other.emailEnabled == emailEnabled &&
    other.smsEnabled == smsEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (whatsAppEnabled == null ? 0 : whatsAppEnabled!.hashCode) +
    (emailEnabled == null ? 0 : emailEnabled!.hashCode) +
    (smsEnabled == null ? 0 : smsEnabled!.hashCode);

  @override
  String toString() => 'GeneralMessage[whatsAppEnabled=$whatsAppEnabled, emailEnabled=$emailEnabled, smsEnabled=$smsEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.whatsAppEnabled != null) {
      json[r'whatsAppEnabled'] = this.whatsAppEnabled;
    } else {
      json[r'whatsAppEnabled'] = null;
    }
    if (this.emailEnabled != null) {
      json[r'emailEnabled'] = this.emailEnabled;
    } else {
      json[r'emailEnabled'] = null;
    }
    if (this.smsEnabled != null) {
      json[r'smsEnabled'] = this.smsEnabled;
    } else {
      json[r'smsEnabled'] = null;
    }
    return json;
  }

  /// Returns a new [GeneralMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GeneralMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GeneralMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GeneralMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GeneralMessage(
        whatsAppEnabled: mapValueOfType<bool>(json, r'whatsAppEnabled'),
        emailEnabled: mapValueOfType<bool>(json, r'emailEnabled'),
        smsEnabled: mapValueOfType<bool>(json, r'smsEnabled'),
      );
    }
    return null;
  }

  static List<GeneralMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GeneralMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GeneralMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GeneralMessage> mapFromJson(dynamic json) {
    final map = <String, GeneralMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GeneralMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GeneralMessage-objects as value to a dart map
  static Map<String, List<GeneralMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GeneralMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GeneralMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

