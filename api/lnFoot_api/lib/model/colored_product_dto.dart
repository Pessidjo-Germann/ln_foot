//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ColoredProductDto {
  /// Returns a new [ColoredProductDto] instance.
  ColoredProductDto({
    this.id,
    this.imageUrl,
    this.file,
    this.name,
    this.productId,
    this.price,
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
  String? productId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? price;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ColoredProductDto &&
    other.id == id &&
    other.imageUrl == imageUrl &&
    other.file == file &&
    other.name == name &&
    other.productId == productId &&
    other.price == price;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (file == null ? 0 : file!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (price == null ? 0 : price!.hashCode);

  @override
  String toString() => 'ColoredProductDto[id=$id, imageUrl=$imageUrl, file=$file, name=$name, productId=$productId, price=$price]';

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
    if (this.productId != null) {
      json[r'productId'] = this.productId;
    } else {
      json[r'productId'] = null;
    }
    if (this.price != null) {
      json[r'price'] = this.price;
    } else {
      json[r'price'] = null;
    }
    return json;
  }

  /// Returns a new [ColoredProductDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ColoredProductDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ColoredProductDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ColoredProductDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ColoredProductDto(
        id: mapValueOfType<String>(json, r'id'),
        imageUrl: mapValueOfType<String>(json, r'imageUrl'),
        file: null, // No support for decoding binary content from JSON
        name: mapValueOfType<String>(json, r'name'),
        productId: mapValueOfType<String>(json, r'productId'),
        price: mapValueOfType<double>(json, r'price'),
      );
    }
    return null;
  }

  static List<ColoredProductDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ColoredProductDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ColoredProductDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ColoredProductDto> mapFromJson(dynamic json) {
    final map = <String, ColoredProductDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ColoredProductDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ColoredProductDto-objects as value to a dart map
  static Map<String, List<ColoredProductDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ColoredProductDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ColoredProductDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

