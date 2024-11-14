//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatMessagesResponseDTO {
  /// Returns a new [ChatMessagesResponseDTO] instance.
  ChatMessagesResponseDTO({
    this.status,
    this.instanceId,
    this.data = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? instanceId;

  Set<MessageDataDTO> data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatMessagesResponseDTO &&
    other.status == status &&
    other.instanceId == instanceId &&
    _deepEquality.equals(other.data, data);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status == null ? 0 : status!.hashCode) +
    (instanceId == null ? 0 : instanceId!.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'ChatMessagesResponseDTO[status=$status, instanceId=$instanceId, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.instanceId != null) {
      json[r'instanceId'] = this.instanceId;
    } else {
      json[r'instanceId'] = null;
    }
      json[r'data'] = this.data.toList(growable: false);
    return json;
  }

  /// Returns a new [ChatMessagesResponseDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatMessagesResponseDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatMessagesResponseDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatMessagesResponseDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatMessagesResponseDTO(
        status: mapValueOfType<String>(json, r'status'),
        instanceId: mapValueOfType<String>(json, r'instanceId'),
        data: MessageDataDTO.listFromJson(json[r'data']).toSet(),
      );
    }
    return null;
  }

  static List<ChatMessagesResponseDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatMessagesResponseDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatMessagesResponseDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatMessagesResponseDTO> mapFromJson(dynamic json) {
    final map = <String, ChatMessagesResponseDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatMessagesResponseDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatMessagesResponseDTO-objects as value to a dart map
  static Map<String, List<ChatMessagesResponseDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatMessagesResponseDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatMessagesResponseDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

