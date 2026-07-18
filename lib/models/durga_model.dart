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
  final List<AdditionalSection> additionalSections;

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
    this.additionalSections = const [],
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
      additionalSections: (json['additionalSections'] as List<dynamic>?)
              ?.map((item) => AdditionalSection.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
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
      'additionalSections': additionalSections.map((e) => e.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! DurgaModel) {
      return false;
    }
    if (other.id != id ||
        other.nameEnglish != nameEnglish ||
        other.nameSanskrit != nameSanskrit ||
        other.nameMalayalam != nameMalayalam ||
        other.mantraSanskrit != mantraSanskrit ||
        other.mantraMalayalam != mantraMalayalam ||
        other.descriptionMalayalam != descriptionMalayalam ||
        other.imagePath != imagePath ||
        other.audioPath != audioPath) {
      return false;
    }
    
    if (other.additionalSections.length != additionalSections.length) {
      return false;
    }
    for (int i = 0; i < additionalSections.length; i++) {
      if (other.additionalSections[i] != additionalSections[i]) {
        return false;
      }
    }
    return true;
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
      Object.hashAll(additionalSections),
    );
  }
}

/// Helper data class representing an additional detailed section for a Durga form.
class AdditionalSection {
  final String title;
  final String? subtitle;
  final List<String> bullets;
  final String? footer;

  const AdditionalSection({
    required this.title,
    this.subtitle,
    required this.bullets,
    this.footer,
  });

  factory AdditionalSection.fromJson(Map<String, dynamic> json) {
    return AdditionalSection(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      bullets: (json['bullets'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      footer: json['footer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      'bullets': bullets,
      if (footer != null) 'footer': footer,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdditionalSection) return false;
    if (other.title != title || other.subtitle != subtitle || other.footer != footer) return false;
    if (other.bullets.length != bullets.length) return false;
    for (int i = 0; i < bullets.length; i++) {
      if (other.bullets[i] != bullets[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(title, subtitle, Object.hashAll(bullets), footer);
}
