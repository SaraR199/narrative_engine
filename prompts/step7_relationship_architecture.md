# Step 7: Relationship Architecture

## Objective

You are a relationship architect. You will receive two characters and a brief description of their situation in the story (extracted in Step 6: Relationship Mapping).

Your job is to define a **Relationship Architecture spec** that another AI can use to write consistent, evolving interactions.

## Context

You will receive:
- **Relationship Mapping**: The specific relationship pairing and situation (from Step 6)
- **Character A Profile**: Full character development from Step 4
- **Character B Profile**: Full character development from Step 4
- **NPE (Narrative Physics Engine)**: The author's structural preferences
- **Dramatic Spine**: Tension axes and emotional progression for the overall story
- **Themes**: The thematic questions the story explores
- **World Constraints**: Functional limits that affect all relationships

The relationship situation has already been identified as important in Step 6 (Relationship Mapping), so you can assume this relationship warrants detailed architectural treatment.

## Relationship Architecture Components

Use these components to build a complete relationship spec:

### 1) Relationship Spine

The core tension/connection that defines this pairing.

**Define:**
- **What binds them together?** (Shared goal, history, obligation, attraction, etc.)
- **What fundamentally pushes them apart?** (Conflicting values, competing goals, fear, resentment, etc.)
- **What unresolved emotional truth sits between them?** (What neither can say or face?)

### 2) Tension Axes

Choose **1-2 primary axes** from these options (or define custom ones):
- **Power:** dominant ↔ challenger
- **Trust:** guarded ↔ open
- **Desire:** wanting ↔ resisting
- **Values:** idealistic ↔ pragmatic
- **Loyalty:** committed ↔ self-preserving
- **Emotional maturity:** avoidant ↔ vulnerable

**For each axis, specify:**
- Where Character A sits on this axis (and why)
- Where Character B sits on this axis (and why)
- How this difference manifests in scenes
- Whether/how their positions shift across the story

### 3) Friction Patterns

Identify **2-3 recurring patterns** for how conflict flares between them.

**Examples:**
- One withdraws, one pursues
- One jokes to deflect, one takes offense
- Competence clash (both think they know best)
- Avoidance vs. confrontation
- Public performance vs. private resentment
- Intellectual sparring that masks emotional stakes

**For each pattern:**
- Describe the trigger
- Describe the typical escalation
- Describe how it usually resolves (or doesn't)

### 4) Connection Patterns

Identify **2-3 recurring patterns** for how they bond or find ease together.

**Examples:**
- Shared humor or inside jokes
- Shared mission or external enemy
- Repeating ritual (coffee runs, late-night talks, sparring sessions)
- Caretaking behavior (one tends to the other)
- Creative collaboration
- Comfortable silence
- Protective instinct

**For each pattern:**
- Describe what triggers the connection
- Describe what it looks/feels like
- Describe any vulnerability or intimacy it creates

### 5) Relational Arc Phases

Define how this relationship evolves across the three-act structure:

**Act I: Baseline Dynamic**
- What is their starting relationship status?
- What keeps them apart or misaligned?
- What prevents deeper connection or resolution?
- What do they each want from the other (even if unspoken)?

**Midpoint: Shift**
- What event or revelation changes the dynamic?
- What new trust emerges? Or what new conflict?
- How do the tension axes shift?
- What becomes possible (or impossible) that wasn't before?

**Act III: Convergence or Rupture**
- Do they ultimately converge (grow closer, align) or rupture (break, separate)?
- What decision or revelation defines the final state of this relationship?
- How does this resolution connect to the story's themes?
- What does each character gain or lose through this relationship?

### 6) Pressure Points

List **3-5 specific events or types of events** that especially stress this relationship.

**Examples:**
- Betrayal (real or perceived)
- Revelation of a secret
- Forced proximity under stress
- Crisis requiring trust
- Third-party interference
- Moral test (one must choose between the other and something else)
- Public vs. private conflict

**For each pressure point:**
- Why it hits this relationship particularly hard
- How each character is likely to react
- What it risks breaking or deepening

### 7) Relationship-Specific Dialogue & Subtext

Define the communication dynamics between these two characters:

**How does Character A speak to Character B differently than to others?**
- Tone, formality, vocabulary, topics they raise/avoid

**How does Character B speak to Character A differently than to others?**
- Tone, formality, vocabulary, topics they raise/avoid

**What does Character A want from Character B but not say?**
- Unspoken needs, hopes, fears

**What does Character B want from Character A but not say?**
- Unspoken needs, hopes, fears

**What does Character A consistently misread about Character B?**
- False assumptions, blind spots

**What does Character B consistently misread about Character A?**
- False assumptions, blind spots

---

## Constraints

1. **Compatibility with Character Profiles**
   - Make these patterns compatible with the existing character profiles for Character A and Character B
   - Reference specific traits, fears, wounds, and goals from the character profiles
   - Ensure relationship dynamics emerge logically from character psychology

2. **Three-Act Tracking**
   - Ensure the relationship dynamics can be tracked across the three arc phases
   - Later prompts should be able to say "write an Act II scene" and the tone will naturally differ from Act I
   - Make phase transitions clear and motivated

3. **Thematic Resonance**
   - Connect the relationship to the story's themes where appropriate
   - This relationship should test, complicate, or illuminate at least one theme

4. **World-Grounded**
   - Consider how world constraints affect this relationship
   - Social rules, power structures, and practical limits should shape interactions

---

## Output Format

**WORD COUNT LIMITS:**
- **Main romance relationship: 2,000 words maximum**
- **Other relationships: 1,000 words maximum**

**Be concise and avoid redundancy:**
- No repetitive phrasing across friction/connection patterns
- Keep tension axis descriptions focused
- Eliminate verbose explanations of relationship dynamics
- Avoid over-elaborating on act-by-act evolution—be specific but brief

Structure your relationship architecture document as follows:

```markdown
# Relationship Architecture: [Character A] & [Character B]

## 1. Relationship Spine

**What binds them together:**
[Answer]

**What pushes them apart:**
[Answer]

**Unresolved emotional truth:**
[Answer]

---

## 2. Tension Axes

### [Axis Name]: [Position A] ↔ [Position B]

**Character A ([Name]) position:**
[Where they sit and why]

**Character B ([Name]) position:**
[Where they sit and why]

**How this manifests in scenes:**
[Specific behaviors]

**Arc shift:**
[How positions change, if at all]

[Repeat for second axis if applicable]

---

## 3. Friction Patterns

### Pattern 1: [Pattern Name]

**Trigger:**
[What sets it off]

**Escalation:**
[How it unfolds]

**Resolution:**
[How it typically ends]

[Repeat for 2-3 patterns]

---

## 4. Connection Patterns

### Pattern 1: [Pattern Name]

**Trigger:**
[What creates the connection]

**What it looks like:**
[Observable behavior]

**Vulnerability created:**
[What's at risk or revealed]

[Repeat for 2-3 patterns]

---

## 5. Relational Arc Phases

### Act I: Baseline Dynamic

**Starting status:**
[Current relationship state]

**What keeps them apart/misaligned:**
[Barriers to connection or resolution]

**What prevents deeper connection:**
[Specific obstacles]

**Unspoken wants:**
- Character A wants: [...]
- Character B wants: [...]

### Midpoint: Shift

**Catalyst for change:**
[Event or revelation]

**New trust or conflict:**
[What emerges]

**Tension axis shifts:**
[How dynamics change]

**New possibilities/impossibilities:**
[What changes]

### Act III: Convergence or Rupture

**Final trajectory:**
[Converge or rupture?]

**Defining moment:**
[Key decision or revelation]

**Thematic connection:**
[How this relates to story themes]

**Gains and losses:**
- Character A: [...]
- Character B: [...]

---

## 6. Pressure Points

1. **[Pressure Point Name]**
   - Why it hits hard: [...]
   - Character A reaction: [...]
   - Character B reaction: [...]
   - Risk: [What might break or deepen]

[Repeat for 3-5 pressure points]

---

## 7. Dialogue & Subtext

### How They Speak to Each Other

**Character A → Character B:**
[Tone, style, topics, what's different from how they talk to others]

**Character B → Character A:**
[Tone, style, topics, what's different from how they talk to others]

### Unspoken Wants

**Character A wants but doesn't say:**
[List]

**Character B wants but doesn't say:**
[List]

### Consistent Misreadings

**Character A misreads Character B:**
[Specific blind spots or false assumptions]

**Character B misreads Character A:**
[Specific blind spots or false assumptions]
```

---

## Deliverable

Write the complete Relationship Architecture document following the output format above.

Save your final analysis to: `outputs/relationship_[CharacterA]_[CharacterB].md`

(The orchestrator will handle filename generation based on the character names.)
