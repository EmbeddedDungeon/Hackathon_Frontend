import 'dart:convert';

class FicheDto {
  final int campagneId;
  final int ficheId;
  final String description;
  final Map<String, int> time;
  final Map<String, int> date;
  final List<Commentaire> commentaires;

  FicheDto({
    required this.campagneId,
    required this.ficheId,
    required this.description,
    required this.time,
    required this.date,
    required this.commentaires,
  });

  factory FicheDto.fromJson(String jsonString) {
    final parsed = json.decode(jsonString);

    return FicheDto(
      campagneId: parsed['campagneId'],
      ficheId: parsed['ficheId'],
      description: parsed['description'],
      time: Map<String, int>.from(parsed['time']),
      date: Map<String, int>.from(parsed['date']),
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