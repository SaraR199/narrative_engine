# Relationships Concept

This file contains concepts for **multiple character relationships**. The orchestrator will spawn a separate character-architect agent for each relationship and run them **in parallel**.

## Format

Use the following structure to define multiple relationships:

```markdown
# RELATIONSHIP: [Character A] & [Character B]

**Situation:**
[2-4 sentences describing their situation in the story, what brings them together, what role each plays in the other's arc]

---

# RELATIONSHIP: [Character C] & [Character D]

**Situation:**
[2-4 sentences...]

---
```

**Important:**
- Each relationship section must start with `# RELATIONSHIP: [Name A] & [Name B]`
- Separate relationships with `---` (three dashes)
- Relationship names will be used for output filenames (e.g., `relationship_Sarah_Marcus.md`)
- Use the exact character names from your character-concept.md file

---

## What to Include Per Relationship

### Situation Description

For each relationship, provide:
- **Context:** How do they know each other? What's their current situation?
- **Story function:** What narrative purpose does this relationship serve?
- **Initial dynamic:** What's the baseline tension or connection?
- **Arc potential:** How might this relationship change?

Keep it brief (2-4 sentences). The relationship architect will build the full architecture from this.

---

## Example: Multiple Relationships

```markdown
# RELATIONSHIP: Sarah Chen & Marcus Reed

Sarah is investigating Marcus's surveillance company, suspecting it of illegal data harvesting. Marcus sees Sarah as a threat to his mission but is also intrigued by her - she's one of the few people who seems to understand the complexity of what he's built, even if she opposes it. They're intellectual opponents circling each other, each convinced they're on the right side.

---

# RELATIONSHIP: Sarah Chen & Dr. Elena Vasquez

Elena was Sarah's mentor at the police force and continues to check in on her, worried about Sarah's increasing cynicism and isolation. Sarah respects Elena deeply but is also frustrated by what she sees as Elena's naive optimism about reforming broken systems. Their relationship is strained by mutual disappointment - Elena sees Sarah giving up, Sarah sees Elena enabling corruption through patience.

---

# RELATIONSHIP: Marcus Reed & Dr. Elena Vasquez

Elena has been brought in as a consultant to assess the psychological impact of Marcus's surveillance systems. Marcus respects her credentials but dismisses her concerns as academic hand-wringing, while Elena sees Marcus as a tragic figure using technology to avoid processing his grief. They represent two different responses to trauma - control vs. acceptance.

---
```

## Notes

- The orchestrator will parse this file and spawn **one character-architect agent per relationship**
- All agents run **in parallel** for efficiency
- Each relationship gets a separate output file: `outputs/relationship_[CharacterA]_[CharacterB].md`
- Relationship architecture will reference character profiles from Step 4
- Focus on relationships that **matter to the plot** - not every character pair needs a relationship spec
- Typically 3-6 key relationships for a novel

---

## Which Relationships to Include

**Include relationships that:**
- Drive major plot decisions
- Create recurring conflict or connection
- Evolve significantly across the story
- Represent thematic tensions

**Skip relationships that are:**
- Purely functional (e.g., "shopkeeper character A buys from")
- Static throughout the story
- Minor or one-scene interactions

---

**Instructions**: Replace the content above with your actual relationship concepts. Focus on the relationships that need architectural definition for consistent, evolving interactions throughout your story.
