/// Data model representing one of the Nine Forms of Durga (Navadurga).
class DurgaModel {
  final int id;
  final String nameEnglish;
  final String nameSanskrit;
  final String nameMalayalam;
  final String mantraSanskrit;
  final String mantraMalayalam;
  final String descriptionMalayalam;
  final String imagePath;
  final String audioPath;

  const DurgaModel({
    required this.id,
    required this.nameEnglish,
    required this.nameSanskrit,
    required this.nameMalayalam,
    required this.mantraSanskrit,
    required this.mantraMalayalam,
    required this.descriptionMalayalam,
    required this.imagePath,
    required this.audioPath,
  });

  /// Factory constructor to parse a Durga JSON object.
  factory DurgaModel.fromJson(Map<String, dynamic> json) {
    return DurgaModel(
      id: json['id'] as int,
      nameEnglish: json['nameEnglish'] as String? ?? '',
      nameSanskrit: json['nameSanskrit'] as String? ?? '',
      nameMalayalam: json['nameMalayalam'] as String? ?? '',
      mantraSanskrit: json['mantraSanskrit'] as String? ?? '',
      mantraMalayalam: json['mantraMalayalam'] as String? ?? '',
      descriptionMalayalam: json['descriptionMalayalam'] as String? ?? '',
      imagePath: json['imagePath'] as String? ?? '',
      audioPath: json['audioPath'] as String? ?? '',
    );
  }

  /// Converts the [DurgaModel] instance to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEnglish': nameEnglish,
      'nameSanskrit': nameSanskrit,
      'nameMalayalam': nameMalayalam,
      'mantraSanskrit': mantraSanskrit,
      'mantraMalayalam': mantraMalayalam,
      'descriptionMalayalam': descriptionMalayalam,
      'imagePath': imagePath,
      'audioPath': audioPath,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DurgaModel &&
        other.id == id &&
        other.nameEnglish == nameEnglish &&
        other.nameSanskrit == nameSanskrit &&
        other.nameMalayalam == nameMalayalam &&
        other.mantraSanskrit == mantraSanskrit &&
        other.mantraMalayalam == mantraMalayalam &&
        other.descriptionMalayalam == descriptionMalayalam &&
        other.imagePath == imagePath &&
        other.audioPath == audioPath;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nameEnglish,
      nameSanskrit,
      nameMalayalam,
      mantraSanskrit,
      mantraMalayalam,
      descriptionMalayalam,
      imagePath,
      audioPath,
    );
  }
}
