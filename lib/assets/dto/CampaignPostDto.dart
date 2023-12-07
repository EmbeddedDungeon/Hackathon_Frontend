class CampaignPostDto {
  late int chefDeFileId;
  late String description;
  late String titre;
  late Map<String, int>? heureDebut;
  late Map<String, int>? heureFin;
  late Map<String, int>? dateDebut;
  late Map<String, int>? dateFin;

  CampaignPostDto({
    required this.chefDeFileId,
    required this.description,
    required this.titre,
    this.heureDebut,
    this.heureFin,
    this.dateDebut,
    this.dateFin,
  });

  Map<String, dynamic> toJson() {
    return {
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
