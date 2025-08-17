//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BulkProductVariantDto {
  /// Returns a new [BulkProductVariantDto] instance.
  BulkProductVariantDto({
    this.variants = const [],
  });

  List<ProductVariantDto> variants;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BulkProductVariantDto &&
    _deepEquality.equals(other.variants, variants);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (variants.hashCode);

  @override
  String toString() => 'BulkProductVariantDto[variants=$variants]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'variants'] = this.variants;
    return json;
  }

  /// Returns a new [BulkProductVariantDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BulkProductVariantDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BulkProductVariantDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BulkProductVariantDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BulkProductVariantDto(
        variants: ProductVariantDto.listFromJson(json[r'variants']),
      );
    }
    return null;
  }

  static List<BulkProductVariantDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BulkProductVariantDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BulkProductVariantDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BulkProductVariantDto> mapFromJson(dynamic json) {
    final map = <String, BulkProductVariantDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BulkProductVariantDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BulkProductVariantDto-objects as value to a dart map
  static Map<String, List<BulkProductVariantDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BulkProductVariantDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BulkProductVariantDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

