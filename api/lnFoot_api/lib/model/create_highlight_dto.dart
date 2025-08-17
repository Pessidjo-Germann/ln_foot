//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateHighlightDto {
  /// Returns a new [CreateHighlightDto] instance.
  CreateHighlightDto({
    this.title,
    this.videoUrl,
    this.thumbnailUrl,
    this.description,
    this.durationSeconds,
    this.type,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? videoUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? thumbnailUrl;

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
  int? durationSeconds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateHighlightDto &&
    other.title == title &&
    other.videoUrl == videoUrl &&
    other.thumbnailUrl == thumbnailUrl &&
    other.description == description &&
    other.durationSeconds == durationSeconds &&
    other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (videoUrl == null ? 0 : videoUrl!.hashCode) +
    (thumbnailUrl == null ? 0 : thumbnailUrl!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (durationSeconds == null ? 0 : durationSeconds!.hashCode) +
    (type == null ? 0 : type!.hashCode);

  @override
  String toString() => 'CreateHighlightDto[title=$title, videoUrl=$videoUrl, thumbnailUrl=$thumbnailUrl, description=$description, durationSeconds=$durationSeconds, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.videoUrl != null) {
      json[r'videoUrl'] = this.videoUrl;
    } else {
      json[r'videoUrl'] = null;
    }
    if (this.thumbnailUrl != null) {
      json[r'thumbnailUrl'] = this.thumbnailUrl;
    } else {
      json[r'thumbnailUrl'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.durationSeconds != null) {
      json[r'durationSeconds'] = this.durationSeconds;
    } else {
      json[r'durationSeconds'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    return json;
  }

  /// Returns a new [CreateHighlightDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateHighlightDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateHighlightDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateHighlightDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateHighlightDto(
        title: mapValueOfType<String>(json, r'title'),
        videoUrl: mapValueOfType<String>(json, r'videoUrl'),
        thumbnailUrl: mapValueOfType<String>(json, r'thumbnailUrl'),
        description: mapValueOfType<String>(json, r'description'),
        durationSeconds: mapValueOfType<int>(json, r'durationSeconds'),
        type: mapValueOfType<String>(json, r'type'),
      );
    }
    return null;
  }

  static List<CreateHighlightDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateHighlightDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateHighlightDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateHighlightDto> mapFromJson(dynamic json) {
    final map = <String, CreateHighlightDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateHighlightDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateHighlightDto-objects as value to a dart map
  static Map<String, List<CreateHighlightDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateHighlightDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateHighlightDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

