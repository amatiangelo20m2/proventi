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

part 'api/branch_controller_api.dart';
part 'api/order_controller_api.dart';
part 'api/storage_controller_api.dart';
part 'api/supplier_controller_api.dart';

part 'model/branch_creation_entity.dart';
part 'model/branch_response_entity.dart';
part 'model/counter_entity.dart';
part 'model/create_order_entity.dart';
part 'model/detailed_product_recap.dart';
part 'model/employee_entity.dart';
part 'model/excel_data_archived_order.dart';
part 'model/inventario_dto.dart';
part 'model/inventory_action.dart';
part 'model/local_time.dart';
part 'model/order_dto.dart';
part 'model/order_item_dto.dart';
part 'model/order_result_recap.dart';
part 'model/orders_counter.dart';
part 'model/product_dto.dart';
part 'model/reservation_counter.dart';
part 'model/storage_dto.dart';
part 'model/supplier_dto.dart';
part 'model/transaction_inventory_request.dart';
part 'model/transaction_item.dart';
part 'model/venti_metri_quadri_data.dart';


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