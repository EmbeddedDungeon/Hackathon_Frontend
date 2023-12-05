import 'dart:convert';

class FicheDto {
  final int ficheId;
  final String familyName;
  final String description;
  final Map<String, int> time;
  final Map<String, int> date;
  final double? coordX; // Может быть null, используем тип double с дополнительным вопросительным знаком
  final double? coordY; // Может быть null, используем тип double с дополнительным вопросительным знаком
  final List<Commentaire> commentaires;

  FicheDto({
    required this.ficheId,
    required this.familyName,
    required this.description,
    required this.time,
    required this.date,
    this.coordX,
    this.coordY,
    required this.commentaires,
  });

  factory FicheDto.fromJson(String jsonString) {
    final parsed = json.decode(jsonString);

    return FicheDto(
      ficheId: parsed['ficheId'],
      familyName: parsed['familyName'],
      description: parsed['description'],
      time: Map<String, int>.from(parsed['time']),
      date: Map<String, int>.from(parsed['date']),
      coordX: parsed['coordX'] != null ? parsed['coordX'].toDouble() : null,
      coordY: parsed['coordY'] != null ? parsed['coordY'].toDouble() : null,
      commentaires: List<Commentaire>.from(parsed['commentaires'].map((x) => Commentaire.fromJson(x))),
    );
  }
}

class Commentaire {
  final int commentaireId;
  final int userId;
  final String userName;
  final String userSurname;
  final String description;

  Commentaire({
    required this.commentaireId,
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.description,
  });

  factory Commentaire.fromJson(Map<String, dynamic> json) {
    return Commentaire(
      commentaireId: json['commentaireId'],
      userId: json['userId'],
      userName: json['userName'],
      userSurname: json['userSurname'],
      description: json['description'],
    );
  }
}