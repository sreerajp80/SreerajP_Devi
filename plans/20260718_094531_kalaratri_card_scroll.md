# Plan - Add Malayalam Detailed Content to Kalaratri Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Kalaratri card (ID 7).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Kalaratri card (ID 7) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Kalaratri (ID 7):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "കാലരാത്രി പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "ഭയമില്ലായ്മ",
          "അജ്ഞതയുടെ നാശം",
          "പരിവർത്തനം",
          "ആന്തരിക ശക്തി",
          "ദോഷങ്ങളിൽ നിന്നുള്ള സംരക്ഷണം",
          "ആസക്തികളിൽ നിന്നും മായയിൽ നിന്നുമുള്ള മുക്തി"
        ],
        "footer": "ഇരുട്ട് എന്നത് ഒരു ശത്രുവല്ല, മറിച്ച് സത്യത്തിന്റെ വെളിച്ചം തിരിച്ചറിയാൻ ഒരാൾ കടന്നുപോകേണ്ട ഒരു ഘട്ടമാണെന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "പല നവദുർഗ്ഗ പാരമ്പര്യങ്ങളിലും കാലരാത്രി പരമ്പരാഗതമായി സഹസ്രാര ചക്രവുമായി (കിരീട ചക്രം) ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "ദൈവികതയുമായുള്ള ഐക്യം",
          "ശുദ്ധമായ ബോധം",
          "ജ്ഞാനോദയം / ആത്മീയ ഉണർവ്",
          "മോക്ഷം / മുക്തി"
        ],
        "footer": "ചില താന്ത്രിക പാരമ്പര്യങ്ങൾ വ്യത്യസ്തമായ ചക്ര ക്രമീകരണങ്ങൾ നൽകുന്നുണ്ടെങ്കിലും, സാധാരണയായി പിന്തുടരുന്ന നവദുർഗ്ഗ ക്രമത്തിൽ, കാലരാത്രി ആരാധന സാധകനെ പരമമായ ആത്മീയ സാക്ഷാത്കാരത്തിന് സന്നദ്ധനാക്കുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ കാലരാത്രിയെ ആരാധിക്കുന്നത്:",
        "bullets": [
          "ഭയത്തിൽ നിന്നുള്ള മോചനം",
          "ദോഷകരമായ സ്വാധീനങ്ങളിൽ നിന്നുമുള്ള സംരക്ഷണം",
          "പ്രതിസന്ധികളിൽ ധൈര്യം",
          "അജ്ഞതയുടെ നിവാരണം",
          "ആത്മീയ പരിവർത്തനം",
          "സമാധാനവും മുക്തിയും"
        ],
        "footer": "ബുദ്ധിമുട്ടുള്ള ഘട്ടങ്ങളിൽ ശക്തി ലഭിക്കുന്നതിനും സ്വന്തം കോപം, ലോഭം, ആസക്തി, അഹങ്കാരം തുടങ്ങിയ ആന്തരിക ശത്രുക്കളെ നശിപ്പിക്കുന്നതിനും ദേവി പ്രത്യേകം പ്രാർത്ഥിക്കപ്പെടുന്നു."
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "ശർക്കര",
          "എള്ളിൻ പലഹാരങ്ങൾ",
          "തേങ്ങ",
          "കറുത്ത എള്ള്",
          "ചുവന്ന ചെമ്പരത്തിപ്പൂക്കൾ"
        ],
        "footer": "ശർക്കര വഴിപാടായി സമർപ്പിക്കുന്നത് ദുഃഖങ്ങൾ അകറ്റാനും മംഗളങ്ങൾ കൊണ്ടുവരാനും സഹായിക്കുമെന്ന് പല പാരമ്പര്യങ്ങളിലും വിശ്വസിക്കപ്പെടുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "കാലരാത്രി നമ്മെ പഠിപ്പിക്കുന്നത്:",
        "bullets": [
          "നമ്മൾ ഈശ്വരനിൽ പൂർണ്ണമായി ശരണം പ്രാപിക്കുമ്പോൾ ഭയം ഇല്ലാതാകുന്നു.",
          "അഹങ്കാരത്തിന്റെ നാശമാണ് യഥാർത്ഥ സ്വാതന്ത്ര്യത്തിന്റെ തുടക്കം.",
          "പലപ്പോഴും ഇരുട്ടാണ് ആത്മീയ ഉണർവിലേക്കുള്ള വഴി.",
          "ജഗദംബിക ഭക്തർക്ക് അതീവ ദയാമയിയും, അജ്ഞതയോടും തിന്മയോടും മാത്രം രൗദ്രഭാവം പൂണ്ടവളുമാണ്."
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
- Render back card details of Kalaratri and verify that the content is displayed in Malayalam.
