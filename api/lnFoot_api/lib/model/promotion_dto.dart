//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PromotionDto {
  /// Returns a new [PromotionDto] instance.
  PromotionDto({
    this.id,
    required this.productId,
    required this.discountedPrice,
    required this.startDate,
    required this.endDate,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  String productId;

  num discountedPrice;

  DateTime startDate;

  DateTime endDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PromotionDto &&
    other.id == id &&
    other.productId == productId &&
    other.discountedPrice == discountedPrice &&
    other.startDate == startDate &&
    other.endDate == endDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (productId.hashCode) +
    (discountedPrice.hashCode) +
    (startDate.hashCode) +
    (endDate.hashCode);

  @override
  String toString() => 'PromotionDto[id=$id, productId=$productId, discountedPrice=$discountedPrice, startDate=$startDate, endDate=$endDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
      json[r'productId'] = this.productId;
      json[r'discountedPrice'] = this.discountedPrice;
      json[r'startDate'] = _dateFormatter.format(this.startDate.toUtc());
      json[r'endDate'] = _dateFormatter.format(this.endDate.toUtc());
    return json;
  }

  /// Returns a new [PromotionDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PromotionDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PromotionDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PromotionDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PromotionDto(
        id: mapValueOfType<String>(json, r'id'),
        productId: mapValueOfType<String>(json, r'productId')!,
        discountedPrice: num.parse('${json[r'discountedPrice']}'),
        startDate: mapDateTime(json, r'startDate', r'')!,
        endDate: mapDateTime(json, r'endDate', r'')!,
      );
    }
    return null;
  }

  static List<PromotionDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PromotionDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PromotionDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PromotionDto> mapFromJson(dynamic json) {
    final map = <String, PromotionDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PromotionDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PromotionDto-objects as value to a dart map
  static Map<String, List<PromotionDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PromotionDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PromotionDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'productId',
    'discountedPrice',
    'startDate',
    'endDate',
  };
}

