# Plan - Add Malayalam Detailed Content to Katyayani Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Katyayani card (ID 6).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Katyayani card (ID 6) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Katyayani (ID 6):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "കാർത്യായനി പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "ഭയമില്ലായ്മ",
          "നീതി",
          "ധർമ്മനിഷ്ഠമായ പ്രവർത്തനം",
          "നിശ്ചയദാർഢ്യം",
          "ജ്ഞാനത്താൽ നയിക്കപ്പെടുന്ന ശക്തി",
          "അഹങ്കാരത്തിനും ദോഷങ്ങൾക്കും മേലുള്ള വിജയം"
        ],
        "footer": "ആത്മീയ ജീവിതം എന്നത് നിഷ്ക്രിയമല്ല—അത് നമ്മിലുള്ളിലും ലോകത്തിലുമുള്ള അനീതിയെ നേരിടാൻ ധൈര്യം ആവശ്യപ്പെടുന്നു എന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "കാർത്യായനി പരമ്പരാഗതമായി ആജ്ഞാ ചക്രവുമായി (മൂന്നാം കണ്ണ്) ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "അന്തർജ്ഞാനം",
          "കാര്യവിവേചനം",
          "ഉന്നതമായ ജ്ഞാനം",
          "കാഴ്ചപ്പാടിലെ വ്യക്തത",
          "ആത്മീയ ഉൾക്കാഴ്ച"
        ],
        "footer": "ദേവിയുടെ ആരാധന വിവേകം ഉണർത്തുകയും മായയ്ക്കപ്പുറമുള്ള സത്യത്തെ തിരിച്ചറിയാൻ സാധകനെ പ്രാപ്തനാക്കുകയും ചെയ്യുമെന്ന് വിശ്വസിക്കപ്പെടുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ കാർത്യായനിയെ ആരാധിക്കുന്നത്:",
        "bullets": [
          "ധൈര്യവും ആത്മവിശ്വാസവും",
          "ശത്രുക്കളിൽ നിന്നും ദോഷകരമായ സ്വാധീനങ്ങളിൽ നിന്നുമുള്ള സംരക്ഷണം",
          "ധർമ്മനിഷ്ഠമായ ശ്രമങ്ങളിലെ വിജയം",
          "ആത്മീയ ശക്തി",
          "തടസ്സങ്ങളുടെ നിവാരണം",
          "കുടുംബ ഐക്യവും ഐശ്വര്യവും"
        ]
      },
      {
        "title": "കാർത്യായനി വ്രതം",
        "subtitle": "മാർഗ്ഗശീർഷ മാസത്തിൽ വൃന്ദാവനത്തിലെ ഗോപികമാർ കൃഷ്ണഭഗവാനെ തങ്ങളുടെ പതിയായി ലഭിക്കാൻ കാർത്യായനി വ്രതം അനുഷ്ഠിച്ചതായി ഭാഗവത പുരാണത്തിൽ വിവരിക്കുന്നു. അവർ പ്രാർത്ഥിച്ചത്:",
        "bullets": [
          "कात्यायनि महामाये महायोगिन्यधीश्वरि। नन्दगोपसुतं देवि पतिं मे कुरु ते नमः॥",
          "കാത്യായനി മഹാമായേ മഹായോഗിന്യധീശ്വരി | നന്ദഗോപസുതം ദേവി പതിം മേ കുരു തേ നമഃ ||"
        ],
        "footer": "വിവാഹത്തിൽ സമാധാനവും ദൈവിക കൃപയും ആഗ്രഹിക്കുന്ന ഭക്തർ ഇന്നും ഈ പ്രാർത്ഥന ചൊല്ലുന്നു."
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "തേൻ (പല പാരമ്പര്യങ്ങളിലും ആറാം ദിവസത്തെ പൂജയുമായി പ്രത്യേകം ബന്ധപ്പെട്ടിരിക്കുന്നു)",
          "പുതിയ പഴങ്ങൾ",
          "മാതളനാരങ്ങ",
          "മധുരപലഹാരങ്ങൾ",
          "ചുവന്ന പൂക്കൾ"
        ],
        "footer": "തേൻ സമർപ്പിക്കുന്നത് മധുരം, ചൈതന്യം, മധുരമായ സംസാരം എന്നിവയെ പ്രതിനിധീകരിക്കുന്നു എന്ന് വിശ്വസിക്കപ്പെടുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "കാർത്യായനി നമ്മെ പഠിപ്പിക്കുന്നത്:",
        "bullets": [
          "ജ്ഞാനത്താൽ നയിക്കപ്പെടുമ്പോഴാണ് ധൈര്യം ഏറ്റവും ശക്തമാകുന്നത്.",
          "തിന്മയെ നേരിടേണ്ടത് ധർമ്മം കൊണ്ടാണ്, അല്ലാതെ വെറുപ്പ് കൊണ്ടല്ല.",
          "ഏറ്റവും വലിയ പോരാട്ടം സ്വന്തം അഹങ്കാരം, കോപം, ലോഭം, അജ്ഞത എന്നിവക്കെതിരെയാണ്.",
          "ദൈവിക ശക്തിയും കാരുണ്യവും പരസ്പരം വേർപെടുത്താൻ കഴിയാത്തവയാണ്."
        ]
      }
    ]
```

### Models & UI & Tests
- No code changes are required in the files, as `durga_model.dart` and `flipping_card.dart` already support dynamically rendering `additionalSections`.
- We will verify parsing and formatting.

---

## 3. Verification Plan

### Automated Tests
- Run `flutter test` in `l:\Android\SreerajP_Devi`.

### Manual Verification
- Render back card details of Katyayani and verify that the content is displayed in Malayalam.
