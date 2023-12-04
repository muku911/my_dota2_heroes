import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HeroData {
  final int id;
  final String name;
  final String localizedName;
  final String primaryAttr;
  final String attackType;
  final List<String> roles;
  final String img;
  final String icon;
  final int proPick;
  final int proWin;

  // Add other properties as needed

  HeroData({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.img,
    required this.icon,
    required this.proPick,
    required this.proWin,
  });

  factory HeroData.fromJson(Map<String, dynamic> json) {
    return HeroData(
      id: json['id'],
      name: json['name'],
      localizedName: json['localized_name'],
      primaryAttr: json['primary_attr'],
      attackType: json['attack_type'],
      roles: List<String>.from(json['roles']),
      img: json['img'],
      icon: json['icon'],
      proPick: json['pro_pick'],
      proWin: json['pro_win'],
    );
  }

  double get proWinRate => proPick > 0 ? proWin / proPick : 0.0;
}

Future<List<HeroData>> fetchHeroStats() async {
  const urlApi = "https://api.opendota.com/api/heroStats";
  final response = await http.get(Uri.parse(urlApi));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<HeroData> heroStats =
        data.map((json) => HeroData.fromJson(json)).toList();
    return heroStats;
  } else {
    throw Exception('Failed to load hero stats');
  }
}

Future<List<HeroData>> fetchData() async {
  String jsonString = await rootBundle.loadString('heroes.json');
  List<dynamic> data = json.decode(jsonString);
  List<HeroData> heroStats =
      data.map((json) => HeroData.fromJson(json)).toList();
  return heroStats;
}

Future<List<HeroData>> loadAndSortHeroData() async {
  List<HeroData> heroes = await fetchData();
  heroes.sort((a, b) => b.proWinRate.compareTo(a.proWinRate));
  return heroes.take(10).toList();
}

Future<List<HeroData>> loadHeroData() async {
  List<HeroData> heroes = await fetchData();
  return heroes.take(124).toList();
}
