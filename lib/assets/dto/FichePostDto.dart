class FichePostDto {
  late int userId;
  late int campagneId;
  late int groupId;
  late String description;
  late String familyName;
  late double? coordX;
  late double? coordY;
  late Map<String, int>? date;
  late Map<String, int>? time;

  FichePostDto({
    required this.userId,
    required this.campagneId,
    required this.groupId,
    required this.description,
    required this.familyName,
    this.coordX,
    this.coordY,
    this.date,
    this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'campagneId': campagneId,
      'groupId': groupId,
      'description': description,
      'familyName': familyName,
      'coordX': coordX,
      'coordY': coordY,
      'date': date,
      'time': time,
    };
  }
}