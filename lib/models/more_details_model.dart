class MoreDetailsModel {
  final OrderExplanationModel orderExplanation;
  final OriginExplanationModel originExplanation;

  const MoreDetailsModel({
    required this.orderExplanation,
    required this.originExplanation,
  });

  factory MoreDetailsModel.fromJson(Map<String, dynamic> json) {
    return MoreDetailsModel(
      orderExplanation: OrderExplanationModel.fromJson(
        json['orderExplanation'] as Map<String, dynamic>? ?? const {},
      ),
      originExplanation: OriginExplanationModel.fromJson(
        json['originExplanation'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  static const MoreDetailsModel fallback = MoreDetailsModel(
    orderExplanation: OrderExplanationModel.fallback,
    originExplanation: OriginExplanationModel.fallback,
  );
}

class OrderExplanationModel {
  final String title;
  final String subtitle;
  final List<StageModel> stages;
  final String footer;

  const OrderExplanationModel({
    required this.title,
    required this.subtitle,
    required this.stages,
    required this.footer,
  });

  factory OrderExplanationModel.fromJson(Map<String, dynamic> json) {
    return OrderExplanationModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      stages: (json['stages'] as List<dynamic>?)
              ?.map((item) => StageModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
      footer: json['footer'] as String? ?? '',
    );
  }

  static const OrderExplanationModel fallback = OrderExplanationModel(
    title: 'എന്തുകൊണ്ട് ഈ ക്രമത്തിൽ ആരാധിക്കുന്നു?',
    subtitle: 'നവദുർഗ്ഗാ യാത്ര മനുഷ്യബോധത്തിന്റെ ആത്മീയ പരിണാമത്തെ പ്രതിനിധീകരിക്കുന്നു:',
    stages: [
      StageModel(name: 'ശൈലപുത്രി (Shailaputri)', meaning: 'സ്ഥിരതയും അടിസ്ഥാനവും (Stability and grounding)'),
      StageModel(name: 'ബ്രഹ്മചാരിണി (Brahmacharini)', meaning: 'ആത്മശിക്ഷണവും ഭക്തിയും (Discipline and devotion)'),
      StageModel(name: 'ചന്ദ്രഘണ്ടാ (Chandraghanta)', meaning: 'ധൈര്യവും സംരക്ഷണവും (Courage and protection)'),
      StageModel(name: 'കൂശ്മാണ്ഡാ (Kushmanda)', meaning: 'സൃഷ്ടിപരമായ ഊർജ്ജവും ആന്തരിക തേജസ്സും (Creative energy and inner radiance)'),
      StageModel(name: 'സ്കന്ദമാതാ (Skandamata)', meaning: 'കരുണയും പോഷിപ്പിക്കുന്ന ജ്ഞാനവും (Compassion and nurturing wisdom)'),
      StageModel(name: 'കാർത്യായനി (Katyayani)', meaning: 'നീതിയുക്തമായ ശക്തിയും വിവേചനവും (Righteous power and discernment)'),
      StageModel(name: 'കാലരാത്രി (Kalaratri)', meaning: 'ഭയത്തിന്റെയും അജ്ഞതയുടെയും നാശം (Destruction of fear and ignorance)'),
      StageModel(name: 'മഹാഗൗരി (Mahagauri)', meaning: 'ശുദ്ധീകരണവും പ്രശാന്തതയും (Purification and serenity)'),
      StageModel(name: 'സിദ്ധിദാത്രി (Siddhidatri)', meaning: 'ആത്മീയ പൂർണ്ണതയും പരമബോധത്തിന്റെ സാക്ഷാത്കാരവും (Spiritual perfection and realization of the Supreme)'),
    ],
    footer: 'ഈ അന്തിമ ഘട്ടം സാധകന്റെ ആത്മീയ യാത്രയുടെ പൂർത്തീകരണത്തെ പ്രതീകപ്പെടുത്തുന്നു—ശൈലപുത്രിയുടെ അടിസ്ഥാനപരമായ തുടക്കം മുതൽ ആത്മീയജ്ഞാനത്തിന്റെയും പരമാത്മാവുമായുള്ള ആത്മീയ സംയോഗത്തിന്റെയും പരമമായ അവസ്ഥ വരെ.',
  );
}

class StageModel {
  final String name;
  final String meaning;

  const StageModel({
    required this.name,
    required this.meaning,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      name: json['name'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
    );
  }
}

class OriginExplanationModel {
  final String title;
  final String intro;
  final String subIntro;
  final CosmicOriginModel cosmicOrigin;
  final PuranicOriginModel puranicOrigin;

  const OriginExplanationModel({
    required this.title,
    required this.intro,
    required this.subIntro,
    required this.cosmicOrigin,
    required this.puranicOrigin,
  });

  factory OriginExplanationModel.fromJson(Map<String, dynamic> json) {
    return OriginExplanationModel(
      title: json['title'] as String? ?? '',
      intro: json['intro'] as String? ?? '',
      subIntro: json['subIntro'] as String? ?? '',
      cosmicOrigin: CosmicOriginModel.fromJson(
        json['cosmicOrigin'] as Map<String, dynamic>? ?? const {},
      ),
      puranicOrigin: PuranicOriginModel.fromJson(
        json['puranicOrigin'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  static const OriginExplanationModel fallback = OriginExplanationModel(
    title: 'നവദുർഗ്ഗമാരുടെ ഉത്ഭവം എങ്ങനെയായിരുന്നു?',
    intro: 'നവദുർഗ്ഗമാർ വ്യത്യസ്ത കാലങ്ങളിൽ ജനിച്ച ഒൻപത് വ്യത്യസ്ത ദേവിമാരല്ല. മറിച്ച്, അവർ ഒരേയൊരു പരമ ദിവ്യ മാതാവിന്റെ (ആദിശക്തിയുടെ) ഒൻപത് ഭാവങ്ങളാണ്. ഓരോ രൂപവും അവളുടെ ശക്തിയുടെ വിവിധ വശങ്ങൾ വെളിപ്പെടുത്തുകയും സാധകനെ ആത്മീയ പരിണാമത്തിന്റെ വിവിധ ഘട്ടങ്ങളിലൂടെ നയിക്കുകയും ചെയ്യുന്നു.',
    subIntro: 'അവരുടെ ഉത്ഭവത്തെക്കുറിച്ച് മനസ്സിലാക്കാൻ പരസ്പര പൂരകങ്ങളായ രണ്ട് വഴികളുണ്ട്: പുരാണപരവും ആത്മീയവും.',
    cosmicOrigin: CosmicOriginModel.fallback,
    puranicOrigin: PuranicOriginModel.fallback,
  );
}

class CosmicOriginModel {
  final String title;
  final String subtitle;
  final String description;

  const CosmicOriginModel({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory CosmicOriginModel.fromJson(Map<String, dynamic> json) {
    return CosmicOriginModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  static const CosmicOriginModel fallback = CosmicOriginModel(
    title: '1. പ്രപഞ്ചോത്പത്തി - ആദിശക്തി',
    subtitle: 'ദേവി ഭാഗവത പുരാണം, ദേവി മാഹാത്മ്യം (ദുർഗ്ഗാ സപ്തശതി), മറ്റ് ശാക്തേയ ഗ്രന്ഥങ്ങൾ എന്നിവ പ്രകാരം:',
    description: 'സൃഷ്ടിക്ക് മുൻപ്, ഭൂമിയോ സ്വർഗ്ഗമോ ഇല്ലായിരുന്നു, ദേവന്മാരോ മനുഷ്യരോ ഇല്ലായിരുന്നു; സനാതനമായ പരമബോധവും പരമമായ ദിവ്യശക്തിയും (ആദിശക്തി) മാത്രമേ ഉണ്ടായിരുന്നുള്ളൂ.\n\nഈ ആദിമ ദിവ്യശക്തിയിൽ നിന്നാണ് പ്രപഞ്ചമാതാവായ ആദിപരാശക്തി പ്രകടമായത്. മഹാമായ, ജഗദംബ, ഭുവനേശ്വരി, ദുർഗ്ഗ, ലളിത, പാർവ്വതി എന്നീ പേരുകളിലെല്ലാം വിശേഷിപ്പിക്കപ്പെടുന്നത് ഒരേ പരമദേവിയുടെ വിവിധ ഭാവങ്ങളെയാണ്.\n\nപ്രപഞ്ചത്തിന് സംരക്ഷണവും മാർഗ്ഗനിർദ്ദേശവും ആവശ്യമുള്ളപ്പോഴെല്ലാം ആദിശക്തി വിവിധ രൂപങ്ങൾ കൈക്കൊള്ളുന്നു. നവദുർഗ്ഗമാർ അത്തരം ഒൻപത് ഭാവങ്ങളാണ്.',
  );
}

class PuranicOriginModel {
  final String title;
  final String subtitle;
  final List<PuranicStoryModel> stories;

  const PuranicOriginModel({
    required this.title,
    required this.subtitle,
    required this.stories,
  });

  factory PuranicOriginModel.fromJson(Map<String, dynamic> json) {
    return PuranicOriginModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      stories: (json['stories'] as List<dynamic>?)
              ?.map((item) => PuranicStoryModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  static const PuranicOriginModel fallback = PuranicOriginModel(
    title: '2. പുരാണങ്ങളിലെ ഉത്ഭവം',
    subtitle: 'പരമശിവന്റെ പത്നിയായ പാർവ്വതി ദേവിയുടെ ജീവിതവുമായി നവദുർഗ്ഗമാർ അടുത്ത ബന്ധം പുലർത്തുന്നു. ഈ പ്രക്രിയ താഴെ പറയുന്ന ക്രമത്തിലാണ് വികസിക്കുന്നത്:',
    stories: [
      PuranicStoryModel(
        emoji: '🌺',
        id: 1,
        name: 'ശൈലപുത്രി',
        text: 'ദക്ഷയാഗത്തിൽ സതീദേവി ആത്മാഹൂതി ചെയ്ത ശേഷം, ദേവി ഹിമവാന്റെ മകളായി പുനർജനിച്ചു. അങ്ങനെ ദേവി ശൈലപുത്രിയായി അറിയപ്പെട്ടു.',
      ),
      PuranicStoryModel(
        emoji: '🌼',
        id: 2,
        name: 'ബ്രഹ്മചാരിണി',
        text: 'ശിവനെ വീണ്ടും ഭർത്താവായി ലഭിക്കുന്നതിനായി ദേവി കഠിനമായ തപസ്സനുഷ്ഠിച്ചു. ഈ തപസ്വിനി രൂപം ബ്രഹ്മചാരിണിയായി മാറി.',
      ),
      PuranicStoryModel(
        emoji: '🌙',
        id: 3,
        name: 'ചന്ദ്രഘണ്ടാ',
        text: 'ശിവനെ വിവാഹം കഴിച്ചതിനുശേഷം, ദേവി ചന്ദ്രക്കല ധരിച്ച ധീരയായ യോദ്ധാവായ രാജ്ഞിയായി മാറി. അങ്ങനെ ദേവി ചന്ദ്രഘണ്ടാ എന്നറിയപ്പെട്ടു.',
      ),
      PuranicStoryModel(
        emoji: '☀️',
        id: 4,
        name: 'കൂശ്മാണ്ഡാ',
        text: 'തന്റെ മന്ദഹാസത്തിലൂടെ പ്രപഞ്ചം സൃഷ്ടിച്ചുകൊണ്ട് ദേവി പ്രപഞ്ചസൃഷ്ടികർത്താവായി സ്വയം വെളിപ്പെടുത്തി. അങ്ങനെ ദേവി കൂശ്മാണ്ഡാ ആയി മാറി.',
      ),
      PuranicStoryModel(
        emoji: '👶',
        id: 5,
        name: 'സ്കന്ദമാതാ',
        text: 'ദേവസേനയുടെ അധിപനായ സ്കന്ദന്റെ (കാർത്തികേയന്റെ) അമ്മയായപ്പോൾ ദേവി സ്കന്ദമാതാവായി മാറി.',
      ),
      PuranicStoryModel(
        emoji: '🦁',
        id: 6,
        name: 'കാർത്യായനി',
        text: 'മഹിഷാസുരൻ ലോകങ്ങളെ ഭീതിയിലാഴ്ത്തിയപ്പോൾ, ദേവന്മാരുടെ സംയുക്ത ദിവ്യശക്തികളിൽ നിന്ന് യോദ്ധാവായ ദേവി കാർത്യായനി മഹർഷിയുടെ പുത്രിയായി അവതരിക്കുകയും മഹിഷാസുരനെ വധിക്കുകയും ചെയ്തു.',
      ),
      PuranicStoryModel(
        emoji: '🌑',
        id: 7,
        name: 'കാലരാത്രി',
        text: 'ശുംഭനിശുംഭന്മാരുമായുള്ള യുദ്ധത്തിൽ ക്രൂരമായ അസുരശക്തികളെ നശിപ്പിക്കാൻ ദേവി അതീവ രൗദ്രഭാവമുള്ള രൂപം ധരിച്ചു. ഇത് കാലരാത്രിയായി മാറി.',
      ),
      PuranicStoryModel(
        emoji: '🤍',
        id: 8,
        name: 'മഹാഗൗരി',
        text: 'യുദ്ധങ്ങൾക്ക് ശേഷം ദേവി തന്റെ പരിശുദ്ധവും പ്രശാന്തവും പ്രകാശമാനവുമായ രൂപം വീണ്ടെടുത്തു. ഈ ഭാവം മഹാഗൗരിയായി മാറി.',
      ),
      PuranicStoryModel(
        emoji: '✨',
        id: 9,
        name: 'സിദ്ധിദാത്രി',
        text: 'അവസാനം, പ്രപഞ്ചത്തിന്റെ ആദിശക്തിയായ ദേവി ഭക്തർക്ക് ജ്ഞാനവും സിദ്ധികളും മോക്ഷവും നൽകുന്നവളായി സ്വയം വെളിപ്പെടുത്തി. ഇത് സിദ്ധിദാത്രിയായി മാറി.',
      ),
    ],
  );
}

class PuranicStoryModel {
  final String emoji;
  final int id;
  final String name;
  final String text;

  const PuranicStoryModel({
    required this.emoji,
    required this.id,
    required this.name,
    required this.text,
  });

  factory PuranicStoryModel.fromJson(Map<String, dynamic> json) {
    return PuranicStoryModel(
      emoji: json['emoji'] as String? ?? '🌺',
      id: json['id'] as int? ?? 1,
      name: json['name'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }
}
