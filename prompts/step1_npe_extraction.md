# Step 1: NPE Extraction from Existing Outline

You are my story system designer. We are going to define a Narrative Physics Engine (NPE) for novel-length works by analyzing an existing outline.

## Your Task

Analyze the provided outline and extract the author's **generic writing preferences** (not specific to that particular book's plot or characters, but the underlying structural and stylistic patterns).

Your job is to:

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

3. **Turn these observations into a Narrative Physics Engine** organized into these sections:
   - **Plot mechanics & causality rules**
   - **Character logic rules**
   - **Pacing & time mechanics**
   - **Scene architecture**
   - **Dialogue physics**
   - **POV physics**
   - **Information economy**
   - **Stakes & pressure system**
   - **Off-stage narrative design**

## Critical Requirements

1. **Use positive constraints and functional prohibitions**, not negations.
   - ❌ BAD: "No deus ex machina"
   - ✅ GOOD: "External salvation is structurally impossible; major problems can only be resolved by character action built from prior setup."

2. **Write rules, not advice.**
   - ❌ BAD: "Try to make dialogue purposeful"
   - ✅ GOOD: "Every dialogue exchange must advance plot, reveal character, or establish information that will be used within 3 scenes."

3. **Make it explicit enough that another AI could follow it during outlining and drafting.**

4. **Extract GENERIC preferences** - applicable to any book, not just the one being analyzed.

## Output Format

Produce a complete **Narrative Physics Engine v1.0** in clean markdown with:

- Clear section headers
- Numbered rules within each section
- Explicit constraints written as declarative statements
- Functional prohibitions that define what CAN happen (not just what can't)

---

## The Outline to Analyze

{{OUTLINE_CONTENT}}

---

Now analyze this outline and produce the Narrative Physics Engine v1.0.
