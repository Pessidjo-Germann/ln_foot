//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductDto {
  /// Returns a new [ProductDto] instance.
  ProductDto({
    required this.price,
    this.id,
    this.imageUrl,
    this.file,
    this.name,
    this.description,
    this.stockQuantity,
    this.categoryNames = const [],
    this.sizes = const [],
  });

  double price;

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
  MultipartFile? file;

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
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? stockQuantity;

  List<String> categoryNames;

  List<String> sizes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDto &&
          other.price == price &&
          other.id == id &&
          other.imageUrl == imageUrl &&
          other.file == file &&
          other.name == name &&
          other.description == description &&
          other.stockQuantity == stockQuantity &&
          _deepEquality.equals(other.categoryNames, categoryNames) &&
          _deepEquality.equals(other.sizes, sizes);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (price.hashCode) +
      (id == null ? 0 : id!.hashCode) +
      (imageUrl == null ? 0 : imageUrl!.hashCode) +
      (file == null ? 0 : file!.hashCode) +
      (name == null ? 0 : name!.hashCode) +
      (description == null ? 0 : description!.hashCode) +
      (stockQuantity == null ? 0 : stockQuantity!.hashCode) +
      (categoryNames.hashCode) +
      (sizes.hashCode);

  @override
  String toString() =>
      'ProductDto[price=$price, id=$id, imageUrl=$imageUrl, file=$file, name=$name, description=$description, stockQuantity=$stockQuantity, categoryNames=$categoryNames, sizes=$sizes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'price'] = this.price;
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
    if (this.file != null) {
      json[r'file'] = this.file;
    } else {
      json[r'file'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.stockQuantity != null) {
      json[r'stockQuantity'] = this.stockQuantity;
    } else {
      json[r'stockQuantity'] = null;
    }
    json[r'categoryNames'] = this.categoryNames;
    json[r'sizes'] = this.sizes;
    return json;
  }

  /// Returns a new [ProductDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ProductDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ProductDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductDto(
        price: mapValueOfType<double>(json, r'price')!,
        id: mapValueOfType<String>(json, r'id'),
        imageUrl: mapValueOfType<String>(json, r'imageUrl'),
        file: null, // No support for decoding binary content from JSON
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        stockQuantity: mapValueOfType<int>(json, r'stockQuantity'),
        categoryNames: json[r'categoryNames'] is Iterable
            ? (json[r'categoryNames'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        sizes: json[r'sizes'] is Iterable
            ? (json[r'sizes'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<ProductDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ProductDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductDto> mapFromJson(dynamic json) {
    final map = <String, ProductDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductDto-objects as value to a dart map
  static Map<String, List<ProductDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ProductDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'price',
  };
}
