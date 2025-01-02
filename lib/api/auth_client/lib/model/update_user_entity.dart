//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateUserEntity {
  /// Returns a new [UpdateUserEntity] instance.
  UpdateUserEntity({
    this.userId,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.profileStatus,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? userId;

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
  String? phone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? avatar;

  UpdateUserEntityProfileStatusEnum? profileStatus;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateUserEntity &&
    other.userId == userId &&
    other.name == name &&
    other.phone == phone &&
    other.email == email &&
    other.avatar == avatar &&
    other.profileStatus == profileStatus;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userId == null ? 0 : userId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (avatar == null ? 0 : avatar!.hashCode) +
    (profileStatus == null ? 0 : profileStatus!.hashCode);

  @override
  String toString() => 'UpdateUserEntity[userId=$userId, name=$name, phone=$phone, email=$email, avatar=$avatar, profileStatus=$profileStatus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.userId != null) {
      json[r'userId'] = this.userId;
    } else {
      json[r'userId'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.avatar != null) {
      json[r'avatar'] = this.avatar;
    } else {
      json[r'avatar'] = null;
    }
    if (this.profileStatus != null) {
      json[r'profileStatus'] = this.profileStatus;
    } else {
      json[r'profileStatus'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateUserEntity] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateUserEntity? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateUserEntity[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateUserEntity[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateUserEntity(
        userId: mapValueOfType<int>(json, r'userId'),
        name: mapValueOfType<String>(json, r'name'),
        phone: mapValueOfType<String>(json, r'phone'),
        email: mapValueOfType<String>(json, r'email'),
        avatar: mapValueOfType<String>(json, r'avatar'),
        profileStatus: UpdateUserEntityProfileStatusEnum.fromJson(json[r'profileStatus']),
      );
    }
    return null;
  }

  static List<UpdateUserEntity> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateUserEntity>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateUserEntity.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateUserEntity> mapFromJson(dynamic json) {
    final map = <String, UpdateUserEntity>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateUserEntity.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateUserEntity-objects as value to a dart map
  static Map<String, List<UpdateUserEntity>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateUserEntity>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateUserEntity.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UpdateUserEntityProfileStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateUserEntityProfileStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ONLINE = UpdateUserEntityProfileStatusEnum._(r'ONLINE');
  static const AWAY = UpdateUserEntityProfileStatusEnum._(r'AWAY');
  static const BUSY = UpdateUserEntityProfileStatusEnum._(r'BUSY');
  static const INVISIBLE = UpdateUserEntityProfileStatusEnum._(r'INVISIBLE');

  /// List of all possible values in this [enum][UpdateUserEntityProfileStatusEnum].
  static const values = <UpdateUserEntityProfileStatusEnum>[
    ONLINE,
    AWAY,
    BUSY,
    INVISIBLE,
  ];

  static UpdateUserEntityProfileStatusEnum? fromJson(dynamic value) => UpdateUserEntityProfileStatusEnumTypeTransformer().decode(value);

  static List<UpdateUserEntityProfileStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateUserEntityProfileStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateUserEntityProfileStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateUserEntityProfileStatusEnum] to String,
/// and [decode] dynamic data back to [UpdateUserEntityProfileStatusEnum].
class UpdateUserEntityProfileStatusEnumTypeTransformer {
  factory UpdateUserEntityProfileStatusEnumTypeTransformer() => _instance ??= const UpdateUserEntityProfileStatusEnumTypeTransformer._();

  const UpdateUserEntityProfileStatusEnumTypeTransformer._();

  String encode(UpdateUserEntityProfileStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateUserEntityProfileStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateUserEntityProfileStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ONLINE': return UpdateUserEntityProfileStatusEnum.ONLINE;
        case r'AWAY': return UpdateUserEntityProfileStatusEnum.AWAY;
        case r'BUSY': return UpdateUserEntityProfileStatusEnum.BUSY;
        case r'INVISIBLE': return UpdateUserEntityProfileStatusEnum.INVISIBLE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateUserEntityProfileStatusEnumTypeTransformer] instance.
  static UpdateUserEntityProfileStatusEnumTypeTransformer? _instance;
}


