//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class OrderDto {
  /// Returns a new [OrderDto] instance.
  OrderDto({
    this.id,
    this.orderDate,
    this.status,
    this.orderItems = const [],
    this.deliveryFee,
    this.deliveryAddress,
    this.totalAmount,
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
  DateTime? orderDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? status;

  List<OrderItemDto> orderItems;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? deliveryFee;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? deliveryAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? totalAmount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderDto &&
    other.id == id &&
    other.orderDate == orderDate &&
    other.status == status &&
    _deepEquality.equals(other.orderItems, orderItems) &&
    other.deliveryFee == deliveryFee &&
    other.deliveryAddress == deliveryAddress &&
    other.totalAmount == totalAmount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (orderDate == null ? 0 : orderDate!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (orderItems.hashCode) +
    (deliveryFee == null ? 0 : deliveryFee!.hashCode) +
    (deliveryAddress == null ? 0 : deliveryAddress!.hashCode) +
    (totalAmount == null ? 0 : totalAmount!.hashCode);

  @override
  String toString() => 'OrderDto[id=$id, orderDate=$orderDate, status=$status, orderItems=$orderItems, deliveryFee=$deliveryFee, deliveryAddress=$deliveryAddress, totalAmount=$totalAmount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.orderDate != null) {
      json[r'orderDate'] = this.orderDate!.toUtc().toIso8601String();
    } else {
      json[r'orderDate'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
      json[r'orderItems'] = this.orderItems;
    if (this.deliveryFee != null) {
      json[r'deliveryFee'] = this.deliveryFee;
    } else {
      json[r'deliveryFee'] = null;
    }
    if (this.deliveryAddress != null) {
      json[r'deliveryAddress'] = this.deliveryAddress;
    } else {
      json[r'deliveryAddress'] = null;
    }
    if (this.totalAmount != null) {
      json[r'totalAmount'] = this.totalAmount;
    } else {
      json[r'totalAmount'] = null;
    }
    return json;
  }

  /// Returns a new [OrderDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OrderDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "OrderDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "OrderDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return OrderDto(
        id: mapValueOfType<String>(json, r'id'),
        orderDate: mapDateTime(json, r'orderDate', r''),
        status: mapValueOfType<String>(json, r'status'),
        orderItems: OrderItemDto.listFromJson(json[r'orderItems']),
        deliveryFee: num.parse('${json[r'deliveryFee']}'),
        deliveryAddress: mapValueOfType<String>(json, r'deliveryAddress'),
        totalAmount: num.parse('${json[r'totalAmount']}'),
      );
    }
    return null;
  }

  static List<OrderDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OrderDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OrderDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, OrderDto> mapFromJson(dynamic json) {
    final map = <String, OrderDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = OrderDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of OrderDto-objects as value to a dart map
  static Map<String, List<OrderDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<OrderDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = OrderDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

