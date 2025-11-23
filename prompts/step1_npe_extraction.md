# Step 1: NPE Extraction from Existing Outline

You are my story system designer. We are going to define a Narrative Physics Engine (NPE) for novel-length works by analyzing an existing outline.

## Your Task

You will **use the provided NPE template as your foundation** and **enhance it** based on patterns found in the author's existing outline. The goal is to create a genre-specific, customized NPE that captures the author's **generic writing preferences** while maintaining the structural rigor of the template.

### Three-Phase Process:

#### Phase 1: Analyze the Outline

Examine the provided outline to identify the author's preferences and patterns:

1. **Identify patterns in the outline** that reveal the author's preferences:
   - How are cause-and-effect chains structured?
   - How do character decisions drive plot progression?
   - What pacing patterns appear (scene length, tension cycles, information release)?
   - How is dialogue used (function, frequency, style)?
   - What POV mechanics are employed?
   - How are stakes escalated?
   - What narrative constraints are implicitly followed?

2. **Infer dislikes** from what is NOT present or deliberately avoided:
   - Are there patterns that are conspicuously absent?
   - What common tropes or shortcuts are avoided?
   - What narrative "cheats" are not used?

3. **Identify the genre** or genre blend that this outline represents.

#### Phase 2: Enhance the Template

Using the NPE template as your base:

1. **Keep all existing template rules** that align with the outline's patterns
2. **Add new rules** to existing sections when you observe additional patterns specific to the author's style
3. **Fill in Section 7 (Genre-Alignment Rules)** with specific genre requirements, allowances, and constraints based on the identified genre
4. **Add clarifying examples** or sub-rules where the outline reveals nuanced preferences

#### Phase 3: Extract ONLY Generic Guidelines

**CRITICAL REQUIREMENT**: The final NPE must contain ONLY **generic, reusable guidelines** that could apply to ANY story the author writes—NOT story-specific details from this particular outline.

**Extract patterns, NOT plot points:**
- ✅ GOOD: "Romantic tension must build through misunderstandings rooted in character wounds, not external obstacles"
- ❌ BAD: "The protagonist must have trust issues from a past betrayal"

**Extract structural preferences, NOT specific characters/settings/events:**
- ✅ GOOD: "Each act must end with an irreversible choice that closes off previous options"
- ❌ BAD: "Act 1 must end with the protagonist accepting the quest to find the artifact"

**Extract dialogue mechanics, NOT specific conversations:**
- ✅ GOOD: "Characters deflect emotional vulnerability through humor or subject changes"
- ❌ BAD: "The mentor says 'You're not ready' when the protagonist asks about their past"

If you find yourself referencing specific character names, plot events, or world details from the outline, **stop and reframe it as a general pattern**.

## Critical Requirements

1. **Use positive constraints and functional prohibitions**, not negations.
   - ❌ BAD: "No deus ex machina"
   - ✅ GOOD: "External salvation is structurally impossible; major problems can only be resolved by character action built from prior setup."

2. **Write rules, not advice.**
   - ❌ BAD: "Try to make dialogue purposeful"
   - ✅ GOOD: "Every dialogue exchange must advance plot, reveal character, or establish information that will be used within 3 scenes."

3. **Make it explicit enough that another AI could follow it during outlining and drafting.**

4. **Extract GENERIC preferences** - applicable to any book the author writes, not just the one being analyzed.

## Output Format

**WORD COUNT LIMIT: 2,500 words maximum**

**Be concise and avoid redundancy:**
- No repetitive explanations or examples
- No verbose elaborations—state rules clearly and move on
- Eliminate unnecessary adjectives and qualifiers
- Keep rule descriptions focused and actionable

Produce a complete **Narrative Physics Engine v1.0** in clean markdown with:

- Clear section headers (use the template's structure)
- Numbered rules within each section
- Explicit constraints written as declarative statements
- Functional prohibitions that define what CAN happen (not just what can't)
- **Section 7 fully populated** with genre-specific rules

---

## NPE Template (Your Foundation)

{{NPE_TEMPLATE}}

---

## The Outline to Analyze

{{OUTLINE_CONTENT}}

---

Now analyze this outline and produce the enhanced, genre-customized Narrative Physics Engine v1.0 using the template as your base. Remember: extract ONLY generic patterns, never story-specific details.
