# Plan - Add Malayalam Detailed Content to Mahagauri Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Mahagauri card (ID 8).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Mahagauri card (ID 8) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Mahagauri (ID 8):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "മഹാഗൗരി പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "വിശുദ്ധി / പരിശുദ്ധി",
          "ക്ഷമ",
          "ആന്തരിക സമാധാനം",
          "കാരുണ്യം",
          "മുൻകാല കർമ്മങ്ങളിൽ നിന്നുള്ള മോചനം",
          "ആത്മീയ ശുദ്ധീകരണം"
        ],
        "footer": "കഠിനമായ പരീക്ഷണങ്ങളെ അതിജീവിക്കുകയും അജ്ഞതയെ മറികടക്കുകയും ചെയ്ത ശേഷം, ആത്മാവ് അതിന്റെ സഹജമായ വിശുദ്ധിയാൽ സ്വാഭാവികമായി പ്രകാശിക്കുമെന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "പല പാരമ്പര്യങ്ങളിലും മഹാഗൗരി ശുദ്ധീകരിക്കപ്പെട്ട സഹസ്രാര ചക്രവുമായി (കിരീട ചക്രം) അല്ലെങ്കിൽ പൂർണ്ണമായി ഉണർന്ന ബോധാവസ്ഥയുമായി ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "പൂർണ്ണമായ ശുദ്ധീകരണം",
          "ദൈവിക കൃപ",
          "ആന്തരിക സമാധാനം",
          "ആത്മീയ പ്രകാശം",
          "പരമമായ സാക്ഷാത്കാരത്തിന്റെ സാമീപ്യം"
        ],
        "footer": "ചില പാരമ്പര്യങ്ങളിൽ ചക്ര ക്രമീകരണത്തിൽ വ്യത്യാസങ്ങളുണ്ടെങ്കിലും, മഹാഗൗരി ആന്തരിക ശുദ്ധീകരണത്തിന്റെ പരകോടിയെ പ്രതിനിധീകരിക്കുന്നു എന്നതിൽ എല്ലാവരും യോജിക്കുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ മഹാഗൗരിയെ ആരാധിക്കുന്നത്:",
        "bullets": [
          "സമാധാനവും സന്തോഷവും",
          "മനസ്സിന്റെയും ഹൃദയത്തിന്റെയും ശുദ്ധീകരണം",
          "കുടുംബജീവിതത്തിലെ ഐക്യം",
          "നല്ല ആരോഗ്യം",
          "മുൻകാല പാപങ്ങളുടെയും കർമ്മഭാരങ്ങളുടെയും നിവാരണം",
          "ആത്മീയ പുരോഗതിയും ദൈവിക കൃപയും"
        ],
        "footer": "ശാന്തവും സദ്ഗുണസമ്പന്നവും ആത്മീയമായി ഉന്നതിയിലുള്ളതുമായ ജീവിതം ആഗ്രഹിക്കുന്നവർ ദേവിയെ പ്രത്യേകം വണങ്ങുന്നു."
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "തേങ്ങ",
          "പാൽ",
          "വെളുത്ത മധുരപലഹാരങ്ങൾ",
          "പായസം",
          "വെളുത്ത പൂക്കൾ"
        ],
        "footer": "വെളുത്ത നിറത്തിലുള്ള വഴിപാടുകൾ വിശുദ്ധിയെയും ഭക്തിയെയും പ്രതീകപ്പെടുത്തുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "മഹാഗൗരി നമ്മെ പഠിപ്പിക്കുന്നത്:",
        "bullets": [
          "യഥാർത്ഥ സൗന്ദര്യം ഉണ്ടാകുന്നത് ഹൃദയശുദ്ധിയിൽ നിന്നാണ്.",
          "ക്ഷമിക്കുക എന്നത് ആത്മീയ ശക്തിയുടെ അടയാളമാണ്.",
          "ആത്മാർത്ഥമായ ഭക്തിയിലൂടെയും ധർമ്മനിഷ്ഠമായ ജീവിതത്തിലൂടെയും ഏതൊരു ആത്മാവിനെയും ശുദ്ധീകരിക്കാൻ കഴിയും.",
          "ഓരോ ഇരുണ്ട കാലഘട്ടത്തിനു ശേഷവും ജ്ഞാനത്തിന്റെയും സമാധാനത്തിന്റെയും വെളിച്ചം കടന്നുവരുന്നു."
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
- Render back card details of Mahagauri and verify that the content is displayed in Malayalam.
