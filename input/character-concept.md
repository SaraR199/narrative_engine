# Character Concepts

This file contains concepts for **multiple characters**. The orchestrator will spawn a separate character-architect agent for each character and run them **in parallel**.

## Format

Use the following structure to define multiple characters:

```markdown
# CHARACTER: [Character Name]

[1-3 paragraphs with role, vibes, backstory, strengths/weaknesses]

---

# CHARACTER: [Another Character Name]

[1-3 paragraphs...]

---
```

**Important:**
- Each character section must start with `# CHARACTER: [Name]`
- Separate characters with `---` (three dashes)
- Character names will be used for output filenames (e.g., `character_John_Smith.md`)

---

## What to Include Per Character

### Role in Story
- Protagonist, antagonist, mentor, ally, etc.
- What narrative function they serve

### Vibes & Personality
- General personality traits
- How they feel to be around
- Initial impression they give

### Rough Backstory
- Key formative experiences
- What shaped who they are today
- Any relevant history

### Strengths & Weaknesses
- What they're naturally good at
- What they struggle with
- Skills and limitations

---

## Example: Multiple Characters

```markdown
# CHARACTER: Sarah Chen

Sarah is the protagonist, a 32-year-old former detective turned private investigator.
She has a sharp, analytical mind and can read people instantly, but this same skill
makes her cynical and isolated - she assumes everyone is hiding something because,
in her experience, they usually are.

She grew up in a family of con artists, which taught her to spot lies and manipulation
from an early age. This made her excellent at detective work but terrible at trusting
anyone. She left the police force after discovering corruption at the highest levels,
losing her idealism in the process.

Strengths: Pattern recognition, interrogation, research, staying calm under pressure.
Weaknesses: Paranoid, pushes people away, struggles to ask for help, drinks too much
when stressed. Can't accept that some people are genuinely good.

---

# CHARACTER: Marcus Reed

Marcus is the antagonist, a charismatic tech CEO in his mid-40s who genuinely believes
his surveillance empire makes the world safer. He's not a mustache-twirling villain -
he's someone who traded privacy for security and thinks everyone else should too.

Former military intelligence officer who saw too many preventable tragedies. Built his
company on the promise of "if we'd known sooner, we could have stopped it." His wife
died in a terrorist attack he believes better surveillance could have prevented. Now
he's obsessed with eliminating uncertainty through total information awareness.

Strengths: Strategic thinking, public speaking, building coalitions, genuinely magnetic.
Weaknesses: Can't see the authoritarianism in his own position, dismisses dissent as
ignorance, treats people as data points, refuses to acknowledge his grief drives his
mission.

---

# CHARACTER: Dr. Elena Vasquez

Elena is Sarah's mentor figure, a forensic psychologist in her 60s who worked with
Sarah at the police force. She's warm, insightful, and has an uncanny ability to
see through people's defenses - but uses it with compassion rather than cynicism.

Grew up in a tight-knit community, saw firsthand how people are complex and
contradictory. Her approach is "people are capable of terrible things AND capable
of change." Stayed in the system to reform it from within, while Sarah left.
Their relationship is strained by this philosophical difference.

Strengths: Reading people, de-escalation, long-game thinking, emotional intelligence.
Weaknesses: Too patient with broken systems, sometimes enables bad actors by seeing
their humanity, avoids confrontation even when necessary.

---
```

## Notes

- The orchestrator will parse this file and spawn **one character-architect agent per character**
- All agents run **in parallel** for efficiency
- Each character gets a separate output file: `outputs/character_[Name].md`
- All characters will be developed using the same NPE (from Step 1)
- Be specific about behaviors, not just adjectives
- Include contradictions and complexity
- Think about how each character will grow/change across the story
