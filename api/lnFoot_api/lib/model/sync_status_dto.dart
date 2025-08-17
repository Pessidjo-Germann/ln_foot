//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SyncStatusDto {
  /// Returns a new [SyncStatusDto] instance.
  SyncStatusDto({
    this.status,
    this.message,
    this.itemsProcessed,
  });

  SyncStatusDtoStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? itemsProcessed;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SyncStatusDto &&
    other.status == status &&
    other.message == message &&
    other.itemsProcessed == itemsProcessed;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status == null ? 0 : status!.hashCode) +
    (message == null ? 0 : message!.hashCode) +
    (itemsProcessed == null ? 0 : itemsProcessed!.hashCode);

  @override
  String toString() => 'SyncStatusDto[status=$status, message=$message, itemsProcessed=$itemsProcessed]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    } else {
      json[r'message'] = null;
    }
    if (this.itemsProcessed != null) {
      json[r'itemsProcessed'] = this.itemsProcessed;
    } else {
      json[r'itemsProcessed'] = null;
    }
    return json;
  }

  /// Returns a new [SyncStatusDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SyncStatusDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SyncStatusDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SyncStatusDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SyncStatusDto(
        status: SyncStatusDtoStatusEnum.fromJson(json[r'status']),
        message: mapValueOfType<String>(json, r'message'),
        itemsProcessed: mapValueOfType<int>(json, r'itemsProcessed'),
      );
    }
    return null;
  }

  static List<SyncStatusDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SyncStatusDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SyncStatusDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SyncStatusDto> mapFromJson(dynamic json) {
    final map = <String, SyncStatusDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SyncStatusDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SyncStatusDto-objects as value to a dart map
  static Map<String, List<SyncStatusDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SyncStatusDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SyncStatusDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class SyncStatusDtoStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const SyncStatusDtoStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const SUCCESS = SyncStatusDtoStatusEnum._(r'SUCCESS');
  static const ERROR = SyncStatusDtoStatusEnum._(r'ERROR');
  static const NO_DATA = SyncStatusDtoStatusEnum._(r'NO_DATA');

  /// List of all possible values in this [enum][SyncStatusDtoStatusEnum].
  static const values = <SyncStatusDtoStatusEnum>[
    SUCCESS,
    ERROR,
    NO_DATA,
  ];

  static SyncStatusDtoStatusEnum? fromJson(dynamic value) => SyncStatusDtoStatusEnumTypeTransformer().decode(value);

  static List<SyncStatusDtoStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SyncStatusDtoStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SyncStatusDtoStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SyncStatusDtoStatusEnum] to String,
/// and [decode] dynamic data back to [SyncStatusDtoStatusEnum].
class SyncStatusDtoStatusEnumTypeTransformer {
  factory SyncStatusDtoStatusEnumTypeTransformer() => _instance ??= const SyncStatusDtoStatusEnumTypeTransformer._();

  const SyncStatusDtoStatusEnumTypeTransformer._();

  String encode(SyncStatusDtoStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a SyncStatusDtoStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SyncStatusDtoStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SUCCESS': return SyncStatusDtoStatusEnum.SUCCESS;
        case r'ERROR': return SyncStatusDtoStatusEnum.ERROR;
        case r'NO_DATA': return SyncStatusDtoStatusEnum.NO_DATA;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SyncStatusDtoStatusEnumTypeTransformer] instance.
  static SyncStatusDtoStatusEnumTypeTransformer? _instance;
}


