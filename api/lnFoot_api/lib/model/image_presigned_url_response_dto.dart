//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ImagePresignedUrlResponseDto {
  /// Returns a new [ImagePresignedUrlResponseDto] instance.
  ImagePresignedUrlResponseDto({
    this.uploadUrl,
    this.formData = const {},
    this.key,
    this.finalUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? uploadUrl;

  Map<String, String> formData;

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
  String? finalUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ImagePresignedUrlResponseDto &&
    other.uploadUrl == uploadUrl &&
    _deepEquality.equals(other.formData, formData) &&
    other.key == key &&
    other.finalUrl == finalUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (uploadUrl == null ? 0 : uploadUrl!.hashCode) +
    (formData.hashCode) +
    (key == null ? 0 : key!.hashCode) +
    (finalUrl == null ? 0 : finalUrl!.hashCode);

  @override
  String toString() => 'ImagePresignedUrlResponseDto[uploadUrl=$uploadUrl, formData=$formData, key=$key, finalUrl=$finalUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.uploadUrl != null) {
      json[r'uploadUrl'] = this.uploadUrl;
    } else {
      json[r'uploadUrl'] = null;
    }
      json[r'formData'] = this.formData;
    if (this.key != null) {
      json[r'key'] = this.key;
    } else {
      json[r'key'] = null;
    }
    if (this.finalUrl != null) {
      json[r'finalUrl'] = this.finalUrl;
    } else {
      json[r'finalUrl'] = null;
    }
    return json;
  }

  /// Returns a new [ImagePresignedUrlResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ImagePresignedUrlResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ImagePresignedUrlResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ImagePresignedUrlResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ImagePresignedUrlResponseDto(
        uploadUrl: mapValueOfType<String>(json, r'uploadUrl'),
        formData: mapCastOfType<String, String>(json, r'formData') ?? const {},
        key: mapValueOfType<String>(json, r'key'),
        finalUrl: mapValueOfType<String>(json, r'finalUrl'),
      );
    }
    return null;
  }

  static List<ImagePresignedUrlResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ImagePresignedUrlResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ImagePresignedUrlResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ImagePresignedUrlResponseDto> mapFromJson(dynamic json) {
    final map = <String, ImagePresignedUrlResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImagePresignedUrlResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ImagePresignedUrlResponseDto-objects as value to a dart map
  static Map<String, List<ImagePresignedUrlResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ImagePresignedUrlResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ImagePresignedUrlResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

