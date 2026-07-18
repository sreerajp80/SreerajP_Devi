# Plan - Add Malayalam Detailed Content to Brahmacharini Card Back

**Status:** approval_pending

This plan outlines the changes to add rich Malayalam spiritual significance, chakra association, blessings, offerings, and symbolic lessons to the back of the Brahmacharini card (ID 2).

---

## 1. What the issue is

The user wants to add several new Malayalam detailed content sections to the back side of the Brahmacharini card (ID 2) in addition to the existing description.

---

## 2. Proposed Changes

### Assets / Data Layer

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
We will insert the Malayalam translations in the `additionalSections` field for Brahmacharini (ID 2):

```json
    "additionalSections": [
      {
        "title": "ആത്മീയ പ്രാധാന്യം",
        "subtitle": "ബ്രഹ്മചാരിണി പ്രതിനിধീകരിക്കുന്നു:",
        "bullets": [
          "തപസ്സ്",
          "ക്ഷമ",
          "സ്വയംനിയന്ത്രണം",
          "നിശ്ചയദാർഢ്യം",
          "ഭക്തി",
          "ആത്മീയ പരിശീലനത്തിലെ സ്ഥിരത"
        ],
        "footer": "ശാശ്വതമായ മാറ്റം ഉണ്ടാകുന്നത് നിരന്തരമായ പരിശ്രമത്തിലൂടെയാണ്, കുറുക്കുവഴികളിലൂടെയല്ല എന്ന് ദേവി പഠിപ്പിക്കുന്നു."
      },
      {
        "title": "ബന്ധപ്പെട്ട ചക്രം",
        "subtitle": "ബ്രഹ്മചാരിണി പരമ്പരാഗതമായി സ്വാധിഷ്ഠാന ചക്രവുമായി ബന്ധപ്പെട്ടിരിക്കുന്നു.",
        "bullets": [
          "വൈകാരിക സമനില",
          "സർഗ്ഗാത്മകത",
          "സ്വയം അച്ചടക്കം",
          "ആഗ്രഹങ്ങളുടെ ശുദ്ധീകരണം",
          "ആന്തരിക കരുത്ത്"
        ],
        "footer": "നവദുർഗ്ഗ പാരമ്പര്യത്തിൽ, സാധകന്റെ ഊർജ്ജം മൂലാധാരത്തിന്റെ (ശൈലപുത്രി) സ്ഥിരതയിൽ നിന്ന് അച്ചടക്കമുള്ള പരിശീലനത്തിലൂടെ കൂടുതൽ ശുദ്ധമായ അവസ്ഥയിലേക്ക് ഉയരുന്നു."
      },
      {
        "title": "ആരാധനയുടെ അനുഗ്രഹങ്ങൾ",
        "subtitle": "ദേവിയെ ആരാധിക്കുന്നതിലൂടെ ഭക്തർക്ക് ലഭിക്കുന്നത്:",
        "bullets": [
          "പ്രതിസന്ധികളെ തരണം ചെയ്യാനുള്ള ശക്തി",
          "മാനസിക സമാധാനവും വൈകാരിക സമനിലയും",
          "വിദ്യാഭ്യാസത്തിലും ആത്മീയ പഠനത്തിലും വിജയം",
          "ക്ഷമയും സ്ഥിരതയും",
          "ജ്ഞാനവും സ്വയംനിയന്ത്രണവും",
          "ആത്മീയ പാതയിലെ പുരോഗതി"
        ],
        "footer": "വിദ്യാർത്ഥികൾ, സാധകർ, വ്രതങ്ങൾ അല്ലെങ്കിൽ കഠിനമായ അച്ചടക്കങ്ങൾ അനുഷ്ഠിക്കുന്നവർ എന്നിവർ ഈ രൂപത്തെ പ്രത്യേകം ആരാധിക്കുന്നു."
      },
      {
        "title": "പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)",
        "subtitle": "പരമ്പരാഗതമായി സമർപ്പിക്കുന്നത്:",
        "bullets": [
          "ശർക്കര/പഞ്ചസാര",
          "കൽക്കണ്ടം",
          "പഴങ്ങൾ",
          "പാലും തൈരും",
          "വെളുത്ത പൂക്കൾ"
        ],
        "footer": "പanchസാര സമർപ്പിക്കുന്നത് സംസാരത്തിലും ബന്ധങ്ങളിലും ജീവിതത്തിലും മധുരം നിറയ്ക്കുന്നതിനെ സൂചിപ്പിക്കുന്നു എന്നാണ് പരമ്പരാഗത വിശ്വാസം."
      },
      {
        "title": "പ്രതീകാത്മക പാഠങ്ങൾ",
        "subtitle": "ബ്രഹ്മചാരിണി നമ്മെ ഓർമ്മിപ്പിക്കുന്നത്:",
        "bullets": [
          "മഹത്തായ ലക്ഷ്യങ്ങൾക്ക് നിരന്തരമായ പരിശ്രമം ആവശ്യമാണ്.",
          "യഥാർത്ഥ ശക്തി എന്നത് സ്വയം നിയന്ത്രിക്കാനുള്ള കഴിവാണ്.",
          "ക്ഷമയും അച്ചടക്കവും ബലപ്രയോഗത്തേക്കാൾ ശക്തമാണ്.",
          "ദൈവികതയിലേക്ക് വെക്കുന്ന ഓരോ ആത്മാർത്ഥമായ ചുവടും ഒരു ആരാധനയാണ്."
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
- Render back card details of Brahmacharini and verify that the content is displayed in Malayalam.
