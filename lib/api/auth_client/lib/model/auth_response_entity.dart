//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthResponseEntity {
  /// Returns a new [AuthResponseEntity] instance.
  AuthResponseEntity({
    this.user,
    this.accessToken,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UserResponseEntity? user;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accessToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthResponseEntity &&
    other.user == user &&
    other.accessToken == accessToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (user == null ? 0 : user!.hashCode) +
    (accessToken == null ? 0 : accessToken!.hashCode);

  @override
  String toString() => 'AuthResponseEntity[user=$user, accessToken=$accessToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
    if (this.accessToken != null) {
      json[r'accessToken'] = this.accessToken;
    } else {
      json[r'accessToken'] = null;
    }
    return json;
  }

  /// Returns a new [AuthResponseEntity] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthResponseEntity? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthResponseEntity[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthResponseEntity[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthResponseEntity(
        user: UserResponseEntity.fromJson(json[r'user']),
        accessToken: mapValueOfType<String>(json, r'accessToken'),
      );
    }
    return null;
  }

  static List<AuthResponseEntity> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthResponseEntity>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthResponseEntity.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthResponseEntity> mapFromJson(dynamic json) {
    final map = <String, AuthResponseEntity>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthResponseEntity.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthResponseEntity-objects as value to a dart map
  static Map<String, List<AuthResponseEntity>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuthResponseEntity>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuthResponseEntity.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

