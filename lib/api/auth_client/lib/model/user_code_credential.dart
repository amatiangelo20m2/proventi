//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserCodeCredential {
  /// Returns a new [UserCodeCredential] instance.
  UserCodeCredential({
    this.userCode,
    this.password,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserCodeCredential &&
    other.userCode == userCode &&
    other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userCode == null ? 0 : userCode!.hashCode) +
    (password == null ? 0 : password!.hashCode);

  @override
  String toString() => 'UserCodeCredential[userCode=$userCode, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.userCode != null) {
      json[r'userCode'] = this.userCode;
    } else {
      json[r'userCode'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
    return json;
  }

  /// Returns a new [UserCodeCredential] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserCodeCredential? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserCodeCredential[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserCodeCredential[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserCodeCredential(
        userCode: mapValueOfType<String>(json, r'userCode'),
        password: mapValueOfType<String>(json, r'password'),
      );
    }
    return null;
  }

  static List<UserCodeCredential> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserCodeCredential>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserCodeCredential.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserCodeCredential> mapFromJson(dynamic json) {
    final map = <String, UserCodeCredential>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserCodeCredential.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserCodeCredential-objects as value to a dart map
  static Map<String, List<UserCodeCredential>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserCodeCredential>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserCodeCredential.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

