//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

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

part 'api/advertisement_controller_api.dart';
part 'api/category_controller_api.dart';
part 'api/fixture_controller_api.dart';
part 'api/heading_controller_api.dart';
part 'api/highlight_controller_api.dart';
part 'api/league_controller_api.dart';
part 'api/news_article_controller_api.dart';
part 'api/order_controller_api.dart';
part 'api/product_controller_api.dart';
part 'api/product_variant_controller_api.dart';
part 'api/promotion_product_controller_api.dart';
part 'api/review_controller_api.dart';
part 'api/size_controller_api.dart';
part 'api/sync_controller_api.dart';
part 'api/team_controller_api.dart';
part 'api/upload_controller_api.dart';
part 'api/user_controller_api.dart';

part 'model/advertisement_dto.dart';
part 'model/bulk_product_variant_dto.dart';
part 'model/category_dto.dart';
part 'model/create_advertisement_dto.dart';
part 'model/create_fixture_dto.dart';
part 'model/create_highlight_dto.dart';
part 'model/create_league_dto.dart';
part 'model/create_news_article_dto.dart';
part 'model/customer.dart';
part 'model/delete_image_dto.dart';
part 'model/fixture_dto.dart';
part 'model/heading_dto.dart';
part 'model/highlight_dto.dart';
part 'model/image_presigned_url_request_dto.dart';
part 'model/image_presigned_url_response_dto.dart';
part 'model/league_dto.dart';
part 'model/news_article_dto.dart';
part 'model/order_dto.dart';
part 'model/order_item_dto.dart';
part 'model/page_advertisement_dto.dart';
part 'model/page_fixture_dto.dart';
part 'model/page_highlight_dto.dart';
part 'model/page_league_dto.dart';
part 'model/pageable.dart';
part 'model/pageable_object.dart';
part 'model/payment_response_dto.dart';
part 'model/product_dto.dart';
part 'model/product_variant_dto.dart';
part 'model/promotion_product_dto.dart';
part 'model/review_dto.dart';
part 'model/simple_team_dto.dart';
part 'model/size_dto.dart';
part 'model/sort_object.dart';
part 'model/sync_status_dto.dart';
part 'model/team_dto.dart';
part 'model/update_advertisement_dto.dart';
part 'model/update_fixture_dto.dart';
part 'model/update_highlight_dto.dart';
part 'model/update_league_dto.dart';
part 'model/update_news_article_dto.dart';
part 'model/update_user_role_dto.dart';
part 'model/user_dto.dart';


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
