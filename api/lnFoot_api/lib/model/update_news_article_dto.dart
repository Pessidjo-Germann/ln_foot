//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateNewsArticleDto {
  /// Returns a new [UpdateNewsArticleDto] instance.
  UpdateNewsArticleDto({
    this.title,
    this.content,
    this.sourceUrl,
    this.imageUrl,
    this.publishedAt,
    this.tags = const [],
    this.status,
    this.summary,
    this.isMajorUpdate,
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
  String? content;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sourceUrl;

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
  DateTime? publishedAt;

  List<String> tags;

  UpdateNewsArticleDtoStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? summary;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isMajorUpdate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateNewsArticleDto &&
    other.title == title &&
    other.content == content &&
    other.sourceUrl == sourceUrl &&
    other.imageUrl == imageUrl &&
    other.publishedAt == publishedAt &&
    _deepEquality.equals(other.tags, tags) &&
    other.status == status &&
    other.summary == summary &&
    other.isMajorUpdate == isMajorUpdate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (content == null ? 0 : content!.hashCode) +
    (sourceUrl == null ? 0 : sourceUrl!.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (publishedAt == null ? 0 : publishedAt!.hashCode) +
    (tags.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (summary == null ? 0 : summary!.hashCode) +
    (isMajorUpdate == null ? 0 : isMajorUpdate!.hashCode);

  @override
  String toString() => 'UpdateNewsArticleDto[title=$title, content=$content, sourceUrl=$sourceUrl, imageUrl=$imageUrl, publishedAt=$publishedAt, tags=$tags, status=$status, summary=$summary, isMajorUpdate=$isMajorUpdate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.content != null) {
      json[r'content'] = this.content;
    } else {
      json[r'content'] = null;
    }
    if (this.sourceUrl != null) {
      json[r'sourceUrl'] = this.sourceUrl;
    } else {
      json[r'sourceUrl'] = null;
    }
    if (this.imageUrl != null) {
      json[r'imageUrl'] = this.imageUrl;
    } else {
      json[r'imageUrl'] = null;
    }
    if (this.publishedAt != null) {
      json[r'publishedAt'] = this.publishedAt!.toUtc().toIso8601String();
    } else {
      json[r'publishedAt'] = null;
    }
      json[r'tags'] = this.tags;
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.summary != null) {
      json[r'summary'] = this.summary;
    } else {
      json[r'summary'] = null;
    }
    if (this.isMajorUpdate != null) {
      json[r'isMajorUpdate'] = this.isMajorUpdate;
    } else {
      json[r'isMajorUpdate'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateNewsArticleDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateNewsArticleDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateNewsArticleDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateNewsArticleDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateNewsArticleDto(
        title: mapValueOfType<String>(json, r'title'),
        content: mapValueOfType<String>(json, r'content'),
        sourceUrl: mapValueOfType<String>(json, r'sourceUrl'),
        imageUrl: mapValueOfType<String>(json, r'imageUrl'),
        publishedAt: mapDateTime(json, r'publishedAt', r''),
        tags: json[r'tags'] is Iterable
            ? (json[r'tags'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        status: UpdateNewsArticleDtoStatusEnum.fromJson(json[r'status']),
        summary: mapValueOfType<String>(json, r'summary'),
        isMajorUpdate: mapValueOfType<bool>(json, r'isMajorUpdate'),
      );
    }
    return null;
  }

  static List<UpdateNewsArticleDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateNewsArticleDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateNewsArticleDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateNewsArticleDto> mapFromJson(dynamic json) {
    final map = <String, UpdateNewsArticleDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateNewsArticleDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateNewsArticleDto-objects as value to a dart map
  static Map<String, List<UpdateNewsArticleDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateNewsArticleDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateNewsArticleDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UpdateNewsArticleDtoStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateNewsArticleDtoStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const DRAFT = UpdateNewsArticleDtoStatusEnum._(r'DRAFT');
  static const PUBLISHED = UpdateNewsArticleDtoStatusEnum._(r'PUBLISHED');
  static const ARCHIVED = UpdateNewsArticleDtoStatusEnum._(r'ARCHIVED');

  /// List of all possible values in this [enum][UpdateNewsArticleDtoStatusEnum].
  static const values = <UpdateNewsArticleDtoStatusEnum>[
    DRAFT,
    PUBLISHED,
    ARCHIVED,
  ];

  static UpdateNewsArticleDtoStatusEnum? fromJson(dynamic value) => UpdateNewsArticleDtoStatusEnumTypeTransformer().decode(value);

  static List<UpdateNewsArticleDtoStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateNewsArticleDtoStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateNewsArticleDtoStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateNewsArticleDtoStatusEnum] to String,
/// and [decode] dynamic data back to [UpdateNewsArticleDtoStatusEnum].
class UpdateNewsArticleDtoStatusEnumTypeTransformer {
  factory UpdateNewsArticleDtoStatusEnumTypeTransformer() => _instance ??= const UpdateNewsArticleDtoStatusEnumTypeTransformer._();

  const UpdateNewsArticleDtoStatusEnumTypeTransformer._();

  String encode(UpdateNewsArticleDtoStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateNewsArticleDtoStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateNewsArticleDtoStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'DRAFT': return UpdateNewsArticleDtoStatusEnum.DRAFT;
        case r'PUBLISHED': return UpdateNewsArticleDtoStatusEnum.PUBLISHED;
        case r'ARCHIVED': return UpdateNewsArticleDtoStatusEnum.ARCHIVED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateNewsArticleDtoStatusEnumTypeTransformer] instance.
  static UpdateNewsArticleDtoStatusEnumTypeTransformer? _instance;
}


