import 'package:flutter/material.dart';
import 'package:isar/isar.dart'; // [缺失项] 必须导入 Isar 包

part 'pet.g.dart'; 

enum PetType {
  fire(Color(0xFFBD4A20), "火系"),
  water(Color.fromARGB(255, 40, 158, 255), "水系"),
  grass(Color.fromARGB(255, 78, 188, 115), "草系"),
  light(Color.fromARGB(255, 79, 193, 255), "光系"),
  ordinary(Color.fromARGB(255, 97, 152, 177), "普通"),
  dragon(Color.fromARGB(255, 228, 43, 43), "龙系"),
  poison(Color.fromARGB(255, 163, 100, 207), "毒系"),
  insect(Color.fromARGB(255, 151, 179, 70), "虫系"),
  valiant(Color.fromARGB(255, 255, 129, 79), "武系"),
  wing(Color.fromARGB(255, 71, 209, 219), "翼系"),
  cute(Color.fromARGB(255, 255, 128, 147), "萌系"),
  evil(Color.fromARGB(255, 233, 64, 120), "恶系"),
  mechanical(Color.fromRGBO(62, 194, 161, 1), "机械系"),
  magical(Color.fromARGB(255, 189, 164, 250), "幻系"),
  electricity(Color.fromARGB(255, 240, 200, 80), "电系"),
  dark(Color.fromARGB(255, 157, 86, 207), "幽系"),
  mountain(Color.fromARGB(255, 248, 167, 61), "山系"),
  ice(Color.fromARGB(255, 76, 204, 255), "冰系");


  final Color themeColor;
  final String label;
  const PetType(this.themeColor, this.label);
}


@collection
class Pet {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  final String id;
  final String name;

  @enumerated
  final List<PetType> types;
  final List<double> stats;
  final List<String> evolutions;

  Pet({required this.name, required this.id, required this.types, required this.stats, required this.evolutions});

  // 从 JSON 映射
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List)
          .map((t) => PetType.values.firstWhere((e) => e.name == t))
          .toList(),
      stats: (json['stats'] as List).map((e) => (e as num).toDouble()).toList(),
      evolutions: List<String>.from(json['evolutions']),
    );
  }
}