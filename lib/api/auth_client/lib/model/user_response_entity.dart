//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserResponseEntity {
  /// Returns a new [UserResponseEntity] instance.
  UserResponseEntity({
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.status,
    this.userCode,
    this.fcmToken,
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

  UserResponseEntityStatusEnum? status;

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
  String? fcmToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserResponseEntity &&
    other.name == name &&
    other.phone == phone &&
    other.email == email &&
    other.avatar == avatar &&
    other.status == status &&
    other.userCode == userCode &&
    other.fcmToken == fcmToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (avatar == null ? 0 : avatar!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (userCode == null ? 0 : userCode!.hashCode) +
    (fcmToken == null ? 0 : fcmToken!.hashCode);

  @override
  String toString() => 'UserResponseEntity[name=$name, phone=$phone, email=$email, avatar=$avatar, status=$status, userCode=$userCode, fcmToken=$fcmToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.userCode != null) {
      json[r'userCode'] = this.userCode;
    } else {
      json[r'userCode'] = null;
    }
    if (this.fcmToken != null) {
      json[r'fcmToken'] = this.fcmToken;
    } else {
      json[r'fcmToken'] = null;
    }
    return json;
  }

  /// Returns a new [UserResponseEntity] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserResponseEntity? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserResponseEntity[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserResponseEntity[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserResponseEntity(
        name: mapValueOfType<String>(json, r'name'),
        phone: mapValueOfType<String>(json, r'phone'),
        email: mapValueOfType<String>(json, r'email'),
        avatar: mapValueOfType<String>(json, r'avatar'),
        status: UserResponseEntityStatusEnum.fromJson(json[r'status']),
        userCode: mapValueOfType<String>(json, r'userCode'),
        fcmToken: mapValueOfType<String>(json, r'fcmToken'),
      );
    }
    return null;
  }

  static List<UserResponseEntity> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserResponseEntity>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserResponseEntity.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserResponseEntity> mapFromJson(dynamic json) {
    final map = <String, UserResponseEntity>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserResponseEntity.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserResponseEntity-objects as value to a dart map
  static Map<String, List<UserResponseEntity>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserResponseEntity>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserResponseEntity.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UserResponseEntityStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UserResponseEntityStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ONLINE = UserResponseEntityStatusEnum._(r'ONLINE');
  static const AWAY = UserResponseEntityStatusEnum._(r'AWAY');
  static const BUSY = UserResponseEntityStatusEnum._(r'BUSY');
  static const INVISIBLE = UserResponseEntityStatusEnum._(r'INVISIBLE');

  /// List of all possible values in this [enum][UserResponseEntityStatusEnum].
  static const values = <UserResponseEntityStatusEnum>[
    ONLINE,
    AWAY,
    BUSY,
    INVISIBLE,
  ];

  static UserResponseEntityStatusEnum? fromJson(dynamic value) => UserResponseEntityStatusEnumTypeTransformer().decode(value);

  static List<UserResponseEntityStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserResponseEntityStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserResponseEntityStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserResponseEntityStatusEnum] to String,
/// and [decode] dynamic data back to [UserResponseEntityStatusEnum].
class UserResponseEntityStatusEnumTypeTransformer {
  factory UserResponseEntityStatusEnumTypeTransformer() => _instance ??= const UserResponseEntityStatusEnumTypeTransformer._();

  const UserResponseEntityStatusEnumTypeTransformer._();

  String encode(UserResponseEntityStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserResponseEntityStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserResponseEntityStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ONLINE': return UserResponseEntityStatusEnum.ONLINE;
        case r'AWAY': return UserResponseEntityStatusEnum.AWAY;
        case r'BUSY': return UserResponseEntityStatusEnum.BUSY;
        case r'INVISIBLE': return UserResponseEntityStatusEnum.INVISIBLE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserResponseEntityStatusEnumTypeTransformer] instance.
  static UserResponseEntityStatusEnumTypeTransformer? _instance;
}


