Hangul Input Flow
=================

This document demonstrates how the hangul input is implemented.
It is used as a base for the actual implementation in the dart code in this project.

The `HangulInput` instance bears a string that represents the user's input.
The method `HangulInput.pushCharacter` allows to send inputs to the internal string.

Here is the flowchart of the `HangulInput.pushCharacter` method:

Legend:
 - `CFC` stands for "Current final character". That is the current last character in the `HangulInput`
internal string.
 - `NC` stands for "New character". That is the string being passed to the method `pushCharacter`.
 - `LJ` stands from "Last jamo". That is the final jamo found in the CFL.

### Global flowchart:

```mermaid
graph TD
  A("pushCharacter(NC)") --> B{NC is a jamo? <br/> AND Has no break?}
  B --> |No| C["concatCharacter(NC)"]
  B --> |Yes| D{CFC is a valid cho jamo?}
  D --> |Yes| E("addToShow(NC)")
  D --> |No| F{CFC is a valid<br/>hangul syllable?}
  F --> |No| C
  F --> |Yes| G{CFC syllable has<br/>a jong jamo?}
  G --> |Yes| H("addToJong(NC)")
  G --> |Yes| I("addToJung(NC)")
```

### If last char is a cho

```mermaid
graph TD
  A("addToCho(NC)") --> B{CFC+NC is a valid<br/>cho combination?}
  B --> |Yes| C["replaceFinalCharacter(combineCho(CFC+NC))"]
  B --> |No| D{NC is a valid jung jamo?}
  D --> |Yes| E["replaceFinalCharacter(syllable(CFC, NC))"]
  D --> |No| F["concatCharacter(NC)"]
```

### If last char is a jung

```mermaid
graph TD
  A("addToJung(NC)") --> B{LJ+NC is a valid<br/>jung combination?}
  B --> |Yes| C["replaceFinalCharacter(combineJung(CFC+NC))"]
  B --> |No| D{NC is a valid jong jamo?}
  D --> |Yes| E["replaceFinalCharacter(syllable(CFC.cho, CFC.jung, NC))"]
  D --> |No| F["concatCharacter(NC)"]
```

### If last char is a jong

```mermaid
graph TD
  A("addToJong(NC)") --> B{LJ+NC is a valid<br/>jong combination?}
  B --> |Yes| C["replaceFinalCharacter(combineJong(CFC+NC))"]
  B --> |No| D{NC is a valid jung jamo?}
  D --> |No| H["concatCharacter(NC)"]
  D --> |Yes| E{LJ is a combined jong jamo}
  E --> |Yes| F[Uncombine LJ into 2 jamos.<br/>First jamos goes to CFC jong.<br/>Second jamos makes a new syllable as a Cho + NC as a jung]
  E --> |NO| G[Remove jong from CFC.<br/>Use CFC jong as cho of a new syllable + NC as jung]
```