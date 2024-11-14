//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/booking_controller_api.dart';
part 'api/customer_controller_api.dart';
part 'api/form_controller_api.dart';
part 'api/restaurant_controller_api.dart';

part 'model/booking_dto.dart';
part 'model/customer_dto.dart';
part 'model/employee_dto.dart';
part 'model/employee_presence_report_dto.dart';
part 'model/employee_report_summary_dto.dart';
part 'model/form_dto.dart';
part 'model/holidays_dto.dart';
part 'model/mobile_device_details.dart';
part 'model/opening_hours_dto.dart';
part 'model/restaurant_dto.dart';
part 'model/special_day_dto.dart';
part 'model/standard_message.dart';
part 'model/time_range.dart';
part 'model/time_slot.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
