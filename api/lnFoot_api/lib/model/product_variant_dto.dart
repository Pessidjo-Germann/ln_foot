//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductVariantDto {
  /// Returns a new [ProductVariantDto] instance.
  ProductVariantDto({
    this.id,
    this.imageUrl,
    this.colorCode,
    this.productId,
    required this.price,
    this.stockQuantity,
    this.sizes = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? imageUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? colorCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? productId;

  /// Minimum value: 0
  num price;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? stockQuantity;

  List<String> sizes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductVariantDto &&
    other.id == id &&
    other.imageUrl == imageUrl &&
    other.colorCode == colorCode &&
    other.productId == productId &&
    other.price == price &&
    other.stockQuantity == stockQuantity &&
    _deepEquality.equals(other.sizes, sizes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (colorCode == null ? 0 : colorCode!.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (price.hashCode) +
    (stockQuantity == null ? 0 : stockQuantity!.hashCode) +
    (sizes.hashCode);

  @override
  String toString() => 'ProductVariantDto[id=$id, imageUrl=$imageUrl, colorCode=$colorCode, productId=$productId, price=$price, stockQuantity=$stockQuantity, sizes=$sizes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.imageUrl != null) {
      json[r'imageUrl'] = this.imageUrl;
    } else {
      json[r'imageUrl'] = null;
    }
    if (this.colorCode != null) {
      json[r'colorCode'] = this.colorCode;
    } else {
      json[r'colorCode'] = null;
    }
    if (this.productId != null) {
      json[r'productId'] = this.productId;
    } else {
      json[r'productId'] = null;
    }
      json[r'price'] = this.price;
    if (this.stockQuantity != null) {
      json[r'stockQuantity'] = this.stockQuantity;
    } else {
      json[r'stockQuantity'] = null;
    }
      json[r'sizes'] = this.sizes;
    return json;
  }

  /// Returns a new [ProductVariantDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductVariantDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProductVariantDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProductVariantDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductVariantDto(
        id: mapValueOfType<String>(json, r'id'),
        imageUrl: mapValueOfType<String>(json, r'imageUrl'),
        colorCode: mapValueOfType<String>(json, r'colorCode'),
        productId: mapValueOfType<String>(json, r'productId'),
        price: num.parse('${json[r'price']}'),
        stockQuantity: mapValueOfType<int>(json, r'stockQuantity'),
        sizes: json[r'sizes'] is Iterable
            ? (json[r'sizes'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<ProductVariantDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductVariantDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductVariantDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductVariantDto> mapFromJson(dynamic json) {
    final map = <String, ProductVariantDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductVariantDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductVariantDto-objects as value to a dart map
  static Map<String, List<ProductVariantDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductVariantDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductVariantDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'price',
  };
}

