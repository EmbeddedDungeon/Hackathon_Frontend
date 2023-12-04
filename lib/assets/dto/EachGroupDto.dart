import 'dart:convert';

class EachGroupDto {
  final int campagneId;
  final int groupeId;
  final String groupeName;
  final List<String> animalNames;

  EachGroupDto({
    required this.campagneId,
    required this.groupeId,
    required this.groupeName,
    required this.animalNames,
  });

  factory EachGroupDto.fromJson(String jsonString) {
    final parsed = json.decode(jsonString);

    return EachGroupDto(
      campagneId: parsed['campagneId'],
      groupeId: parsed['groupeId'],
      groupeName: parsed['groupeName'],
      animalNames: List<String>.from(parsed['animalNames']),
    );
  }
}
