# Narrative Engine: Specialized Creative Writing Agents

This document defines the specialized agents available for creative writing workflows. Each agent is optimized for specific narrative tasks, similar to how Claude Code has specialized agents for code exploration and planning.

## Agent Types

### 1. NPE-Extractor

**Purpose:** Analyzes existing narratives to extract patterns, preferences, and narrative physics rules.

**Specialization:**
- Pattern recognition in story structure
- Identifying implicit constraints and preferences
- Converting narrative patterns into explicit rules
- Extracting generic principles from specific examples

**Best Used For:**
- Analyzing existing outlines to create an NPE
- Reverse-engineering successful story mechanics
- Codifying personal writing style into rules
- Creating constraint systems from examples

**Agent File:** `.claude/agents/npe-extractor.md`

**Model Recommendation:** Sonnet or Opus (requires deep analysis)

---

### 2. Story-Architect

**Purpose:** Designs high-level story structure, themes, plot arcs, and narrative frameworks.

**Specialization:**
- Three-act structure and alternative frameworks
- Theme development and integration
- Plot arc design with cause-effect chains
- Stakes escalation systems
- Genre conventions and expectations

**Best Used For:**
- Designing overall book structure
- Planning major plot beats and turning points
- Developing thematic threads
- Creating story premise and concept
- Mapping act structure

**Agent File:** `.claude/agents/story-architect.md`

**Model Recommendation:** Sonnet (balanced) or Opus (complex narratives)

---

### 3. Character-Architect

**Purpose:** Develops multi-dimensional characters with consistent logic, arcs, and psychological depth.

**Specialization:**
- Character psychology and motivation
- Character arc design (transformation tracking)
- Voice and mannerism differentiation
- Relationship dynamics and conflict
- Internal vs. external character goals

**Best Used For:**
- Creating character profiles and backstories
- Designing character arcs that integrate with plot
- Developing character voice and personality
- Mapping character relationships
- Ensuring character consistency

**Agent File:** `.claude/agents/character-architect.md`

**Model Recommendation:** Sonnet or Opus

---

### 4. World-Builder

**Purpose:** Creates coherent fictional worlds with consistent rules, cultures, and logic systems.

**Specialization:**
- Setting design (physical, social, cultural)
- World rule systems (magic, technology, physics)
- Cultural development and worldview
- Geography and environment
- History and timeline development

**Best Used For:**
- Designing fantasy/sci-fi world systems
- Creating cultural and societal structures
- Establishing world rules and constraints
- Developing setting details
- Ensuring world consistency

**Agent File:** `.claude/agents/world-builder.md`

**Model Recommendation:** Sonnet or Opus (for complex systems)

---

### 5. Scene-Designer

**Purpose:** Crafts individual scenes with proper pacing, tension, and narrative purpose.

**Specialization:**
- Scene structure (entry, purpose, exit)
- Pacing and tension management
- Sensory detail and immersion
- Scene-level cause-effect
- Beat-by-beat scene planning

**Best Used For:**
- Planning scene sequences
- Designing key dramatic moments
- Balancing action and reflection
- Creating scene outlines
- Ensuring each scene serves the story

**Agent File:** `.claude/agents/scene-designer.md`

**Model Recommendation:** Sonnet (default) or Haiku (faster iteration)

---

### 6. Dialogue-Specialist

**Purpose:** Writes character-specific dialogue that reveals character and advances narrative.

**Specialization:**
- Character voice distinction
- Subtext and implicit communication
- Dialogue pacing and rhythm
- Conflict and tension in conversation
- Dialogue as action (not exposition)

**Best Used For:**
- Writing key dialogue exchanges
- Developing character voice samples
- Creating verbal conflict scenes
- Ensuring dialogue serves multiple purposes
- Avoiding on-the-nose exposition

**Agent File:** `.claude/agents/dialogue-specialist.md`

**Model Recommendation:** Sonnet or Opus

---

### 7. Prose-Crafter

**Purpose:** Writes prose with specific style, voice, and literary technique.

**Specialization:**
- Prose style and voice
- Sentence rhythm and variation
- Figurative language and imagery
- Show-don't-tell technique
- Prose pacing (sentence/paragraph level)

**Best Used For:**
- Drafting chapters or sections
- Establishing narrative voice
- Writing opening pages
- Polishing key passages
- Maintaining consistent style

**Agent File:** `.claude/agents/prose-crafter.md`

**Model Recommendation:** Opus (for literary quality) or Sonnet

---

### 8. Consistency-Checker

**Purpose:** Reviews narrative work for continuity, logical consistency, and rule compliance.

**Specialization:**
- Continuity error detection
- Logic and causality verification
- NPE compliance checking
- Character consistency validation
- Timeline and fact-checking

**Best Used For:**
- Reviewing completed chapters/sections
- Checking NPE rule adherence
- Identifying plot holes or logic gaps
- Validating character behavior
- Final consistency pass

**Agent File:** `.claude/agents/consistency-checker.md`

**Model Recommendation:** Sonnet (thorough analysis)

---

## Usage in Workflow

When defining a workflow step in `workflow_config.json`, specify the agent type:

```json
{
  "agent_type": "npe-extractor",
  "model": "sonnet"
}
```

The orchestrator (Claude Code) will:
1. Reference the agent by name from `workflow_config.json` (e.g., "npe-extractor")
2. Load the agent definition from `.claude/agents/[agent-name].md`
3. Spawn a Task referencing the specialized agent
4. The agent executes with its focused expertise and NPE awareness

## Agent Design Principles

All agents follow these principles:

1. **Focused Expertise** - Each agent has a narrow, deep specialization
2. **NPE-Aware** - All agents understand and respect the Narrative Physics Engine
3. **Explicit Output** - Agents produce concrete, actionable artifacts (not just advice)
4. **Context-Minimal** - Agents only load files necessary for their specific task
5. **Iterative** - Agents can be re-run to refine outputs

## Adding New Agents

To create a new specialized agent:

1. Add its definition to this file (AGENTS.md)
2. Create `.claude/agents/[agent-name].md` with the agent's system instructions (use hyphens, not underscores)
3. Include frontmatter with name, description, model, and color
4. Update workflow steps in `workflow_config.json` to reference the new agent type
5. Document when and why to use the new agent
