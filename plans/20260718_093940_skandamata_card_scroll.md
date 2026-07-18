# Plan - Add Malayalam Detailed Content to Skandamata Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Skandamata card (ID 5).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Skandamata card (ID 5) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Skandamata (ID 5):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "സ്കന്ദമാതാ പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "നിരുപാധികമായ സ്നേഹം",
          "കാരുണ്യം",
          "സംരക്ഷണം",
          "നിസ്വാർത്ഥ സേവനം",
          "വളർത്തിയെടുക്കുന്ന ജ്ഞാനം",
          "ആത്മീയ പക്വത"
        ],
        "footer": "യഥാർത്ഥ ശക്തി പ്രകടമാകുന്നത് സ്നേഹത്തിലൂടെയും ക്ഷമയിലൂടെയും മറ്റുള്ളവരെ പരിചരിക്കാനുള്ള സന്നദ്ധതയിലൂടെയുമാണെന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "സ്കന്ദമാതാ പരമ്പരാഗതമായി വിശുദ്ധി ചക്രവുമായി (തൊണ്ടയിലെ ചക്രം) ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "സത്യസന്ധമായ ആവിഷ്കാരം",
          "വിശുദ്ധി / ശുദ്ധി",
          "ഭക്തി",
          "ആശയвиനിമയം",
          "ഉന്നതമായ അറിവ് / ധാരണ"
        ],
        "footer": "സാധകന്റെ ആത്മീയ ഊർജ്ജം ഉയരുമ്പോൾ, സംസാരത്തിന്റെ ശുദ്ധീകരണവും ദയയോടും വ്യക്തതയോടും കൂടി സത്യം പ്രകടിപ്പിക്കാനുള്ള കഴിവും വിശുദ്ധി ചക്രം പ്രതിഫലിപ്പിക്കുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ സ്കന്ദമാതാവിനെ ആരാധിക്കുന്നത്:",
        "bullets": [
          "ആരോഗ്യമുള്ള കുട്ടികളും കുടുംബ ഐക്യവും",
          "മാതൃതുല്യമായ സംരക്ഷണം",
          "ജ്ഞാനവും ആത്മീയ വളർച്ചയും",
          "സമാധാനവും ഐശ്വര്യവും",
          "ധൈര്യവും വിജയവും",
          "ഭക്തിയിലൂടെയുള്ള മുക്തി"
        ],
        "footer": "സ്കന്ദമാതാവിനെ ആരാധിക്കുന്നത് സ്കന്ദഭഗവാന്റെ (സുബ്രഹ്മണ്യന്റെ) അനുഗ്രഹങ്ങൾ കൂടി നൽകുമെന്ന് പറയപ്പെടുന്നു."
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "നേന്ത്രപ്പഴം / വാഴപ്പഴം (പല പാരമ്പര്യങ്ങളിലും അഞ്ചാം ദിവസത്തെ പൂജയുമായി പ്രത്യേകം ബന്ധപ്പെട്ടിരിക്കുന്നു)",
          "മഞ്ഞനിറമുള്ള പഴങ്ങൾ",
          "പായസം",
          "പാൽ",
          "താമരപ്പൂക്കൾ"
        ],
        "footer": "വാഴപ്പഴം പോഷണം, ഫലഭൂയിഷ്ഠത, മംഗളകരമായ കാര്യങ്ങൾ എന്നിവയെ പ്രതീകപ്പെടുത്തുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "സ്കന്ദമാതാ നമ്മെ ഓർമ്മിപ്പിക്കുന്നത്:",
        "bullets": [
          "ഏറ്റവും ഉയർന്ന ശക്തി പ്രകടമാകുന്നത് സ്നേഹത്തിലൂടെയും കാരുണ്യത്തിലൂടെയുമാണ്.",
          "ഒരു അമ്മയുടെ പരിചരണം ശരീരത്തെ മാത്രമല്ല ആത്മാവിനെയും വളർത്തുന്നു.",
          "ശക്തിയോടൊപ്പം ദയയും ചേരുമ്പോഴാണ് ജ്ഞാനം വളരുന്നത്.",
          "വിശ്വാസത്തോടെ ശരണം പ്രാപിക്കുന്നവരെ ജഗദംബിക എപ്പോഴും സംരക്ഷിക്കുന്നു."
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
- Render back card details of Skandamata and verify that the content is displayed in Malayalam.
