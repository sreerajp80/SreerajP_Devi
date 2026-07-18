# Plan - Add Malayalam Detailed Content to Shailaputri Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Shailaputri card. It also restructures the card layout to support scrolling for this additional content while keeping the mantra at the top and audio controls at the bottom.

---

## 1. What the issue is

The user wants the detailed sections (Spiritual Significance, Associated Chakra, Blessings of Worship, Favorite Offerings, Symbolic Lessons) to be in Malayalam.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Shailaputri (ID 1):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "ശൈലപുത്രി പ്രതിനിധീകരിക്കുന്നു:",
        "bullets": [
          "പർവ്വതത്തെപ്പോലെയുള്ള ദൃഢതയും സ്ഥിരതയും",
          "ഉദ്ദേശശുദ്ധി",
          "ധർമ്മത്തോടുള്ള ഭക്തി",
          "ആത്മീയ പാത ആരംഭിക്കാനുള്ള ധൈര്യം",
          "ഭൂമിദേവിയുമായും പ്രകൃതിയുമായുമുള്ള ബന്ധം"
        ],
        "footer": "യഥാർത്ഥ ആത്മീയ വളർച്ച സുസ്ഥിരവും അച്ചടക്കമുള്ളതുമായ ഒരു അടിത്തറയിൽ നിന്നാണ് ആരംഭിക്കുന്നതെന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "ശൈലപുത്രി മൂലാധാര ചക്രവുമായി ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "സ്ഥിരത",
          "ഗ്രൗണ്ടിംഗ് / സുസ്ഥിരത",
          "സുരക്ഷിതത്വം",
          "ശാരീരിക ഊർജ്ജസ്വലത",
          "ആത്മീയ ഉണർവിന്റെ അടിത്തറ"
        ],
        "footer": "പല യോഗ പാരമ്പര്യങ്ങളിലും, ശൈലപുത്രി ആരാധന മൂലാധാരത്തിൽ നിന്ന് ഉറങ്ങിക്കിടക്കുന്ന ആത്മീയ ഊർജ്ജത്തെ (കുണ്ഡലിനി) ഉണർത്തുന്നതിനെ പ്രതീകപ്പെടുത്തുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ഭക്തർ ശൈലപുത്രിയോട് പ്രാർത്ഥിക്കുന്നത്:",
        "bullets": [
          "ശാരീരികവും മാനസികവുമായ ശക്തി",
          "നല്ല ആരോഗ്യം",
          "ജീവിതത്തിലെ സ്ഥിരത",
          "പുതിയ തുടക്കങ്ങളിലെ വിജയം",
          "ആത്മീയ പുരോഗതി",
          "ഭയത്തിന്റെയും തടസ്സങ്ങളുടെയും നിവാരണം"
        ]
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "ശുദ്ധമായ പശുവിൻ നെയ്യ്",
          "വെളുത്ത പൂക്കൾ",
          "കൂവളത്തില (ശിവപൂജയിൽ പ്രത്യേകം)",
          "പുതിയ പഴങ്ങൾ",
          "പാല് കൊണ്ടുള്ള മധുരപലഹാരങ്ങൾ"
        ],
        "footer": "നെയ്യ് സമർപ്പിക്കുന്നത് ആരോഗ്യവും ആയുസ്സും വർദ്ധിപ്പിക്കുമെന്ന് പല പാരമ്പര്യങ്ങളിലും വിശ്വസിക്കപ്പെടുന്നു."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "ശൈലപുത്രി നമ്മെ ഓർമ്മിപ്പിക്കുന്നത്:",
        "bullets": [
          "ഏതൊരു മഹത്തായ യാത്രയും ഒരു ചെറിയ ചുവടുവെപ്പിലൂടെയാണ് ആരംഭിക്കുന്നത്.",
          "ആത്മീയ പുരോഗതിക്ക് ക്ഷമയും അച്ചടക്കവും ആവശ്യമാണ്.",
          "വിനയവും ദൃഢതയും അഹങ്കാരത്തേക്കാൾ ശക്തമാണ്.",
          "ഒരു പർവ്വതം പോലെ, ധർമ്മത്തിൽ വേരൂന്നി നിൽക്കുമ്പോൾ തന്നെ ജീവിതത്തിലെ കൊടുങ്കാറ്റുകളിൽ ചഞ്ചലപ്പെടാതെ നിലകൊള്ളണം."
        ]
      }
    ]
```

### Models & Repositories

#### [MODIFY] [durga_model.dart](file:///l:/Android/SreerajP_Devi/lib/models/durga_model.dart)
- Configured to hold the definition of `AdditionalSection` and `additionalSections` property (already implemented).

### UI Component Layer

#### [MODIFY] [flipping_card.dart](file:///l:/Android/SreerajP_Devi/lib/widgets/flipping_card.dart)
- Configured to render `additionalSections` correctly (already implemented).

### Test Layer

#### [MODIFY] [durga_repository_test.dart](file:///l:/Android/SreerajP_Devi/test/durga_repository_test.dart)
- Update mock JSON string to use Malayalam translation titles for verification.

---

## 3. Verification Plan

### Automated Tests
- Run `flutter test` in `l:\Android\SreerajP_Devi`.

### Manual Verification
- Render back card details of Shailaputri and verify that the content is displayed in Malayalam.
