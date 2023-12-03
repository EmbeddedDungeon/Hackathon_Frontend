import 'dart:convert';

class EachCampaignDto {
  final int campagneId;
  final String name;
  final String description;
  final List<Groupes> groupes;
  final List<Communes> communes;

  EachCampaignDto({
    required this.campagneId,
    required this.name,
    required this.description,
    required this.groupes,
    required this.communes,
  });

  factory EachCampaignDto.fromJson(String jsonString) {
    final parsed = json.decode(jsonString);

    return EachCampaignDto(
      campagneId: parsed['campagneId'],
      name: parsed['name'],
      description: parsed['description'],
      groupes: List<Groupes>.from(parsed['groupes'].map((x) => Groupes.fromJson(x))),
      communes: List<Communes>.from(parsed['communes'].map((x) => Communes.fromJson(x))),
    );
  }
}

class Groupes {
  final int id;
  final String nom;

  Groupes({
    required this.id,
    required this.nom,
  });

  factory Groupes.fromJson(Map<String, dynamic> json) {
    return Groupes(
      id: json['id'],
      nom: json['nom'],
    );
  }
}

class Communes {
  final int id;
  final String nom;

  Communes({
    required this.id,
    required this.nom,
  });

  factory Communes.fromJson(Map<String, dynamic> json) {
    return Communes(
      id: json['id'],
      nom: json['nom'],
    );
  }
}