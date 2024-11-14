//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AllChatListDataDTO {
  /// Returns a new [AllChatListDataDTO] instance.
  AllChatListDataDTO({
    this.name,
    this.unreadCount,
    this.timestamp,
    this.fromNumber,
    this.toNumber,
    this.body,
    this.fromMe,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? unreadCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? timestamp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fromNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? toNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? body;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? fromMe;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AllChatListDataDTO &&
    other.name == name &&
    other.unreadCount == unreadCount &&
    other.timestamp == timestamp &&
    other.fromNumber == fromNumber &&
    other.toNumber == toNumber &&
    other.body == body &&
    other.fromMe == fromMe;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (unreadCount == null ? 0 : unreadCount!.hashCode) +
    (timestamp == null ? 0 : timestamp!.hashCode) +
    (fromNumber == null ? 0 : fromNumber!.hashCode) +
    (toNumber == null ? 0 : toNumber!.hashCode) +
    (body == null ? 0 : body!.hashCode) +
    (fromMe == null ? 0 : fromMe!.hashCode);

  @override
  String toString() => 'AllChatListDataDTO[name=$name, unreadCount=$unreadCount, timestamp=$timestamp, fromNumber=$fromNumber, toNumber=$toNumber, body=$body, fromMe=$fromMe]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.unreadCount != null) {
      json[r'unreadCount'] = this.unreadCount;
    } else {
      json[r'unreadCount'] = null;
    }
    if (this.timestamp != null) {
      json[r'timestamp'] = this.timestamp;
    } else {
      json[r'timestamp'] = null;
    }
    if (this.fromNumber != null) {
      json[r'fromNumber'] = this.fromNumber;
    } else {
      json[r'fromNumber'] = null;
    }
    if (this.toNumber != null) {
      json[r'toNumber'] = this.toNumber;
    } else {
      json[r'toNumber'] = null;
    }
    if (this.body != null) {
      json[r'body'] = this.body;
    } else {
      json[r'body'] = null;
    }
    if (this.fromMe != null) {
      json[r'fromMe'] = this.fromMe;
    } else {
      json[r'fromMe'] = null;
    }
    return json;
  }

  /// Returns a new [AllChatListDataDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AllChatListDataDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AllChatListDataDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AllChatListDataDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AllChatListDataDTO(
        name: mapValueOfType<String>(json, r'name'),
        unreadCount: mapValueOfType<int>(json, r'unreadCount'),
        timestamp: mapValueOfType<int>(json, r'timestamp'),
        fromNumber: mapValueOfType<String>(json, r'fromNumber'),
        toNumber: mapValueOfType<String>(json, r'toNumber'),
        body: mapValueOfType<String>(json, r'body'),
        fromMe: mapValueOfType<bool>(json, r'fromMe'),
      );
    }
    return null;
  }

  static List<AllChatListDataDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AllChatListDataDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AllChatListDataDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AllChatListDataDTO> mapFromJson(dynamic json) {
    final map = <String, AllChatListDataDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AllChatListDataDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AllChatListDataDTO-objects as value to a dart map
  static Map<String, List<AllChatListDataDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AllChatListDataDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AllChatListDataDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

