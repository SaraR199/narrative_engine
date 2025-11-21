# Narrative Engine: AI-Assisted Book Design Workflow

A creative writing workflow system executed **entirely within Claude Code** using the Task tool to spawn specialized subagents for each stage of book design.

## Overview

This system uses **Claude Code as the orchestrator**, spawning specialized subagents for each creative task. This approach:

- **Minimizes context bloat** - Each subagent only loads the specific files it needs
- **Enables specialization** - Each step has a dedicated agent with a focused prompt
- **Maintains continuity** - Outputs from earlier steps are automatically passed to later ones
- **Supports iteration** - You can re-run individual steps to refine outputs
- **No external tools needed** - Everything runs natively in Claude Code

## Workflow Steps

### Step 1: NPE Extraction

**Input:** An existing book outline from another project
**Output:** `outputs/npe.md` - Your personal Narrative Physics Engine

This step analyzes an existing outline to extract your **generic writing preferences** (not tied to that specific book) and codifies them into a Narrative Physics Engine (NPE). The NPE is a set of rules and constraints that define:

- Plot mechanics & causality rules
- Character logic rules
- Pacing & time mechanics
- Scene architecture
- Dialogue physics
- POV physics
- Information economy
- Stakes & pressure system
- Off-stage narrative design

The NPE will be passed to subsequent workflow steps to ensure consistency.

### Future Steps

More steps will be added to guide you through the complete book design process, each building on the previous outputs.

## Specialized Creative Writing Agents

This workflow uses **specialized agents** designed for creative writing tasks, similar to how Claude Code has specialized agents for code tasks.

Available agents:

- **npe-extractor** - Analyzes narratives to extract patterns and rules (Step 1)
- **story-architect** - Designs high-level plot structure, themes, and act breakdowns
- **character-architect** - Develops psychologically grounded characters with arcs
- **scene-designer** - Crafts beat-by-beat scene outlines with multiple functions

Each agent has:
- Focused expertise in its domain
- Awareness of your NPE constraints
- Ability to produce concrete, actionable outputs
- Context-minimal operation (only loads necessary files)

When you run a workflow step, I (Claude Code) will:
1. Load the agent's system instructions from `.claude/agents/`
2. Combine them with the step's prompt template
3. Spawn a Task with the specialized agent context
4. The agent executes with its specialized knowledge

See `.claude/agents/AGENTS.md` for complete agent documentation.

## Project Structure

```
narrative_engine/
├── .claude/
│   └── agents/               # Specialized creative writing agents
│       ├── AGENTS.md        # Agent documentation
│       ├── npe-extractor.md
│       ├── story-architect.md
│       ├── character-architect.md
│       └── scene-designer.md
├── workflow_config.json      # Step definitions and dependencies
├── README.md                 # This file
├── input/                    # Your input files go here
│   └── existing_outline.md   # Your existing outline for NPE extraction
├── outputs/                  # Generated artifacts
│   └── npe.md               # Your Narrative Physics Engine (after Step 1)
└── prompts/                  # Prompt templates for each step
    └── step1_npe_extraction.md
```

## Getting Started

### Prerequisites

- Claude Code (you're already using it!)
- An existing book outline to analyze

### Setup

1. **Add your existing outline:**

   Replace the placeholder content in `input/existing_outline.md` with your actual book outline.

   Your outline should contain the structure, plot points, character arcs, and any other narrative elements from a book you've worked on. The more complete the outline, the better the NPE extraction will be.

### Running the Workflow

Simply tell Claude Code what you want to do. Claude Code will act as the orchestrator.

#### Step 1: Extract Your NPE

In Claude Code, say:

```
Run step 1
```

or

```
Execute step 1 of the book design workflow
```

**What happens:**
1. Claude Code reads `workflow_config.json` to understand Step 1
2. Loads your outline from `input/existing_outline.md`
3. Loads the prompt template from `prompts/step1_npe_extraction.md`
4. Spawns a subagent using the Task tool with minimal context
5. The subagent analyzes your outline and generates the NPE
6. Saves the result to `outputs/npe.md`

#### Running All Steps

Once all steps are defined, you can run the entire workflow:

```
Run the book design workflow
```

or

```
Run all workflow steps
```

Claude Code will execute all steps sequentially, passing outputs forward.

#### Re-running a Step

To refine an output, just ask:

```
Re-run step 1
```

or

```
Regenerate the NPE
```

## Adding New Workflow Steps

This system is designed to be extensible. To add a new step:

1. **Create a prompt template** in `prompts/`:

   Tell Claude Code:
   ```
   Create a new prompt template for step 2: [describe the step]
   ```

   Or manually create: `prompts/step2_your_step_name.md`

2. **Write your prompt** - Be explicit and focused. The subagent will only see this prompt and the files you specify.

3. **Choose the appropriate specialized agent** - See `.claude/agents/AGENTS.md` for available agents

4. **Add to `workflow_config.json`**:
   ```json
   "2": {
     "name": "Story Design",
     "description": "Design the high-level story structure and themes",
     "prompt_template": "step2_story_design.md",
     "agent_type": "story-architect",
     "model": "sonnet",
     "inputs": {
       "npe": "outputs/npe.md"
     },
     "outputs": {
       "story_structure": "outputs/story_structure.md"
     },
     "depends_on": ["1"]
   }
   ```

4. **Run it**:

   Tell Claude Code:
   ```
   Run step 2
   ```

   Claude Code will automatically load the NPE from step 1 and pass it to the step 2 subagent.

## Configuration

Edit `workflow_config.json` to customize:

- **Model selection**: `sonnet` (default, balanced), `opus` (most capable), or `haiku` (fastest, cheapest)
- **Agent type**: `general-purpose` (default) for most creative tasks
- **Inputs**: Which files each step should load (keeps context minimal)
- **Outputs**: Where results should be saved
- **Dependencies**: Which previous steps must complete first (`depends_on` array)

## Design Philosophy

### Minimal Context Loading

Each subagent only loads:
- Its specific prompt template
- Required input files
- Outputs from dependent steps

This prevents context bloat and keeps each agent focused.

### Positive Constraints

The NPE uses **positive constraints** and **functional prohibitions** rather than negations:

❌ **BAD:** "No deus ex machina"
✅ **GOOD:** "External salvation is structurally impossible; major problems can only be resolved by character action built from prior setup."

This makes the rules actionable for AI agents during outlining and drafting.

### Iterative Refinement

You can re-run any step to refine outputs:
- Update input files
- Modify prompt templates
- Adjust the NPE

Each step is independent and can be iterated on.

## Tips for Success

1. **Use a detailed outline for Step 1** - The more structure in your input outline, the better the NPE extraction
2. **Review and edit the NPE** - The generated NPE is a starting point; refine it to match your vision
3. **Be specific in prompts** - When adding new steps, write clear, explicit instructions
4. **Iterate on outputs** - Don't settle for the first version; re-run steps as needed

## Troubleshooting

**"Required file not found" error**
- Verify that `input/existing_outline.md` exists and contains your outline
- Check file paths in `workflow_config.json` are correct

**Subagent output doesn't match expectations**
- Edit the prompt template in `prompts/` to be more specific
- Try a different model (use `opus` for more sophisticated reasoning)
- Provide more detailed content in input files
- Re-run the step after adjustments

**Need to modify a step's behavior**
- Edit the prompt template in `prompts/`
- Adjust the model in `workflow_config.json`
- Re-run the step: "Re-run step [number]"

## Contributing

This is a personal creative writing tool, but feel free to fork and adapt it for your own workflow!

## License

MIT License - Use freely for your creative projects
