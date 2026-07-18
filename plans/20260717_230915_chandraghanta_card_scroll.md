# Plan - Add Malayalam Detailed Content to Chandraghanta Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Chandraghanta card (ID 3).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Chandraghanta card (ID 3) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Chandraghanta (ID 3):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "ചന്ദ്രഘണ്ഡാ പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "ഭയമില്ലായ്മ",
          "പ്രതിസന്ധികളെ നേരിടാനുള്ള ധൈര്യം",
          "നന്മയെ സംരക്ഷിക്കാനുള്ള സന്നദ്ധത",
          "കാരുണ്യവും ശക്തിയും തമ്മിലുള്ള സന്തുലിതാവസ്ഥ",
          "ജാഗ്രതയും ആത്മീയ ഉണർവും"
        ],
        "footer": "യഥാർത്ഥ ആത്മീയതയിൽ ആന്തരിക സമാധാനവും സത്യത്തിനുവേണ്ടി നിലകൊള്ളാനുള്ള ധൈര്യവും ഉൾപ്പെടുന്നുവെന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "ചന്ദ്രഘണ്ഡാ പരമ്പരാഗതമായി മണിപൂര ചക്രവുമായി (സോളാർ പ്ലെക്സസ് ചക്രം) ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "ആത്മവിശ്വാസം",
          "ഇച്ഛാശക്തി",
          "നിശ്ചയദാർഢ്യം",
          "വ്യക്തിഗത ശക്തി",
          "പരിവർത്തനം"
        ],
        "footer": "ദേവിയുടെ ആരാധന ആന്തരിക ധൈര്യത്തെ ഉണർത്തുകയും ഭയത്തെ ഇല്ലാതാക്കുകയും ചെയ്യുന്നു, ഇത് സാധകനെ ജ്ഞാനത്തോടും ദൃഢവിശ്വാസത്തോടും കൂടി പ്രവർത്തിക്കാൻ പ്രാപ്തനാക്കുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ ചന്ദ്രഘണ്ഡായെ ആരാധിക്കുന്നത്:",
        "bullets": [
          "ധൈര്യവും ആത്മവിശ്വാസവും",
          "ഭയത്തിൽ നിന്നും ദോഷകരമായ സ്വാധീനങ്ങളിൽ നിന്നുമുള്ള സംരക്ഷണം",
          "ധർമ്മനിഷ്ഠമായ ശ്രമങ്ങളിലെ വിജയം",
          "മാനസിക സമാധാനം",
          "ഐശ്വര്യവും ഐക്യവും",
          "തടസ്സങ്ങൾക്ക് മേലുള്ള വിജയം"
        ]
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "പാൽ",
          "പായസം",
          "പാലുൽപ്പന്നങ്ങൾ കൊണ്ടുള്ള മധുരപലഹാരങ്ങൾ",
          "വെളുത്ത പൂക്കൾ",
          "പുതിയ പഴങ്ങൾ"
        ],
        "footer": "പാല് കൊണ്ടുള്ള വഴിപാടുകൾ വിശുദ്ധി, ശാന്തത, പോഷണം എന്നിവയെ പ്രതീകപ്പെടുത്തുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "ചന്ദ്രഘണ്ഡാ നമ്മെ പഠിപ്പിക്കുന്നത്:",
        "bullets": [
          "ധൈര്യം ഉണ്ടാകേണ്ടത് കോപത്തിൽ നിന്നല്ല, മറിച്ച് ആന്തരിക സമാധാനത്തിൽ നിന്നാണ്.",
          "ധർമ്മത്തിന് ചിലപ്പോൾ കാരുണ്യവും ദൃഢമായ തീരുമാനങ്ങളും ഒരുപോലെ ആവശ്യമാണ്.",
          "നമ്മുടെ വിശ്വാസം ഈശ്വരനിൽ അർപ്പിക്കുമ്പോൾ ഭയത്തിന് അതിന്റെ ശക്തി നഷ്ടപ്പെടുന്നു.",
          "ഉണർവുള്ള മനസ്സ് ഒരു മണി പോലെ മുഴങ്ങുന്നു, അത് അജ്ഞതയെയും ദോഷങ്ങളെയും അകറ്റി നിർത്തുന്നു."
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
- Render back card details of Chandraghanta and verify that the content is displayed in Malayalam.
