//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateNewsArticleDto {
  /// Returns a new [CreateNewsArticleDto] instance.
  CreateNewsArticleDto({
    this.title,
    this.content,
    this.summary,
    this.authorName,
    this.sourceUrl,
    this.imageUrl,
    this.publishedAt,
    this.tags = const [],
    this.status,
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
  String? summary;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? authorName;

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

  CreateNewsArticleDtoStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isMajorUpdate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateNewsArticleDto &&
    other.title == title &&
    other.content == content &&
    other.summary == summary &&
    other.authorName == authorName &&
    other.sourceUrl == sourceUrl &&
    other.imageUrl == imageUrl &&
    other.publishedAt == publishedAt &&
    _deepEquality.equals(other.tags, tags) &&
    other.status == status &&
    other.isMajorUpdate == isMajorUpdate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (content == null ? 0 : content!.hashCode) +
    (summary == null ? 0 : summary!.hashCode) +
    (authorName == null ? 0 : authorName!.hashCode) +
    (sourceUrl == null ? 0 : sourceUrl!.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (publishedAt == null ? 0 : publishedAt!.hashCode) +
    (tags.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (isMajorUpdate == null ? 0 : isMajorUpdate!.hashCode);

  @override
  String toString() => 'CreateNewsArticleDto[title=$title, content=$content, summary=$summary, authorName=$authorName, sourceUrl=$sourceUrl, imageUrl=$imageUrl, publishedAt=$publishedAt, tags=$tags, status=$status, isMajorUpdate=$isMajorUpdate]';

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
    if (this.summary != null) {
      json[r'summary'] = this.summary;
    } else {
      json[r'summary'] = null;
    }
    if (this.authorName != null) {
      json[r'authorName'] = this.authorName;
    } else {
      json[r'authorName'] = null;
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
    if (this.isMajorUpdate != null) {
      json[r'isMajorUpdate'] = this.isMajorUpdate;
    } else {
      json[r'isMajorUpdate'] = null;
    }
    return json;
  }

  /// Returns a new [CreateNewsArticleDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateNewsArticleDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateNewsArticleDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateNewsArticleDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateNewsArticleDto(
        title: mapValueOfType<String>(json, r'title'),
        content: mapValueOfType<String>(json, r'content'),
        summary: mapValueOfType<String>(json, r'summary'),
        authorName: mapValueOfType<String>(json, r'authorName'),
        sourceUrl: mapValueOfType<String>(json, r'sourceUrl'),
        imageUrl: mapValueOfType<String>(json, r'imageUrl'),
        publishedAt: mapDateTime(json, r'publishedAt', r''),
        tags: json[r'tags'] is Iterable
            ? (json[r'tags'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        status: CreateNewsArticleDtoStatusEnum.fromJson(json[r'status']),
        isMajorUpdate: mapValueOfType<bool>(json, r'isMajorUpdate'),
      );
    }
    return null;
  }

  static List<CreateNewsArticleDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateNewsArticleDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateNewsArticleDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateNewsArticleDto> mapFromJson(dynamic json) {
    final map = <String, CreateNewsArticleDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateNewsArticleDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateNewsArticleDto-objects as value to a dart map
  static Map<String, List<CreateNewsArticleDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateNewsArticleDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateNewsArticleDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class CreateNewsArticleDtoStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateNewsArticleDtoStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const DRAFT = CreateNewsArticleDtoStatusEnum._(r'DRAFT');
  static const PUBLISHED = CreateNewsArticleDtoStatusEnum._(r'PUBLISHED');
  static const ARCHIVED = CreateNewsArticleDtoStatusEnum._(r'ARCHIVED');

  /// List of all possible values in this [enum][CreateNewsArticleDtoStatusEnum].
  static const values = <CreateNewsArticleDtoStatusEnum>[
    DRAFT,
    PUBLISHED,
    ARCHIVED,
  ];

  static CreateNewsArticleDtoStatusEnum? fromJson(dynamic value) => CreateNewsArticleDtoStatusEnumTypeTransformer().decode(value);

  static List<CreateNewsArticleDtoStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateNewsArticleDtoStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateNewsArticleDtoStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateNewsArticleDtoStatusEnum] to String,
/// and [decode] dynamic data back to [CreateNewsArticleDtoStatusEnum].
class CreateNewsArticleDtoStatusEnumTypeTransformer {
  factory CreateNewsArticleDtoStatusEnumTypeTransformer() => _instance ??= const CreateNewsArticleDtoStatusEnumTypeTransformer._();

  const CreateNewsArticleDtoStatusEnumTypeTransformer._();

  String encode(CreateNewsArticleDtoStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateNewsArticleDtoStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateNewsArticleDtoStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'DRAFT': return CreateNewsArticleDtoStatusEnum.DRAFT;
        case r'PUBLISHED': return CreateNewsArticleDtoStatusEnum.PUBLISHED;
        case r'ARCHIVED': return CreateNewsArticleDtoStatusEnum.ARCHIVED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateNewsArticleDtoStatusEnumTypeTransformer] instance.
  static CreateNewsArticleDtoStatusEnumTypeTransformer? _instance;
}


