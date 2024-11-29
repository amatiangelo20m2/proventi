//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomerHistory {
  /// Returns a new [CustomerHistory] instance.
  CustomerHistory({
    this.customerId,
    this.firstName,
    this.lastName,
    this.prefix,
    this.phone,
    this.email,
    this.branchCode,
    this.inAttesaCount,
    this.modificatoDaUtenteCount,
    this.preConfermaPagamentoCount,
    this.confermatoCount,
    this.arrivatoCount,
    this.nonArrivatoCount,
    this.rifiutatoCount,
    this.listaAttesaCount,
    this.avvisatoListaAttesaCount,
    this.eliminatoCount,
    this.lastBookingDate,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? customerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? firstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? prefix;

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
  String? branchCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? inAttesaCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? modificatoDaUtenteCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? preConfermaPagamentoCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? confermatoCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? arrivatoCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nonArrivatoCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? rifiutatoCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? listaAttesaCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? avvisatoListaAttesaCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? eliminatoCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? lastBookingDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomerHistory &&
    other.customerId == customerId &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.prefix == prefix &&
    other.phone == phone &&
    other.email == email &&
    other.branchCode == branchCode &&
    other.inAttesaCount == inAttesaCount &&
    other.modificatoDaUtenteCount == modificatoDaUtenteCount &&
    other.preConfermaPagamentoCount == preConfermaPagamentoCount &&
    other.confermatoCount == confermatoCount &&
    other.arrivatoCount == arrivatoCount &&
    other.nonArrivatoCount == nonArrivatoCount &&
    other.rifiutatoCount == rifiutatoCount &&
    other.listaAttesaCount == listaAttesaCount &&
    other.avvisatoListaAttesaCount == avvisatoListaAttesaCount &&
    other.eliminatoCount == eliminatoCount &&
    other.lastBookingDate == lastBookingDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (customerId == null ? 0 : customerId!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (prefix == null ? 0 : prefix!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (branchCode == null ? 0 : branchCode!.hashCode) +
    (inAttesaCount == null ? 0 : inAttesaCount!.hashCode) +
    (modificatoDaUtenteCount == null ? 0 : modificatoDaUtenteCount!.hashCode) +
    (preConfermaPagamentoCount == null ? 0 : preConfermaPagamentoCount!.hashCode) +
    (confermatoCount == null ? 0 : confermatoCount!.hashCode) +
    (arrivatoCount == null ? 0 : arrivatoCount!.hashCode) +
    (nonArrivatoCount == null ? 0 : nonArrivatoCount!.hashCode) +
    (rifiutatoCount == null ? 0 : rifiutatoCount!.hashCode) +
    (listaAttesaCount == null ? 0 : listaAttesaCount!.hashCode) +
    (avvisatoListaAttesaCount == null ? 0 : avvisatoListaAttesaCount!.hashCode) +
    (eliminatoCount == null ? 0 : eliminatoCount!.hashCode) +
    (lastBookingDate == null ? 0 : lastBookingDate!.hashCode);

  @override
  String toString() => 'CustomerHistory[customerId=$customerId, firstName=$firstName, lastName=$lastName, prefix=$prefix, phone=$phone, email=$email, branchCode=$branchCode, inAttesaCount=$inAttesaCount, modificatoDaUtenteCount=$modificatoDaUtenteCount, preConfermaPagamentoCount=$preConfermaPagamentoCount, confermatoCount=$confermatoCount, arrivatoCount=$arrivatoCount, nonArrivatoCount=$nonArrivatoCount, rifiutatoCount=$rifiutatoCount, listaAttesaCount=$listaAttesaCount, avvisatoListaAttesaCount=$avvisatoListaAttesaCount, eliminatoCount=$eliminatoCount, lastBookingDate=$lastBookingDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.customerId != null) {
      json[r'customerId'] = this.customerId;
    } else {
      json[r'customerId'] = null;
    }
    if (this.firstName != null) {
      json[r'firstName'] = this.firstName;
    } else {
      json[r'firstName'] = null;
    }
    if (this.lastName != null) {
      json[r'lastName'] = this.lastName;
    } else {
      json[r'lastName'] = null;
    }
    if (this.prefix != null) {
      json[r'prefix'] = this.prefix;
    } else {
      json[r'prefix'] = null;
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
    if (this.branchCode != null) {
      json[r'branchCode'] = this.branchCode;
    } else {
      json[r'branchCode'] = null;
    }
    if (this.inAttesaCount != null) {
      json[r'inAttesaCount'] = this.inAttesaCount;
    } else {
      json[r'inAttesaCount'] = null;
    }
    if (this.modificatoDaUtenteCount != null) {
      json[r'modificatoDaUtenteCount'] = this.modificatoDaUtenteCount;
    } else {
      json[r'modificatoDaUtenteCount'] = null;
    }
    if (this.preConfermaPagamentoCount != null) {
      json[r'preConfermaPagamentoCount'] = this.preConfermaPagamentoCount;
    } else {
      json[r'preConfermaPagamentoCount'] = null;
    }
    if (this.confermatoCount != null) {
      json[r'confermatoCount'] = this.confermatoCount;
    } else {
      json[r'confermatoCount'] = null;
    }
    if (this.arrivatoCount != null) {
      json[r'arrivatoCount'] = this.arrivatoCount;
    } else {
      json[r'arrivatoCount'] = null;
    }
    if (this.nonArrivatoCount != null) {
      json[r'nonArrivatoCount'] = this.nonArrivatoCount;
    } else {
      json[r'nonArrivatoCount'] = null;
    }
    if (this.rifiutatoCount != null) {
      json[r'rifiutatoCount'] = this.rifiutatoCount;
    } else {
      json[r'rifiutatoCount'] = null;
    }
    if (this.listaAttesaCount != null) {
      json[r'listaAttesaCount'] = this.listaAttesaCount;
    } else {
      json[r'listaAttesaCount'] = null;
    }
    if (this.avvisatoListaAttesaCount != null) {
      json[r'avvisatoListaAttesaCount'] = this.avvisatoListaAttesaCount;
    } else {
      json[r'avvisatoListaAttesaCount'] = null;
    }
    if (this.eliminatoCount != null) {
      json[r'eliminatoCount'] = this.eliminatoCount;
    } else {
      json[r'eliminatoCount'] = null;
    }
    if (this.lastBookingDate != null) {
      json[r'lastBookingDate'] = _dateFormatter.format(this.lastBookingDate!.toUtc());
    } else {
      json[r'lastBookingDate'] = null;
    }
    return json;
  }

  /// Returns a new [CustomerHistory] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomerHistory? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomerHistory[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomerHistory[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomerHistory(
        customerId: mapValueOfType<int>(json, r'customerId'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        prefix: mapValueOfType<String>(json, r'prefix'),
        phone: mapValueOfType<String>(json, r'phone'),
        email: mapValueOfType<String>(json, r'email'),
        branchCode: mapValueOfType<String>(json, r'branchCode'),
        inAttesaCount: mapValueOfType<int>(json, r'inAttesaCount'),
        modificatoDaUtenteCount: mapValueOfType<int>(json, r'modificatoDaUtenteCount'),
        preConfermaPagamentoCount: mapValueOfType<int>(json, r'preConfermaPagamentoCount'),
        confermatoCount: mapValueOfType<int>(json, r'confermatoCount'),
        arrivatoCount: mapValueOfType<int>(json, r'arrivatoCount'),
        nonArrivatoCount: mapValueOfType<int>(json, r'nonArrivatoCount'),
        rifiutatoCount: mapValueOfType<int>(json, r'rifiutatoCount'),
        listaAttesaCount: mapValueOfType<int>(json, r'listaAttesaCount'),
        avvisatoListaAttesaCount: mapValueOfType<int>(json, r'avvisatoListaAttesaCount'),
        eliminatoCount: mapValueOfType<int>(json, r'eliminatoCount'),
        lastBookingDate: mapDateTime(json, r'lastBookingDate', r''),
      );
    }
    return null;
  }

  static List<CustomerHistory> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomerHistory>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomerHistory.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomerHistory> mapFromJson(dynamic json) {
    final map = <String, CustomerHistory>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomerHistory.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomerHistory-objects as value to a dart map
  static Map<String, List<CustomerHistory>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomerHistory>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomerHistory.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

