import 'dart:convert';

class EachFamilyDto {
  final int campagneId;
  final int count;
  final int groupeId;
  final String animalName;
  final List<FicheDto> ficheList;

  EachFamilyDto({
    required this.campagneId,
    required this.count,
    required this.groupeId,
    required this.animalName,
    required this.ficheList,
  });

  factory EachFamilyDto.fromJson(String jsonString) {
    final parsed = json.decode(jsonString);
    final List<dynamic> ficheJsonList = parsed['ficheList'];

    return EachFamilyDto(
      campagneId: parsed['campagneId'],
      count: parsed['count'],
      groupeId: parsed['groupeId'],
      animalName: parsed['animalName'],
      ficheList: List<FicheDto>.from(ficheJsonList.map((x) => FicheDto.fromJson(x))),
    );
  }
}

class FicheDto {
  final int ficheId;
  final String description;

  FicheDto({
    required this.ficheId,
    required this.description,
  });

  factory FicheDto.fromJson(Map<String, dynamic> parsed) {
    return FicheDto(
      ficheId: parsed['ficheId'],
      description: parsed['description'],
    );
  }
}

