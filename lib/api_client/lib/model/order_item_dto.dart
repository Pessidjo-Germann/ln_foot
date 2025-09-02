//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class OrderItemDto {
  /// Returns a new [OrderItemDto] instance.
  OrderItemDto({
    this.id,
    this.productVariantId,
    this.quantity,
    this.size,
    this.orderId,
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
  String? productVariantId;

  /// Minimum value: 1
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? quantity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? size;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? orderId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? price;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderItemDto &&
    other.id == id &&
    other.productVariantId == productVariantId &&
    other.quantity == quantity &&
    other.size == size &&
    other.orderId == orderId &&
    other.price == price;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (productVariantId == null ? 0 : productVariantId!.hashCode) +
    (quantity == null ? 0 : quantity!.hashCode) +
    (size == null ? 0 : size!.hashCode) +
    (orderId == null ? 0 : orderId!.hashCode) +
    (price == null ? 0 : price!.hashCode);

  @override
  String toString() => 'OrderItemDto[id=$id, productVariantId=$productVariantId, quantity=$quantity, size=$size, orderId=$orderId, price=$price]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.productVariantId != null) {
      json[r'productVariantId'] = this.productVariantId;
    } else {
      json[r'productVariantId'] = null;
    }
    if (this.quantity != null) {
      json[r'quantity'] = this.quantity;
    } else {
      json[r'quantity'] = null;
    }
    if (this.size != null) {
      json[r'size'] = this.size;
    } else {
      json[r'size'] = null;
    }
    if (this.orderId != null) {
      json[r'orderId'] = this.orderId;
    } else {
      json[r'orderId'] = null;
    }
    if (this.price != null) {
      json[r'price'] = this.price;
    } else {
      json[r'price'] = null;
    }
    return json;
  }

  /// Returns a new [OrderItemDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OrderItemDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "OrderItemDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "OrderItemDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return OrderItemDto(
        id: mapValueOfType<String>(json, r'id'),
        productVariantId: mapValueOfType<String>(json, r'productVariantId'),
        quantity: mapValueOfType<int>(json, r'quantity'),
        size: mapValueOfType<String>(json, r'size'),
        orderId: mapValueOfType<String>(json, r'orderId'),
        price: num.parse('${json[r'price']}'),
      );
    }
    return null;
  }

  static List<OrderItemDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OrderItemDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OrderItemDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, OrderItemDto> mapFromJson(dynamic json) {
    final map = <String, OrderItemDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = OrderItemDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of OrderItemDto-objects as value to a dart map
  static Map<String, List<OrderItemDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<OrderItemDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = OrderItemDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

