//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateLeagueDto {
  /// Returns a new [CreateLeagueDto] instance.
  CreateLeagueDto({
    this.apiFootballId,
    this.name,
    this.country,
    this.logoUrl,
    this.flagUrl,
    this.season,
    this.type,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? apiFootballId;

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
  String? country;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? logoUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? flagUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? season;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateLeagueDto &&
    other.apiFootballId == apiFootballId &&
    other.name == name &&
    other.country == country &&
    other.logoUrl == logoUrl &&
    other.flagUrl == flagUrl &&
    other.season == season &&
    other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (apiFootballId == null ? 0 : apiFootballId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (country == null ? 0 : country!.hashCode) +
    (logoUrl == null ? 0 : logoUrl!.hashCode) +
    (flagUrl == null ? 0 : flagUrl!.hashCode) +
    (season == null ? 0 : season!.hashCode) +
    (type == null ? 0 : type!.hashCode);

  @override
  String toString() => 'CreateLeagueDto[apiFootballId=$apiFootballId, name=$name, country=$country, logoUrl=$logoUrl, flagUrl=$flagUrl, season=$season, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.apiFootballId != null) {
      json[r'apiFootballId'] = this.apiFootballId;
    } else {
      json[r'apiFootballId'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.country != null) {
      json[r'country'] = this.country;
    } else {
      json[r'country'] = null;
    }
    if (this.logoUrl != null) {
      json[r'logoUrl'] = this.logoUrl;
    } else {
      json[r'logoUrl'] = null;
    }
    if (this.flagUrl != null) {
      json[r'flagUrl'] = this.flagUrl;
    } else {
      json[r'flagUrl'] = null;
    }
    if (this.season != null) {
      json[r'season'] = this.season;
    } else {
      json[r'season'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    return json;
  }

  /// Returns a new [CreateLeagueDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateLeagueDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateLeagueDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateLeagueDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateLeagueDto(
        apiFootballId: mapValueOfType<String>(json, r'apiFootballId'),
        name: mapValueOfType<String>(json, r'name'),
        country: mapValueOfType<String>(json, r'country'),
        logoUrl: mapValueOfType<String>(json, r'logoUrl'),
        flagUrl: mapValueOfType<String>(json, r'flagUrl'),
        season: mapValueOfType<String>(json, r'season'),
        type: mapValueOfType<String>(json, r'type'),
      );
    }
    return null;
  }

  static List<CreateLeagueDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateLeagueDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateLeagueDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateLeagueDto> mapFromJson(dynamic json) {
    final map = <String, CreateLeagueDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateLeagueDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateLeagueDto-objects as value to a dart map
  static Map<String, List<CreateLeagueDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateLeagueDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateLeagueDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

