# Plan - Add Malayalam Detailed Content to Kushmanda Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Kushmanda card (ID 4).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Kushmanda card (ID 4) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Kushmanda (ID 4):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "കൂശ്മാണ്ഡാ പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "സർഗ്ഗാത്മക ബുദ്ധി",
          "പ്രാണശക്തി / ജീവോർജ്ജം",
          "സമൃദ്ധി",
          "സന്തോഷവും ശുഭപ്രതീക്ഷയും",
          "ദൈവിക തേജസ്സ്",
          "ഇരുട്ടിനെ വെളിച്ചമാക്കി മാറ്റാനുള്ള ശക്തി"
        ],
        "footer": "പ്രപഞ്ചം തന്നെ ജഗദംബികയുടെ സർഗ്ഗാത്മക ചൈതന്യത്തിന്റെ ആവിഷ്കാരമാണെന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "കൂശ്മാണ്ഡാ പരമ്പരാഗതമായി അനാഹത ചക്രവുമായി (ഹൃദയ ചക്രം) ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "സ്നേഹം",
          "കാരുണ്യം",
          "ഐക്യം",
          "കൃതജ്ഞത",
          "ആന്തരിക സന്തുലിതാവസ്ഥ"
        ],
        "footer": "ദേവിയുടെ ആരാധന ശരീരത്തിനും മനസ്സിനും ഊർജ്ജം പകരുന്നതോടൊപ്പം ഹൃദയത്തെ ദൈവിക സ്നേഹത്താൽ വിശാലമാക്കുമെന്നും വിശ്വസിക്കപ്പെടുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ കൂശ്മാണ്ഡായെ ആരാധിക്കുന്നത്:",
        "bullets": [
          "നല്ല ആരോഗ്യവും ഊർജ്ജസ്വലതയും",
          "ഐശ്വര്യവും സമൃദ്ധിയും",
          "പുതിയ സംരംഭങ്ങളിലെ വിജയം",
          "രോഗങ്ങളുടെയും ബലഹീനതകളുടെയും നിവാരണം",
          "ആത്മീയ പ്രകാശം",
          "പോസിറ്റീവ് ഊർജ്ජവും സന്തോഷവും"
        ],
        "footer": "സൂര്യനുമായുള്ള ദേവിയുടെ ബന്ധം കാരണം, ആയുസ്സും ആരോഗ്യവും വീണ്ടെടുക്കുന്നതിനായി ഭക്തർ ദേവിയോട് പ്രത്യേകം പ്രാർത്ഥിക്കുന്നു."
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "മാൽപുവ (പല പാരമ്പര്യങ്ങളിലും നാലാം ദിവസത്തെ പൂജയുമായി പ്രത്യേകം ബന്ധപ്പെട്ടിരിക്കുന്നു)",
          "കുമ്പളങ്ങ (ദേവിയുടെ പേര് ഈ ഫലവുമായി ബന്ധപ്പെടുത്തുന്ന പാരമ്പര്യങ്ങളിൽ)",
          "പുതിയ പഴങ്ങൾ",
          "തേൻ",
          "മഞ്ഞ അല്ലെങ്കിൽ ഓറഞ്ച് നിറത്തിലുള്ള പൂക്കൾ"
        ],
        "footer": "ഈ വഴിപാടുകൾ പോഷണം, മധുരം, ജഗദംബികയുടെ ജീവദായകമായ സമൃദ്ധി എന്നിവയെ പ്രതീകപ്പെടുത്തുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "കൂശ്മാണ്ഡാ നമ്മെ ഓർമ്മിപ്പിക്കുന്നത്:",
        "bullets": [
          "സൃഷ്ടി ആരംഭിക്കുന്നത് ദൈവിക സങ്കല്പത്തിൽ നിന്നും സന്തോഷത്തിൽ നിന്നുമാണ്.",
          "ഒരു ചെറിയ വെളിച്ചത്തിന് പോലും വലിയ ഇരുട്ടിനെ അകറ്റാൻ കഴിയും.",
          "യഥാർത്ഥ സർഗ്ഗാത്മകത ഉണ്ടാകുന്നത് ആന്തരിക സമാധാനത്തിൽ നിന്നും ജ്ഞാനത്തിൽ നിന്നുമാണ്.",
          "പ്രപഞ്ചത്തെ നിലനിർത്തുന്ന അതേ ദൈവിക ഊർജ്ജം തന്നെയാണ് എല്ലാ ജീവികളിലും കുടികൊള്ളുന്നത്."
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
- Render back card details of Kushmanda and verify that the content is displayed in Malayalam.
