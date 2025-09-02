//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeleteImageDto {
  /// Returns a new [DeleteImageDto] instance.
  DeleteImageDto({
    this.key,
    this.imageUrl,
    this.bucketName,
    this.entityType,
    this.entityId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? key;

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
  String? bucketName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? entityType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? entityId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteImageDto &&
    other.key == key &&
    other.imageUrl == imageUrl &&
    other.bucketName == bucketName &&
    other.entityType == entityType &&
    other.entityId == entityId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (key == null ? 0 : key!.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (bucketName == null ? 0 : bucketName!.hashCode) +
    (entityType == null ? 0 : entityType!.hashCode) +
    (entityId == null ? 0 : entityId!.hashCode);

  @override
  String toString() => 'DeleteImageDto[key=$key, imageUrl=$imageUrl, bucketName=$bucketName, entityType=$entityType, entityId=$entityId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.key != null) {
      json[r'key'] = this.key;
    } else {
      json[r'key'] = null;
    }
    if (this.imageUrl != null) {
      json[r'imageUrl'] = this.imageUrl;
    } else {
      json[r'imageUrl'] = null;
    }
    if (this.bucketName != null) {
      json[r'bucketName'] = this.bucketName;
    } else {
      json[r'bucketName'] = null;
    }
    if (this.entityType != null) {
      json[r'entityType'] = this.entityType;
    } else {
      json[r'entityType'] = null;
    }
    if (this.entityId != null) {
      json[r'entityId'] = this.entityId;
    } else {
      json[r'entityId'] = null;
    }
    return json;
  }

  /// Returns a new [DeleteImageDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteImageDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DeleteImageDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteImageDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DeleteImageDto(
        key: mapValueOfType<String>(json, r'key'),
        imageUrl: mapValueOfType<String>(json, r'imageUrl'),
        bucketName: mapValueOfType<String>(json, r'bucketName'),
        entityType: mapValueOfType<String>(json, r'entityType'),
        entityId: mapValueOfType<String>(json, r'entityId'),
      );
    }
    return null;
  }

  static List<DeleteImageDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteImageDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteImageDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteImageDto> mapFromJson(dynamic json) {
    final map = <String, DeleteImageDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteImageDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteImageDto-objects as value to a dart map
  static Map<String, List<DeleteImageDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteImageDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeleteImageDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

