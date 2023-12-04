import 'dart:convert';

class EachFamilyDto {
  final int campagneId;
  final int count;
  final int groupeId;
  final String animalName;
  final List<int> fichesIds;

  EachFamilyDto({
    required this.campagneId,
    required this.count,
    required this.groupeId,
    required this.animalName,
    required this.fichesIds,
  });

  factory EachFamilyDto.fromJson(String jsonString) {
    final parsed = json.decode(jsonString);

    return EachFamilyDto(
      campagneId: parsed['campagneId'],
      count: parsed['count'],
      groupeId: parsed['groupeId'],
      animalName: parsed['animalName'],
      fichesIds: List<int>.from(parsed['fichesIds']),
    );
  }
}
