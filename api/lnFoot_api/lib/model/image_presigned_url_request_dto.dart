//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ImagePresignedUrlRequestDto {
  /// Returns a new [ImagePresignedUrlRequestDto] instance.
  ImagePresignedUrlRequestDto({
    this.fileName,
    this.contentType,
    this.contentLength,
    this.entityType,
    this.entityId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fileName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contentType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? contentLength;

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
  bool operator ==(Object other) => identical(this, other) || other is ImagePresignedUrlRequestDto &&
    other.fileName == fileName &&
    other.contentType == contentType &&
    other.contentLength == contentLength &&
    other.entityType == entityType &&
    other.entityId == entityId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (fileName == null ? 0 : fileName!.hashCode) +
    (contentType == null ? 0 : contentType!.hashCode) +
    (contentLength == null ? 0 : contentLength!.hashCode) +
    (entityType == null ? 0 : entityType!.hashCode) +
    (entityId == null ? 0 : entityId!.hashCode);

  @override
  String toString() => 'ImagePresignedUrlRequestDto[fileName=$fileName, contentType=$contentType, contentLength=$contentLength, entityType=$entityType, entityId=$entityId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.fileName != null) {
      json[r'fileName'] = this.fileName;
    } else {
      json[r'fileName'] = null;
    }
    if (this.contentType != null) {
      json[r'contentType'] = this.contentType;
    } else {
      json[r'contentType'] = null;
    }
    if (this.contentLength != null) {
      json[r'contentLength'] = this.contentLength;
    } else {
      json[r'contentLength'] = null;
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

  /// Returns a new [ImagePresignedUrlRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ImagePresignedUrlRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ImagePresignedUrlRequestDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ImagePresignedUrlRequestDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ImagePresignedUrlRequestDto(
        fileName: mapValueOfType<String>(json, r'fileName'),
        contentType: mapValueOfType<String>(json, r'contentType'),
        contentLength: mapValueOfType<int>(json, r'contentLength'),
        entityType: mapValueOfType<String>(json, r'entityType'),
        entityId: mapValueOfType<String>(json, r'entityId'),
      );
    }
    return null;
  }

  static List<ImagePresignedUrlRequestDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ImagePresignedUrlRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ImagePresignedUrlRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ImagePresignedUrlRequestDto> mapFromJson(dynamic json) {
    final map = <String, ImagePresignedUrlRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImagePresignedUrlRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ImagePresignedUrlRequestDto-objects as value to a dart map
  static Map<String, List<ImagePresignedUrlRequestDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ImagePresignedUrlRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ImagePresignedUrlRequestDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

