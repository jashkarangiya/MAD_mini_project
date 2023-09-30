/*
*  Model: LocationModel
*  Function: Model of what the data of a location looks like
*/

import 'dart:convert';

class LocationModel {
    LocationModel({
        required this.name,
        required this.lat,
        required this.lon,
        this.country,
        this.state,
    });

    final String name;
    final double lat;
    final double lon;
    String? country;
    String? state;

    factory LocationModel.fromRawJson(String str) => LocationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
    };
}
