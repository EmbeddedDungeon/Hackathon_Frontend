class CampaignPostDto {
  late int id;
  late int chefDeFileId;
  late String description;
  late String titre;
  late Map<String, int> heureDebut;
  late Map<String, int> heureFin;
  late Map<String, int> dateDebut;
  late Map<String, int> dateFin;

  CampaignPostDto({
    required this.id,
    required this.chefDeFileId,
    required this.description,
    required this.titre,
    required this.heureDebut,
    required this.heureFin,
    required this.dateDebut,
    required this.dateFin,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chefDeFileId': chefDeFileId,
      'description': description,
      'titre': titre,
      'heureDebut': heureDebut,
      'heureFin': heureFin,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
    };
  }
}
