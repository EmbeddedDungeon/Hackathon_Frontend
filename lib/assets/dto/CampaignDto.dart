import 'dart:convert';

class CampaignDto {
  final int campagneId;
  final String campagneName;

  CampaignDto({
    required this.campagneId,
    required this.campagneName,
  });

  factory CampaignDto.fromJson(Map<String, dynamic> json) {
    return CampaignDto(
      campagneId: json['campagneId'],
      campagneName: json['campagneName'],
    );
  }
}

class CampaignListFactory {
  static List<CampaignDto> parseCampaignList(String responseBody) {
    final parsed = jsonDecode(responseBody)['campagnes'].cast<Map<String, dynamic>>();
    return parsed.map<CampaignDto>((json) => CampaignDto.fromJson(json)).toList();
  }
}
