//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateUserRoleDto {
  /// Returns a new [UpdateUserRoleDto] instance.
  UpdateUserRoleDto({
    this.role,
    this.permissions = const [],
  });

  UpdateUserRoleDtoRoleEnum? role;

  List<String> permissions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateUserRoleDto &&
    other.role == role &&
    _deepEquality.equals(other.permissions, permissions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (role == null ? 0 : role!.hashCode) +
    (permissions.hashCode);

  @override
  String toString() => 'UpdateUserRoleDto[role=$role, permissions=$permissions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
      json[r'permissions'] = this.permissions;
    return json;
  }

  /// Returns a new [UpdateUserRoleDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateUserRoleDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateUserRoleDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateUserRoleDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateUserRoleDto(
        role: UpdateUserRoleDtoRoleEnum.fromJson(json[r'role']),
        permissions: json[r'permissions'] is Iterable
            ? (json[r'permissions'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<UpdateUserRoleDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateUserRoleDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateUserRoleDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateUserRoleDto> mapFromJson(dynamic json) {
    final map = <String, UpdateUserRoleDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateUserRoleDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateUserRoleDto-objects as value to a dart map
  static Map<String, List<UpdateUserRoleDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateUserRoleDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateUserRoleDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UpdateUserRoleDtoRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateUserRoleDtoRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ADMIN = UpdateUserRoleDtoRoleEnum._(r'ADMIN');
  static const EDITOR = UpdateUserRoleDtoRoleEnum._(r'EDITOR');
  static const USER = UpdateUserRoleDtoRoleEnum._(r'USER');

  /// List of all possible values in this [enum][UpdateUserRoleDtoRoleEnum].
  static const values = <UpdateUserRoleDtoRoleEnum>[
    ADMIN,
    EDITOR,
    USER,
  ];

  static UpdateUserRoleDtoRoleEnum? fromJson(dynamic value) => UpdateUserRoleDtoRoleEnumTypeTransformer().decode(value);

  static List<UpdateUserRoleDtoRoleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateUserRoleDtoRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateUserRoleDtoRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateUserRoleDtoRoleEnum] to String,
/// and [decode] dynamic data back to [UpdateUserRoleDtoRoleEnum].
class UpdateUserRoleDtoRoleEnumTypeTransformer {
  factory UpdateUserRoleDtoRoleEnumTypeTransformer() => _instance ??= const UpdateUserRoleDtoRoleEnumTypeTransformer._();

  const UpdateUserRoleDtoRoleEnumTypeTransformer._();

  String encode(UpdateUserRoleDtoRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateUserRoleDtoRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateUserRoleDtoRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ADMIN': return UpdateUserRoleDtoRoleEnum.ADMIN;
        case r'EDITOR': return UpdateUserRoleDtoRoleEnum.EDITOR;
        case r'USER': return UpdateUserRoleDtoRoleEnum.USER;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateUserRoleDtoRoleEnumTypeTransformer] instance.
  static UpdateUserRoleDtoRoleEnumTypeTransformer? _instance;
}


