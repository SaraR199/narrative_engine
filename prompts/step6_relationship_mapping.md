# Step 6: Relationship Mapping

## Objective

Analyze the story concept, character concepts, and developed character profiles to identify and extract the **important relationships** that need architectural definition.

This is a filtering and extraction step—not every character pairing needs a relationship architecture. Focus on relationships that drive plot, character arcs, or thematic exploration.

## Context

You will receive:
- **Story Concept**: The premise, plot overview, and narrative direction
- **Characters Concept**: High-level character landscape and dynamics
- **Character Profiles**: Detailed character development from Step 4
- **NPE (Narrative Physics Engine)**: The author's structural preferences
- **Dramatic Spine**: Tension axes and emotional progression
- **Themes**: The thematic questions the story explores

## Selection Criteria

### Include relationships that:

1. **Drive major plot decisions**
   - The relationship directly causes or prevents key plot events
   - Choices in this relationship change the story trajectory

2. **Create recurring conflict or connection**
   - Characters interact multiple times across the story
   - The relationship evolves or deepens over time
   - There's ongoing tension or intimacy

3. **Evolve significantly across the story**
   - The relationship has a clear arc (deterioration, growth, transformation)
   - Something fundamental shifts between Act I and Act III

4. **Represent thematic tensions**
   - The relationship embodies or tests one of the story's themes
   - Their dynamic illustrates conflicting values or worldviews

5. **Impact main or primary characters**
   - At least one character in the pairing is a protagonist, antagonist, or major supporting character
   - The relationship affects a main character's arc or decision-making

### Exclude relationships that are:

1. **Purely functional**
   - One-dimensional service relationships (shopkeeper, taxi driver, etc.)
   - No emotional stakes or character revelation

2. **Static throughout the story**
   - The relationship doesn't change or evolve
   - Same dynamic in Act I and Act III

3. **Minor or one-scene interactions**
   - Characters only interact briefly
   - No ongoing dynamic to track

4. **Secondary-to-secondary with no main character impact**
   - Both characters are minor supporting cast
   - Their relationship doesn't affect main characters or plot

## Typical Relationship Count

For a novel, expect to identify:
- **3-6 key relationships** for most stories
- **2-4 relationships** for tight, focused narratives
- **6-10 relationships** for ensemble casts or complex multi-POV stories

**Quality over quantity:** Better to deeply architect a few crucial relationships than superficially track many.

## Output Format

For each identified relationship, provide:

```markdown
# RELATIONSHIP: [Character A] & [Character B]

**Situation:**
[2-4 sentences describing their situation in the story, what brings them together, what role each plays in the other's arc]

**Why this relationship matters:**
- [Selection criterion 1: e.g., "Drives the Act II crisis when A must choose between B and their mission"]
- [Selection criterion 2: e.g., "Represents the theme of loyalty vs. ambition"]
- [Impact on character arc: e.g., "B is the mirror that forces A to confront their flaw"]

---
```

### Character Name Format

- Use the exact names from the character profiles
- Format: `[Character A] & [Character B]` (alphabetical order not required)
- Keep names consistent for filename generation

### Situation Description

The situation should establish:
- **Context:** How do they know each other currently?
- **Story function:** What narrative purpose does this relationship serve?
- **Initial dynamic:** What's the baseline tension or connection?
- **Arc potential:** How might this relationship change?

Keep it concise but informative (2-4 sentences).

### Why This Relationship Matters

Explicitly state why this relationship qualifies for architectural treatment. Reference:
- Specific plot events it drives
- Which theme(s) it explores
- Which character arc(s) it affects
- How it evolves across the story

This helps the relationship architect understand the narrative importance.

## Analysis Approach

### Step 1: Identify Main Characters

From the character profiles, determine who the main/primary characters are:
- Protagonist(s)
- Antagonist(s)
- Major supporting characters (mentors, key allies, significant obstacles)

### Step 2: Map Relationships from Concepts

From the story concept and characters concept, note:
- Which characters have explicit relationships mentioned
- What dynamics are described (allies, enemies, mentors, rivals, family, romance, etc.)

### Step 3: Cross-Reference with Character Profiles

Look at each main character's profile and identify:
- Who appears in their backstory or current situation
- Who affects their goals, wounds, or arcs
- Who they're in conflict or alliance with

### Step 4: Apply Selection Criteria

For each potential relationship pairing:
- Does it meet at least 2-3 of the "Include" criteria?
- Does it avoid the "Exclude" criteria?
- Is it important enough to warrant architectural tracking?

### Step 5: Prioritize

If you have more than 10 relationships, prioritize:
- Protagonist relationships first
- Relationships that directly serve themes
- Relationships with the most dramatic arc potential

Aim for the sweet spot of 3-6 relationships for most stories.

## Example Output

```markdown
# RELATIONSHIP: Sarah Chen & Marcus Reed

**Situation:**
Sarah is investigating Marcus's surveillance company, suspecting it of illegal data harvesting. Marcus sees Sarah as a threat to his mission but is also intrigued by her—she's one of the few people who seems to understand the complexity of what he's built, even if she opposes it. They're intellectual opponents circling each other, each convinced they're on the right side.

**Why this relationship matters:**
- Protagonist-antagonist dynamic drives the entire plot
- Represents the theme: "What does safety cost?" (Sarah values privacy, Marcus values security)
- Evolves from distant adversaries → forced alliance at midpoint → climactic confrontation
- Both characters' arcs depend on what they learn from the other

---

# RELATIONSHIP: Sarah Chen & Dr. Elena Vasquez

**Situation:**
Elena was Sarah's mentor at the police force and continues to check in on her, worried about Sarah's increasing cynicism and isolation. Sarah respects Elena deeply but is frustrated by what she sees as Elena's naive optimism about reforming broken systems. Their relationship is strained by mutual disappointment—Elena sees Sarah giving up, Sarah sees Elena enabling corruption through patience.

**Why this relationship matters:**
- Mentor-student relationship that has inverted (student now teaches mentor harsh truths)
- Represents the theme: "Can you change systems from within or must you burn them down?"
- Sarah's decision to reconcile or reject Elena marks her character arc resolution
- Provides emotional grounding and raises the personal stakes of Sarah's choices

---

# RELATIONSHIP: Marcus Reed & Dr. Elena Vasquez

**Situation:**
Elena has been brought in as a consultant to assess the psychological impact of Marcus's surveillance systems. Marcus respects her credentials but dismisses her concerns as academic hand-wringing, while Elena sees Marcus as a tragic figure using technology to avoid processing his grief over his wife's death. They represent two different responses to trauma—control vs. acceptance.

**Why this relationship matters:**
- Provides thematic counterpoint: both experienced trauma, chose opposite paths
- Elena is the only person who can articulate what Marcus is really doing (avoiding grief)
- Their sessions create revelation moments that complicate Marcus for the reader
- B-plot relationship that deepens our understanding of the antagonist
```

## Deliverable

Write the complete relationship mapping following the format above.

**Structure:**
- One `# RELATIONSHIP:` section per relationship
- Each section separated by `---`
- 2-4 sentences for situation
- 2-4 bullet points for "Why this relationship matters"

**Target:** 3-6 relationships for most stories (adjust based on complexity)

**Save to:** `outputs/relationship_mapping.md`

This output will be passed to Step 7 (Relationship Architecture), where parallel agents will build the detailed architecture for each relationship.
