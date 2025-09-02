//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserDto {
  /// Returns a new [UserDto] instance.
  UserDto({
    this.id,
    this.keycloakId,
    this.email,
    this.name,
    this.avatarUrl,
    this.role,
    this.permissions = const [],
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
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
  String? keycloakId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

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
  String? avatarUrl;

  UserDtoRoleEnum? role;

  List<String> permissions;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? emailVerified;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserDto &&
    other.id == id &&
    other.keycloakId == keycloakId &&
    other.email == email &&
    other.name == name &&
    other.avatarUrl == avatarUrl &&
    other.role == role &&
    _deepEquality.equals(other.permissions, permissions) &&
    other.emailVerified == emailVerified &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (keycloakId == null ? 0 : keycloakId!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (avatarUrl == null ? 0 : avatarUrl!.hashCode) +
    (role == null ? 0 : role!.hashCode) +
    (permissions.hashCode) +
    (emailVerified == null ? 0 : emailVerified!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'UserDto[id=$id, keycloakId=$keycloakId, email=$email, name=$name, avatarUrl=$avatarUrl, role=$role, permissions=$permissions, emailVerified=$emailVerified, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.keycloakId != null) {
      json[r'keycloakId'] = this.keycloakId;
    } else {
      json[r'keycloakId'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.avatarUrl != null) {
      json[r'avatarUrl'] = this.avatarUrl;
    } else {
      json[r'avatarUrl'] = null;
    }
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
      json[r'permissions'] = this.permissions;
    if (this.emailVerified != null) {
      json[r'emailVerified'] = this.emailVerified!.toUtc().toIso8601String();
    } else {
      json[r'emailVerified'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [UserDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserDto(
        id: mapValueOfType<String>(json, r'id'),
        keycloakId: mapValueOfType<String>(json, r'keycloakId'),
        email: mapValueOfType<String>(json, r'email'),
        name: mapValueOfType<String>(json, r'name'),
        avatarUrl: mapValueOfType<String>(json, r'avatarUrl'),
        role: UserDtoRoleEnum.fromJson(json[r'role']),
        permissions: json[r'permissions'] is Iterable
            ? (json[r'permissions'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        emailVerified: mapDateTime(json, r'emailVerified', r''),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
      );
    }
    return null;
  }

  static List<UserDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserDto> mapFromJson(dynamic json) {
    final map = <String, UserDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserDto-objects as value to a dart map
  static Map<String, List<UserDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UserDtoRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UserDtoRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ADMIN = UserDtoRoleEnum._(r'ADMIN');
  static const EDITOR = UserDtoRoleEnum._(r'EDITOR');
  static const USER = UserDtoRoleEnum._(r'USER');

  /// List of all possible values in this [enum][UserDtoRoleEnum].
  static const values = <UserDtoRoleEnum>[
    ADMIN,
    EDITOR,
    USER,
  ];

  static UserDtoRoleEnum? fromJson(dynamic value) => UserDtoRoleEnumTypeTransformer().decode(value);

  static List<UserDtoRoleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserDtoRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserDtoRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserDtoRoleEnum] to String,
/// and [decode] dynamic data back to [UserDtoRoleEnum].
class UserDtoRoleEnumTypeTransformer {
  factory UserDtoRoleEnumTypeTransformer() => _instance ??= const UserDtoRoleEnumTypeTransformer._();

  const UserDtoRoleEnumTypeTransformer._();

  String encode(UserDtoRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserDtoRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserDtoRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ADMIN': return UserDtoRoleEnum.ADMIN;
        case r'EDITOR': return UserDtoRoleEnum.EDITOR;
        case r'USER': return UserDtoRoleEnum.USER;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserDtoRoleEnumTypeTransformer] instance.
  static UserDtoRoleEnumTypeTransformer? _instance;
}


