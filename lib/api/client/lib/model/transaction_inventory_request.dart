//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TransactionInventoryRequest {
  /// Returns a new [TransactionInventoryRequest] instance.
  TransactionInventoryRequest({
    this.user,
    this.storageId,
    this.transactionItemList = const [],
    this.operationType,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? user;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? storageId;

  List<TransactionItem> transactionItemList;

  TransactionInventoryRequestOperationTypeEnum? operationType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TransactionInventoryRequest &&
    other.user == user &&
    other.storageId == storageId &&
    _deepEquality.equals(other.transactionItemList, transactionItemList) &&
    other.operationType == operationType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (user == null ? 0 : user!.hashCode) +
    (storageId == null ? 0 : storageId!.hashCode) +
    (transactionItemList.hashCode) +
    (operationType == null ? 0 : operationType!.hashCode);

  @override
  String toString() => 'TransactionInventoryRequest[user=$user, storageId=$storageId, transactionItemList=$transactionItemList, operationType=$operationType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
    if (this.storageId != null) {
      json[r'storageId'] = this.storageId;
    } else {
      json[r'storageId'] = null;
    }
      json[r'transactionItemList'] = this.transactionItemList;
    if (this.operationType != null) {
      json[r'operationType'] = this.operationType;
    } else {
      json[r'operationType'] = null;
    }
    return json;
  }

  /// Returns a new [TransactionInventoryRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TransactionInventoryRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TransactionInventoryRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TransactionInventoryRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TransactionInventoryRequest(
        user: mapValueOfType<String>(json, r'user'),
        storageId: mapValueOfType<int>(json, r'storageId'),
        transactionItemList: TransactionItem.listFromJson(json[r'transactionItemList']),
        operationType: TransactionInventoryRequestOperationTypeEnum.fromJson(json[r'operationType']),
      );
    }
    return null;
  }

  static List<TransactionInventoryRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TransactionInventoryRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TransactionInventoryRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TransactionInventoryRequest> mapFromJson(dynamic json) {
    final map = <String, TransactionInventoryRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TransactionInventoryRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TransactionInventoryRequest-objects as value to a dart map
  static Map<String, List<TransactionInventoryRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TransactionInventoryRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TransactionInventoryRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class TransactionInventoryRequestOperationTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const TransactionInventoryRequestOperationTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CREATION = TransactionInventoryRequestOperationTypeEnum._(r'CREATION');
  static const INSERTION = TransactionInventoryRequestOperationTypeEnum._(r'INSERTION');
  static const REMOVAL = TransactionInventoryRequestOperationTypeEnum._(r'REMOVAL');

  /// List of all possible values in this [enum][TransactionInventoryRequestOperationTypeEnum].
  static const values = <TransactionInventoryRequestOperationTypeEnum>[
    CREATION,
    INSERTION,
    REMOVAL,
  ];

  static TransactionInventoryRequestOperationTypeEnum? fromJson(dynamic value) => TransactionInventoryRequestOperationTypeEnumTypeTransformer().decode(value);

  static List<TransactionInventoryRequestOperationTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TransactionInventoryRequestOperationTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TransactionInventoryRequestOperationTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TransactionInventoryRequestOperationTypeEnum] to String,
/// and [decode] dynamic data back to [TransactionInventoryRequestOperationTypeEnum].
class TransactionInventoryRequestOperationTypeEnumTypeTransformer {
  factory TransactionInventoryRequestOperationTypeEnumTypeTransformer() => _instance ??= const TransactionInventoryRequestOperationTypeEnumTypeTransformer._();

  const TransactionInventoryRequestOperationTypeEnumTypeTransformer._();

  String encode(TransactionInventoryRequestOperationTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TransactionInventoryRequestOperationTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TransactionInventoryRequestOperationTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CREATION': return TransactionInventoryRequestOperationTypeEnum.CREATION;
        case r'INSERTION': return TransactionInventoryRequestOperationTypeEnum.INSERTION;
        case r'REMOVAL': return TransactionInventoryRequestOperationTypeEnum.REMOVAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TransactionInventoryRequestOperationTypeEnumTypeTransformer] instance.
  static TransactionInventoryRequestOperationTypeEnumTypeTransformer? _instance;
}


