//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamDto {
  /// Returns a new [TeamDto] instance.
  TeamDto({
    this.id,
    this.name,
    this.country,
    this.founded,
    this.national,
    this.logoUrl,
    this.venueName,
    this.venueAddress,
    this.venueCity,
    this.venueCapacity,
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
  int? founded;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? national;

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
  String? venueName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? venueAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? venueCity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? venueCapacity;

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
  bool operator ==(Object other) => identical(this, other) || other is TeamDto &&
    other.id == id &&
    other.name == name &&
    other.country == country &&
    other.founded == founded &&
    other.national == national &&
    other.logoUrl == logoUrl &&
    other.venueName == venueName &&
    other.venueAddress == venueAddress &&
    other.venueCity == venueCity &&
    other.venueCapacity == venueCapacity &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (country == null ? 0 : country!.hashCode) +
    (founded == null ? 0 : founded!.hashCode) +
    (national == null ? 0 : national!.hashCode) +
    (logoUrl == null ? 0 : logoUrl!.hashCode) +
    (venueName == null ? 0 : venueName!.hashCode) +
    (venueAddress == null ? 0 : venueAddress!.hashCode) +
    (venueCity == null ? 0 : venueCity!.hashCode) +
    (venueCapacity == null ? 0 : venueCapacity!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'TeamDto[id=$id, name=$name, country=$country, founded=$founded, national=$national, logoUrl=$logoUrl, venueName=$venueName, venueAddress=$venueAddress, venueCity=$venueCity, venueCapacity=$venueCapacity, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
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
    if (this.founded != null) {
      json[r'founded'] = this.founded;
    } else {
      json[r'founded'] = null;
    }
    if (this.national != null) {
      json[r'national'] = this.national;
    } else {
      json[r'national'] = null;
    }
    if (this.logoUrl != null) {
      json[r'logoUrl'] = this.logoUrl;
    } else {
      json[r'logoUrl'] = null;
    }
    if (this.venueName != null) {
      json[r'venueName'] = this.venueName;
    } else {
      json[r'venueName'] = null;
    }
    if (this.venueAddress != null) {
      json[r'venueAddress'] = this.venueAddress;
    } else {
      json[r'venueAddress'] = null;
    }
    if (this.venueCity != null) {
      json[r'venueCity'] = this.venueCity;
    } else {
      json[r'venueCity'] = null;
    }
    if (this.venueCapacity != null) {
      json[r'venueCapacity'] = this.venueCapacity;
    } else {
      json[r'venueCapacity'] = null;
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

  /// Returns a new [TeamDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamDto(
        id: mapValueOfType<String>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        country: mapValueOfType<String>(json, r'country'),
        founded: mapValueOfType<int>(json, r'founded'),
        national: mapValueOfType<bool>(json, r'national'),
        logoUrl: mapValueOfType<String>(json, r'logoUrl'),
        venueName: mapValueOfType<String>(json, r'venueName'),
        venueAddress: mapValueOfType<String>(json, r'venueAddress'),
        venueCity: mapValueOfType<String>(json, r'venueCity'),
        venueCapacity: mapValueOfType<int>(json, r'venueCapacity'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
      );
    }
    return null;
  }

  static List<TeamDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamDto> mapFromJson(dynamic json) {
    final map = <String, TeamDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamDto-objects as value to a dart map
  static Map<String, List<TeamDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeamDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

