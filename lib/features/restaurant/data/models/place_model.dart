import 'dart:convert';

import 'package:flutter/foundation.dart';

class Place {
  final String fsqId;
  final List<Category> categories;
  final List<Chain> chains;
  final String closedBucket;
  final int distance;
  final Geocodes geocodes;
  final String link;
  final Location location;
  final String name;
  final String timezone;
  Place({
    required this.fsqId,
    required this.categories,
    required this.chains,
    required this.closedBucket,
    required this.distance,
    required this.geocodes,
    required this.link,
    required this.location,
    required this.name,
    required this.timezone,
  });

  Place copyWith({
    String? fsqId,
    List<Category>? categories,
    List<Chain>? chains,
    String? closedBucket,
    int? distance,
    Geocodes? geocodes,
    String? link,
    Location? location,
    String? name,
    String? timezone,
  }) {
    return Place(
      fsqId: fsqId ?? this.fsqId,
      categories: categories ?? this.categories,
      chains: chains ?? this.chains,
      closedBucket: closedBucket ?? this.closedBucket,
      distance: distance ?? this.distance,
      geocodes: geocodes ?? this.geocodes,
      link: link ?? this.link,
      location: location ?? this.location,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fsqId': fsqId,
      'categories': categories.map((x) => x.toMap()).toList(),
      'chains': chains.map((x) => x.toMap()).toList(),
      'closedBucket': closedBucket,
      'distance': distance,
      'geocodes': geocodes.toMap(),
      'link': link,
      'location': location.toMap(),
      'name': name,
      'timezone': timezone,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      fsqId: map['fsqId'] ?? '',
      categories: List<Category>.from(
          map['categories']?.map((x) => Category.fromMap(x))),
      chains: List<Chain>.from(map['chains']?.map((x) => Chain.fromMap(x))),
      closedBucket: map['closedBucket'] ?? '',
      distance: map['distance']?.toInt() ?? 0,
      geocodes: Geocodes.fromMap(map['geocodes']),
      link: map['link'] ?? '',
      location: Location.fromMap(map['location']),
      name: map['name'] ?? '',
      timezone: map['timezone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(fsqId: $fsqId, categories: $categories, chains: $chains, closedBucket: $closedBucket, distance: $distance, geocodes: $geocodes, link: $link, location: $location, name: $name, timezone: $timezone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.fsqId == fsqId &&
        listEquals(other.categories, categories) &&
        listEquals(other.chains, chains) &&
        other.closedBucket == closedBucket &&
        other.distance == distance &&
        other.geocodes == geocodes &&
        other.link == link &&
        other.location == location &&
        other.name == name &&
        other.timezone == timezone;
  }

  @override
  int get hashCode {
    return fsqId.hashCode ^
        categories.hashCode ^
        chains.hashCode ^
        closedBucket.hashCode ^
        distance.hashCode ^
        geocodes.hashCode ^
        link.hashCode ^
        location.hashCode ^
        name.hashCode ^
        timezone.hashCode;
  }
}

class Category {
  final int id;
  final String name;
  final String shortName;
  final String pluralName;
  final Icon icon;
  Category({
    required this.id,
    required this.name,
    required this.shortName,
    required this.pluralName,
    required this.icon,
  });

  Category copyWith({
    int? id,
    String? name,
    String? shortName,
    String? pluralName,
    Icon? icon,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      pluralName: pluralName ?? this.pluralName,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'pluralName': pluralName,
      'icon': icon.toMap(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      shortName: map['shortName'] ?? '',
      pluralName: map['pluralName'] ?? '',
      icon: Icon.fromMap(map['icon']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, shortName: $shortName, pluralName: $pluralName, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.shortName == shortName &&
        other.pluralName == pluralName &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        shortName.hashCode ^
        pluralName.hashCode ^
        icon.hashCode;
  }
}

class Chain {
  final String id;
  final String name;
  Chain({
    required this.id,
    required this.name,
  });

  Chain copyWith({
    String? id,
    String? name,
  }) {
    return Chain(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Chain.fromMap(Map<String, dynamic> map) {
    return Chain(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Chain.fromJson(String source) => Chain.fromMap(json.decode(source));

  @override
  String toString() => 'Chain(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chain && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Geocodes {
  final Geocode main;
  final Geocode? roof;
  final Geocode? dropOff;
  Geocodes({
    required this.main,
    this.roof,
    this.dropOff,
  });

  Geocodes copyWith({
    Geocode? main,
    ValueGetter<Geocode?>? roof,
    ValueGetter<Geocode?>? dropOff,
  }) {
    return Geocodes(
      main: main ?? this.main,
      roof: roof != null ? roof() : this.roof,
      dropOff: dropOff != null ? dropOff() : this.dropOff,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'main': main.toMap(),
      'roof': roof?.toMap(),
      'dropOff': dropOff?.toMap(),
    };
  }

  factory Geocodes.fromMap(Map<String, dynamic> map) {
    return Geocodes(
      main: Geocode.fromMap(map['main']),
      roof: map['roof'] != null ? Geocode.fromMap(map['roof']) : null,
      dropOff: map['dropOff'] != null ? Geocode.fromMap(map['dropOff']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Geocodes.fromJson(String source) =>
      Geocodes.fromMap(json.decode(source));

  @override
  String toString() => 'Geocodes(main: $main, roof: $roof, dropOff: $dropOff)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Geocodes &&
        other.main == main &&
        other.roof == roof &&
        other.dropOff == dropOff;
  }

  @override
  int get hashCode => main.hashCode ^ roof.hashCode ^ dropOff.hashCode;
}

class Geocode {
  final double latitude;
  final double longitude;
  Geocode({
    required this.latitude,
    required this.longitude,
  });

  Geocode copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Geocode(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Geocode.fromMap(Map<String, dynamic> map) {
    return Geocode(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Geocode.fromJson(String source) =>
      Geocode.fromMap(json.decode(source));

  @override
  String toString() => 'Geocode(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Geocode &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

class Location {
  final String country;
  final String? address;
  final String? crossStreet;
  final String formattedAddress;
  final String locality;
  final String region;
  final String? postTown;
  Location({
    required this.country,
    this.address,
    this.crossStreet,
    required this.formattedAddress,
    required this.locality,
    required this.region,
    this.postTown,
  });

  Location copyWith({
    String? country,
    ValueGetter<String?>? address,
    ValueGetter<String?>? crossStreet,
    String? formattedAddress,
    String? locality,
    String? region,
    ValueGetter<String?>? postTown,
  }) {
    return Location(
      country: country ?? this.country,
      address: address != null ? address() : this.address,
      crossStreet: crossStreet != null ? crossStreet() : this.crossStreet,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      locality: locality ?? this.locality,
      region: region ?? this.region,
      postTown: postTown != null ? postTown() : this.postTown,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'address': address,
      'crossStreet': crossStreet,
      'formattedAddress': formattedAddress,
      'locality': locality,
      'region': region,
      'postTown': postTown,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      country: map['country'] ?? '',
      address: map['address'],
      crossStreet: map['crossStreet'],
      formattedAddress: map['formattedAddress'] ?? '',
      locality: map['locality'] ?? '',
      region: map['region'] ?? '',
      postTown: map['postTown'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(country: $country, address: $address, crossStreet: $crossStreet, formattedAddress: $formattedAddress, locality: $locality, region: $region, postTown: $postTown)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.country == country &&
        other.address == address &&
        other.crossStreet == crossStreet &&
        other.formattedAddress == formattedAddress &&
        other.locality == locality &&
        other.region == region &&
        other.postTown == postTown;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        address.hashCode ^
        crossStreet.hashCode ^
        formattedAddress.hashCode ^
        locality.hashCode ^
        region.hashCode ^
        postTown.hashCode;
  }
}

class GeoBounds {
  final Circle circle;
  GeoBounds({
    required this.circle,
  });

  GeoBounds copyWith({
    Circle? circle,
  }) {
    return GeoBounds(
      circle: circle ?? this.circle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'circle': circle.toMap(),
    };
  }

  factory GeoBounds.fromMap(Map<String, dynamic> map) {
    return GeoBounds(
      circle: Circle.fromMap(map['circle']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoBounds.fromJson(String source) =>
      GeoBounds.fromMap(json.decode(source));

  @override
  String toString() => 'GeoBounds(circle: $circle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeoBounds && other.circle == circle;
  }

  @override
  int get hashCode => circle.hashCode;
}

class Circle {
  final Center center;
  final int radius;
  Circle({
    required this.center,
    required this.radius,
  });

  Circle copyWith({
    Center? center,
    int? radius,
  }) {
    return Circle(
      center: center ?? this.center,
      radius: radius ?? this.radius,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'center': center.toMap(),
      'radius': radius,
    };
  }

  factory Circle.fromMap(Map<String, dynamic> map) {
    return Circle(
      center: Center.fromMap(map['center']),
      radius: map['radius']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Circle.fromJson(String source) => Circle.fromMap(json.decode(source));

  @override
  String toString() => 'Circle(center: $center, radius: $radius)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Circle && other.center == center && other.radius == radius;
  }

  @override
  int get hashCode => center.hashCode ^ radius.hashCode;
}

class Center {
  final double latitude;
  final double longitude;
  Center({
    required this.latitude,
    required this.longitude,
  });

  Center copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Center(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Center.fromMap(Map<String, dynamic> map) {
    return Center(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Center.fromJson(String source) => Center.fromMap(json.decode(source));

  @override
  String toString() => 'Center(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Center &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

class Icon {
  final String prefix;
  final String suffix;
  Icon({
    required this.prefix,
    required this.suffix,
  });

  Icon copyWith({
    String? prefix,
    String? suffix,
  }) {
    return Icon(
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prefix': prefix,
      'suffix': suffix,
    };
  }

  factory Icon.fromMap(Map<String, dynamic> map) {
    return Icon(
      prefix: map['prefix'] ?? '',
      suffix: map['suffix'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Icon.fromJson(String source) => Icon.fromMap(json.decode(source));

  @override
  String toString() => 'Icon(prefix: $prefix, suffix: $suffix)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Icon && other.prefix == prefix && other.suffix == suffix;
  }

  @override
  int get hashCode => prefix.hashCode ^ suffix.hashCode;
}
