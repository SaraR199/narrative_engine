# Orchestrator Guide for Claude Code

This document explains how Claude Code should execute the book design workflow steps.

## ⚠️ CRITICAL: Placeholder Injection Required

**BEFORE spawning any subagent, you MUST replace ALL `{{PLACEHOLDER}}` tokens in the prompt template with actual file contents.**

**WHY:** Subagents should receive complete, ready-to-use prompts with all content embedded. This prevents:
- Duplicate file reads (orchestrator + subagent reading the same files)
- Context bloat in subagents
- Slower execution
- Confusion about which files to read

**VALIDATION:** Before spawning, verify that the final prompt contains NO `{{` or `}}` tokens.

## Overview

When the user says **"Run step [N]"** or **"Run the book design workflow"**, Claude Code acts as the orchestrator, spawning specialized subagents for each creative task.

## Workflow State Tracking

**CRITICAL:** Each project maintains a `workflow_state.json` file that tracks execution progress. This enables:
- **Cross-chat resumption**: Resume workflow in any new chat session
- **Clear signaling**: Instantly know what step to run next
- **Error recovery**: Track failed steps and retry them
- **Progress visibility**: Show users what's completed and what's pending

### State File Location

```
projects/{project-name}/workflow_state.json
```

### State Management Rules

**The orchestrator MUST:**

1. **Initialize state** when creating a new project or before running the first step
2. **Read state** before determining what to run (check `current_step` field)
3. **Update state** before starting a step (set status to `in_progress`)
4. **Update state** after completing a step (set status to `completed`, update `current_step`)
5. **Update state** on failure (set status to `failed`, capture error message)

### When User Says "Continue the workflow" or "Resume"

1. **Read** `projects/{project-name}/workflow_state.json`
2. **Check** the `current_step` field to see what should run next
3. **Check** if that step is `in_progress` (resume it) or `failed` (retry it)
4. **Execute** the current step, or move to next pending step if current is completed
5. **Update** state after execution

**Example:**
```json
{
  "current_step": "5",
  "steps": {
    "5": {
      "name": "World Constraints Extraction",
      "status": "in_progress",
      "started_at": "2025-11-22T10:30:00Z"
    }
  }
}
```

In this case, resume or retry step 5.

### Initializing Workflow State

When creating a new project or running the first step, initialize the state file:

```json
{
  "workflow_version": "1.0.0",
  "project_name": "my-project",
  "current_step": "1",
  "last_updated": "2025-11-22T21:45:00Z",
  "steps": {
    "1": {"name": "NPE Extraction", "status": "pending"},
    "2": {"name": "Dramatic Spine Extraction", "status": "pending"},
    "3": {"name": "Theme Extraction", "status": "pending"},
    "4": {"name": "Character Development", "status": "pending"},
    "5": {"name": "World Constraints Extraction", "status": "pending"},
    "6": {"name": "Relationship Mapping", "status": "pending"},
    "7": {"name": "Relationship Architecture", "status": "pending"},
    "8": {"name": "Premise Refinement", "status": "pending"},
    "9": {"name": "Story Outline", "status": "pending"},
    "10": {"name": "NPE Inspection", "status": "pending"},
    "11": {"name": "Outline Rewrite", "status": "pending"}
  }
}
```

**Note:** Use step names from `workflow_config.json` to populate the state file.

### Updating State: Before Starting a Step

Before spawning subagents for step N:

```json
{
  "current_step": "N",
  "last_updated": "2025-11-22T21:45:00Z",
  "steps": {
    "N": {
      "name": "Step Name",
      "status": "in_progress",
      "started_at": "2025-11-22T21:45:00Z"
    }
  }
}
```

### Updating State: After Completing a Step

After subagent completes successfully and outputs are saved:

```json
{
  "current_step": "N+1",
  "last_updated": "2025-11-22T21:50:00Z",
  "steps": {
    "N": {
      "name": "Step Name",
      "status": "completed",
      "started_at": "2025-11-22T21:45:00Z",
      "completed_at": "2025-11-22T21:50:00Z",
      "outputs_generated": ["outputs/file.md"]
    },
    "N+1": {
      "name": "Next Step Name",
      "status": "pending"
    }
  }
}
```

**Special case:** If step N is the last step (step 11), set `current_step` to `null` to signal workflow completion.

### Updating State: On Failure

If a step fails (missing dependency, agent error, etc.):

```json
{
  "current_step": "N",
  "last_updated": "2025-11-22T21:47:00Z",
  "steps": {
    "N": {
      "name": "Step Name",
      "status": "failed",
      "started_at": "2025-11-22T21:45:00Z",
      "failed_at": "2025-11-22T21:47:00Z",
      "error": "Missing required input file: input/story-concept.md"
    }
  }
}
```

**Recovery:** When user fixes the issue and says "retry" or "continue", re-run step N and update status back to `in_progress`, then `completed` on success.

### State-Driven Workflow Execution Example

**User says:** "Continue the workflow for dragon-mafia"

**Orchestrator actions:**

1. **Read state:**
   ```python
   state = read('projects/dragon-mafia/workflow_state.json')
   current_step = state['current_step']  # "3"
   step_status = state['steps']['3']['status']  # "pending"
   ```

2. **Determine action:**
   - If status is "pending": Start step 3
   - If status is "in_progress": Resume or retry step 3
   - If status is "completed": Move to step 4
   - If status is "failed": Retry step 3 or ask user to fix error

3. **Update state before execution:**
   ```python
   state['steps']['3']['status'] = 'in_progress'
   state['steps']['3']['started_at'] = current_timestamp()
   state['last_updated'] = current_timestamp()
   write('projects/dragon-mafia/workflow_state.json', state)
   ```

4. **Execute step** (spawn subagent, save outputs)

5. **Update state after success:**
   ```python
   state['steps']['3']['status'] = 'completed'
   state['steps']['3']['completed_at'] = current_timestamp()
   state['steps']['3']['outputs_generated'] = ['outputs/themes.md']
   state['current_step'] = '4'
   state['last_updated'] = current_timestamp()
   write('projects/dragon-mafia/workflow_state.json', state)
   ```

6. **Inform user:**
   ```
   "Step 3 (Theme Extraction) completed successfully.
   Output saved to: outputs/themes.md

   Current workflow status: 3/11 steps completed
   Next step: 4 (Character Development)"
   ```

### Benefits of State Tracking

✅ **Resume anywhere**: Start in one chat, continue in another
✅ **Clear signals**: No guessing what to run next
✅ **Error recovery**: Know exactly what failed and why
✅ **Progress tracking**: Show users how far along they are
✅ **Idempotency**: Safe to re-run "continue" command multiple times

## Parallelization Quick Reference

The workflow supports both **parallel step execution** and **internal parallelization** for efficiency:

| Type | Steps/Features | Description | Time Savings |
|------|---------------|-------------|--------------|
| **Parallel Steps** | Steps 5 & 6 | Both depend only on 1-4, can run simultaneously | 1 step equivalent |
| **Internal Parallel** | Step 4 | Spawns multiple character-architect agents (one per character) | 3x faster for 3 characters |
| **Internal Parallel** | Step 7 | Spawns multiple character-architect agents (one per relationship) | 3x faster for 3 relationships |

### Execution Order Summary

**Sequential (No Parallelization):**
```
1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10 → 11
```

**Optimized (With Parallelization):**
```
1 → 2 → 3 → 4 → [5 & 6 in parallel] → 7 → 8 → 9 → 10 → 11
       ↓                    ↓
   (parallel          (parallel
   characters)        relationships)
```

### When to Use Parallel Execution

**Use parallel step execution (Steps 5-6) when:**
- Running the full workflow
- User requests optimization or faster execution
- Both steps are needed and their dependencies are met

**Use internal parallelization (Steps 4, 7) when:**
- Multiple entities exist in the input files
- Always recommended (no downside)

See detailed instructions for each parallelization type below.

---

## Orchestration Process

### Step-by-Step Execution

#### 0. Read or Initialize Workflow State (NEW - CRITICAL)

Before executing any step, check if `projects/{project-name}/workflow_state.json` exists:

**If it exists:**
- Read the state file
- Check `current_step` to see what should run next
- Verify the requested step aligns with workflow state
- If user says "continue", use `current_step` to determine what to run

**If it doesn't exist:**
- Initialize a new state file with all steps set to "pending"
- Set `current_step` to "1"
- Set `workflow_version` from workflow_config.json
- See "Initializing Workflow State" section above for the template

#### 1. Read the Workflow Configuration

Load and parse `workflow_config.json` to get the step definition:

```json
{
  "name": "Step Name",
  "description": "What this step does",
  "prompt_template": "step_prompt.md",
  "agent_type": "agent-name",
  "model": "sonnet",
  "inputs": {
    "PLACEHOLDER_NAME": "path/to/input/file.md"
  },
  "outputs": {
    "output_key": "path/to/output/file.md"
  },
  "depends_on": ["previous_step_ids"]
}
```

#### 2. Check Dependencies

- Verify all steps in `depends_on` have completed
- Check that all required output files from previous steps exist
- If dependencies are missing, inform the user and stop

#### 3. Load Input Files

For each entry in `inputs`:
- Read the file from the specified path
- Store the content with its placeholder name
- If a file doesn't exist, inform the user and stop

Example:
```
inputs: {
  "NPE": "outputs/npe.md",
  "CHARACTER_CONCEPT": "input/character-concept.md"
}
```
Load both files into memory.

#### 4. Load the Prompt Template

- Read the file from `prompts/[prompt_template]`
- This is the base prompt for the step

#### 5. Inject Inputs into Prompt Template ⚠️ CRITICAL STEP

**This step is MANDATORY. Do NOT skip this step.**

Replace ALL `{{PLACEHOLDER_NAME}}` tokens in the prompt template with the actual loaded file contents:

**Before injection:**
```markdown
Here is the NPE: {{NPE}}

Here is the story concept: {{STORY_CONCEPT}}
```

**After injection:**
```markdown
Here is the NPE: # Narrative Physics Engine v1.0

## 1. Plot Mechanics & Causality
[... full 5000+ character contents of outputs/npe.md ...]

Here is the story concept: # Story Concept: The Dragon Mafia

In a world where dragons run organized crime...
[... full contents of input/story-concept.md ...]
```

**Implementation:**
```python
# Load all input files first
inputs_data = {}
for placeholder_name, file_path in step_config['inputs'].items():
    inputs_data[placeholder_name] = read_file(file_path)

# Load prompt template
prompt_template = read_file(f"prompts/{step_config['prompt_template']}")

# INJECT: Replace all placeholders
final_prompt = prompt_template
for placeholder_name, file_content in inputs_data.items():
    placeholder_token = f"{{{{{placeholder_name}}}}}"  # e.g., "{{NPE}}"
    final_prompt = final_prompt.replace(placeholder_token, file_content)

# VALIDATE: Ensure no placeholders remain
if "{{" in final_prompt or "}}" in final_prompt:
    raise Error("Placeholder injection failed! Remaining tokens found in prompt.")

# Now spawn subagent with fully-injected prompt
```

**Common Placeholders:**
- `{{NPE}}` → Full contents of `outputs/npe.md`
- `{{STORY_CONCEPT}}` → Full contents of `input/story-concept.md`
- `{{CHARACTERS_CONCEPT}}` → Full contents of `input/characters-concept.md`
- `{{WORLD_CONCEPT}}` → Full contents of `input/world-concept.md`
- `{{DRAMATIC_SPINE}}` → Full contents of `outputs/dramatic_spine.md`
- `{{THEMES}}` → Full contents of `outputs/themes.md`
- `{{CHARACTER_PROFILES}}` → All `outputs/character_*.md` files concatenated
- `{{OUTLINE_CONTENT}}` → Full contents of `input/existing_outline.md`
- `{{NPE_TEMPLATE}}` → Full contents of `templates/npe_template`
- `{{MAIN_CHARACTER_TEMPLATE}}` → Full contents of `templates/main_character_template_v1.1.md`
- `{{SECONDARY_CHARACTER_TEMPLATE}}` → Full contents of `templates/secondary_character_template_v1.0.md`

#### 6. Build the Complete Agent Prompt

The final prompt sent to the subagent consists of:

**The agent is already loaded via the agent_type field** - Claude Code's Task tool will automatically load the agent definition from `.claude/agents/[agent_type].md` when you specify the subagent_type parameter.

You just need to pass the **fully-injected prompt** (from step 5) as the task prompt.

**IMPORTANT:** The prompt parameter must contain:
- ✅ The fully-injected prompt with all file contents embedded
- ❌ NOT the raw template with `{{PLACEHOLDERS}}` still in it

#### 7. Update State: Mark Step as In Progress

Before spawning the subagent, update the workflow state:

```python
# Read current state
state = read('projects/{project-name}/workflow_state.json')

# Update the current step status
state['steps'][current_step_number]['status'] = 'in_progress'
state['steps'][current_step_number]['started_at'] = current_timestamp_iso8601()
state['last_updated'] = current_timestamp_iso8601()

# Write updated state
write('projects/{project-name}/workflow_state.json', state)
```

#### 8. Spawn the Subagent

Use the Task tool to spawn the specialized agent with the **fully-injected prompt**:

```
Task tool parameters:
- subagent_type: [agent_type from config]
- prompt: [final_prompt from step 5 - all placeholders replaced]
- description: [brief description of what this step does]
- model: [model from config, or default to sonnet]
```

**Correct Example:**
```python
# After placeholder injection in step 5
final_prompt = """# Task: Extract High-Level Dramatic Spine

You are analyzing three foundational documents...

## Input Documents

### Story Concept
# Story Concept: The Dragon Mafia

In a world where dragons run organized crime...
[... full 2000+ characters ...]

### Characters Concept
# Main Characters

Sarah Chen: A human detective who...
[... full 1500+ characters ...]

### World Concept
# World: Neo-Tokyo 2145

The city is divided into...
[... full 3000+ characters ...]

### Narrative Physics Engine
# Narrative Physics Engine v1.0

## 1. Plot Mechanics
[... full 5000+ characters ...]

## Your Task
Analyze the three concept documents..."""

# Now spawn with the COMPLETE prompt
Task(
  subagent_type="story-architect",
  prompt=final_prompt,  # ✅ All content embedded, NO placeholders
  description="Extract dramatic spine",
  model="sonnet"
)
```

**Incorrect Example (DO NOT DO THIS):**
```python
# ❌ WRONG - Sending template with placeholders
Task(
  subagent_type="story-architect",
  prompt="""# Task: Extract Dramatic Spine

  {{STORY_CONCEPT}}
  {{CHARACTERS_CONCEPT}}
  {{WORLD_CONCEPT}}
  {{NPE}}""",  # ❌ Placeholders not replaced!
  description="Extract dramatic spine",
  model="sonnet"
)
# This will cause the subagent to read files again!
```

#### 9. Save the Output

When the subagent completes:
- Take the agent's output
- Save it to the path specified in `outputs`

Example:
```
outputs: {
  "character_profile": "outputs/character_profile.md"
}
```
Save the agent's response to `outputs/character_profile.md`

#### 10. Update State: Mark Step as Completed

After successfully saving outputs, update the workflow state:

```python
# Read current state
state = read('projects/{project-name}/workflow_state.json')

# Mark current step as completed
state['steps'][current_step_number]['status'] = 'completed'
state['steps'][current_step_number]['completed_at'] = current_timestamp_iso8601()
state['steps'][current_step_number]['outputs_generated'] = ['outputs/file.md']  # List all output files

# Advance to next step (or null if this was the last step)
next_step = str(int(current_step_number) + 1) if int(current_step_number) < 11 else null
state['current_step'] = next_step
state['last_updated'] = current_timestamp_iso8601()

# Write updated state
write('projects/{project-name}/workflow_state.json', state)
```

#### 11. Confirm to User

Tell the user:
- What step completed
- Where outputs were saved
- Current progress (X/11 steps completed)
- What the next step is (if not finished)

## Example: Running Step 2 (Dramatic Spine Extraction)

User says: **"Run step 2"**

### Orchestrator Actions:

0. **Check/Initialize state**: Read or create `projects/{project-name}/workflow_state.json`
   - Verify step 1 is completed (status: "completed")
   - Confirm step 2 can run (dependencies satisfied)

1. **Load config**: Read `workflow_config.json`, get step "2"
   ```json
   {
     "name": "Dramatic Spine Extraction",
     "agent_type": "story-architect",
     "prompt_template": "step2_dramatic_spine.md",
     "model": "sonnet",
     "inputs": {
       "STORY_CONCEPT": "input/story-concept.md",
       "CHARACTERS_CONCEPT": "input/characters-concept.md",
       "WORLD_CONCEPT": "input/world-concept.md",
       "NPE": "outputs/npe.md"
     },
     "outputs": {
       "dramatic_spine": "outputs/dramatic_spine.md"
     },
     "depends_on": ["1"]
   }
   ```

2. **Check dependencies**: Verify Step 1 completed by checking `outputs/npe.md` exists

3. **Load inputs**:
   ```python
   story_concept = read('input/story-concept.md')        # 2000 chars
   characters_concept = read('input/characters-concept.md')  # 1500 chars
   world_concept = read('input/world-concept.md')        # 3000 chars
   npe = read('outputs/npe.md')                          # 5000 chars
   ```

4. **Load prompt template**: Read `prompts/step2_dramatic_spine.md`
   ```python
   prompt_template = read('prompts/step2_dramatic_spine.md')  # 7654 chars with {{PLACEHOLDERS}}
   ```

5. **⚠️ INJECT INPUTS (CRITICAL STEP)**:
   ```python
   # Start with the template
   final_prompt = prompt_template  # Contains {{PLACEHOLDERS}}

   # Replace ALL placeholders with actual content
   final_prompt = final_prompt.replace('{{STORY_CONCEPT}}', story_concept)
   final_prompt = final_prompt.replace('{{CHARACTERS_CONCEPT}}', characters_concept)
   final_prompt = final_prompt.replace('{{WORLD_CONCEPT}}', world_concept)
   final_prompt = final_prompt.replace('{{NPE}}', npe)

   # VALIDATE: No placeholders remain
   if '{{' in final_prompt or '}}' in final_prompt:
       raise Error("Placeholder injection incomplete!")

   # final_prompt is now ~19,000 chars (7654 + 2000 + 1500 + 3000 + 5000)
   ```

6. **Update state - mark as in_progress**:
   ```python
   state = read('projects/{project-name}/workflow_state.json')
   state['steps']['2']['status'] = 'in_progress'
   state['steps']['2']['started_at'] = '2025-11-22T21:45:00Z'
   state['last_updated'] = '2025-11-22T21:45:00Z'
   write('projects/{project-name}/workflow_state.json', state)
   ```

7. **Spawn subagent with fully-injected prompt**:
   ```python
   Task(
     subagent_type="story-architect",
     prompt=final_prompt,  # ✅ ALL content embedded, NO {{PLACEHOLDERS}}
     description="Extract dramatic spine from concepts",
     model="sonnet"
   )
   ```

   **The subagent receives a complete prompt with all file contents already embedded. It does NOT need to read any files.**

8. **Save output**: When agent completes, save response to `outputs/dramatic_spine.md`

9. **Update state - mark as completed**:
   ```python
   state = read('projects/{project-name}/workflow_state.json')
   state['steps']['2']['status'] = 'completed'
   state['steps']['2']['completed_at'] = '2025-11-22T21:50:00Z'
   state['steps']['2']['outputs_generated'] = ['outputs/dramatic_spine.md']
   state['current_step'] = '3'  # Advance to next step
   state['last_updated'] = '2025-11-22T21:50:00Z'
   write('projects/{project-name}/workflow_state.json', state)
   ```

10. **Confirm**: Tell user:
    ```
    "Step 2 (Dramatic Spine Extraction) completed successfully.
    Output saved to: outputs/dramatic_spine.md

    Current workflow status: 2/11 steps completed
    Next step: 3 (Theme Extraction)"
    ```

## Parallel Execution Strategies

The workflow has two types of parallelization opportunities:

1. **Parallel Step Execution**: Multiple workflow steps run simultaneously (Steps 5-6)
2. **Internal Parallelization**: A single step spawns multiple agents for multiple entities (Steps 4, 7)

---

## Parallel Step Execution: Steps 5 and 6

Steps 5 (World Constraints Extraction) and 6 (Relationship Mapping) can run **in parallel** because they both depend only on Steps 1-4 and don't depend on each other.

### When to Use Parallel Step Execution

**Run Steps 5-6 in parallel when:**
- User says "Run steps 5 and 6" or "Continue the workflow from step 5"
- User explicitly requests parallel execution
- You're running the full workflow and want to optimize execution time

### How to Execute Steps 5-6 in Parallel

#### 1. Verify Dependencies

Both steps require:
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)
- `outputs/character_*.md` (from Step 4)

Check that all these files exist before proceeding.

#### 2. Load Shared Inputs

Load inputs that both steps need:
```
NPE = read('outputs/npe.md')
DRAMATIC_SPINE = read('outputs/dramatic_spine.md')
THEMES = read('outputs/themes.md')
CHARACTER_PROFILES = read_all('outputs/character_*.md')
```

#### 3. Load Step-Specific Inputs

**Step 5 needs:**
- `input/world-concept.md`

**Step 6 needs:**
- `input/story-concept.md`
- `input/characters-concept.md`

#### 4. Prepare Both Prompts with Placeholder Injection

**⚠️ CRITICAL: Inject placeholders for BOTH steps before spawning**

```python
# Load prompt templates
step5_template = read('prompts/step5_world_constraints.md')
step6_template = read('prompts/step6_relationship_mapping.md')

# Step 5: Inject placeholders
step5_prompt = step5_template
step5_prompt = step5_prompt.replace('{{WORLD_CONCEPT}}', world_concept)
step5_prompt = step5_prompt.replace('{{NPE}}', npe)
step5_prompt = step5_prompt.replace('{{DRAMATIC_SPINE}}', dramatic_spine)
step5_prompt = step5_prompt.replace('{{THEMES}}', themes)
step5_prompt = step5_prompt.replace('{{CHARACTER_PROFILES}}', all_character_files)

# Step 6: Inject placeholders
step6_prompt = step6_template
step6_prompt = step6_prompt.replace('{{STORY_CONCEPT}}', story_concept)
step6_prompt = step6_prompt.replace('{{CHARACTERS_CONCEPT}}', characters_concept)
step6_prompt = step6_prompt.replace('{{CHARACTER_PROFILES}}', all_character_files)
step6_prompt = step6_prompt.replace('{{NPE}}', npe)
step6_prompt = step6_prompt.replace('{{DRAMATIC_SPINE}}', dramatic_spine)
step6_prompt = step6_prompt.replace('{{THEMES}}', themes)

# VALIDATE both prompts
assert '{{' not in step5_prompt and '}}' not in step5_prompt
assert '{{' not in step6_prompt and '}}' not in step6_prompt
```

#### 5. Spawn Both Agents in a Single Message

**Critical:** Send both Task tool calls in **one message** to run them in parallel:

```python
# Message with TWO Task tool calls - BOTH with fully injected prompts
Task(
    subagent_type="story-architect",
    prompt=step5_prompt,  # ✅ Fully injected, NO placeholders
    description="Extract world constraints",
    model="sonnet"
)

Task(
    subagent_type="character-architect",
    prompt=step6_prompt,  # ✅ Fully injected, NO placeholders
    description="Map key relationships",
    model="sonnet"
)
```

#### 6. Wait for Both to Complete

Both agents will run simultaneously. Wait for both to finish before proceeding.

#### 7. Save Both Outputs

```
Step 5 output → outputs/world_constraints.md
Step 6 output → outputs/relationship_mapping.md
```

#### 8. Confirm Completion

```
"Steps 5 and 6 completed in parallel:
- World constraints saved to outputs/world_constraints.md
- Relationship mapping saved to outputs/relationship_mapping.md

Ready to proceed to Step 7."
```

### Why This Works

- **No data dependency**: Step 5 doesn't need Step 6's output and vice versa
- **Different agents**: Step 5 uses story-architect, Step 6 uses character-architect
- **Time savings**: Runs in parallel instead of sequential (saves 1 step equivalent of time)

---

## Special Case: Multiple Characters (Step 4)

Step 4 is special because `input/characters-concept.md` can contain **multiple characters** of different types, and each character should get its own parallel subagent.

### Character File Format

The characters-concept file uses markers to distinguish main characters from secondary characters:

```markdown
# MAIN CHARACTER: Sarah Chen
[detailed concept for Sarah - protagonist]

---

# MAIN CHARACTER: Marcus Reed
[detailed concept for Marcus - romantic lead]

---

# SECONDARY CHARACTER: Dr. Elena Vasquez
[lighter concept for Elena - mentor]

---

# SECONDARY CHARACTER: Detective Morrison
[lighter concept for Morrison - antagonist]

---
```

**Important:**
- Characters marked with `# MAIN CHARACTER:` use the comprehensive Main Character Template (8 sections)
- Characters marked with `# SECONDARY CHARACTER:` use the streamlined Secondary Character Template (6 sections)
- The prompt template includes BOTH templates and instructs the subagent to use the appropriate one
- The orchestrator doesn't need to parse character type - just split by character and inject both templates

### Parallel Processing

When executing Step 4:

#### 1. Parse Character File

Read `input/characters-concept.md` and split it into individual characters:

```python
# Pseudocode
characters = []
# Split on both MAIN CHARACTER and SECONDARY CHARACTER markers
sections = character_file.split('# MAIN CHARACTER:') + character_file.split('# SECONDARY CHARACTER:')

# Alternative: Use regex to split on either marker
import re
sections = re.split(r'# (?:MAIN|SECONDARY) CHARACTER:', character_file)

for section in sections[1:]:  # Skip first empty section
    lines = section.strip().split('\n')
    name = lines[0].strip()  # First line is the name
    concept = '\n'.join(lines[1:]).split('---')[0].strip()  # Content until ---

    # Determine character type from original marker (for filename purposes)
    # But the subagent will auto-detect from the concept content
    characters.append({'name': name, 'concept': section.strip()})
```

Example result:
```python
[
  {'name': 'Sarah Chen', 'concept': 'Sarah Chen\n[Role:]...[detailed concept]'},
  {'name': 'Marcus Reed', 'concept': 'Marcus Reed\n[Role:]...[detailed concept]'},
  {'name': 'Dr. Elena Vasquez', 'concept': 'Dr. Elena Vasquez\n[Role:]...[lighter concept]'}
]
```

**Note:** The orchestrator doesn't need to determine character type - just extract each character's full concept block. The subagent prompt includes both templates and will select the appropriate one based on the `# MAIN CHARACTER:` or `# SECONDARY CHARACTER:` marker in the concept.

#### 2. Load Shared Inputs

Load inputs that ALL characters will need:
```python
# Load BOTH templates - the prompt includes both and the subagent selects the right one
main_template_content = read('templates/main_character_template_v1.1.md')
secondary_template_content = read('templates/secondary_character_template_v1.0.md')

# Load shared workflow outputs
npe_content = read('outputs/npe.md')
dramatic_spine = read('outputs/dramatic_spine.md')
themes = read('outputs/themes.md')
```

#### 3. Spawn Parallel Subagents with Placeholder Injection

For each character, **inject placeholders** (including BOTH templates) then spawn a separate character-architect agent **in parallel**:

```python
# Prepare ALL prompts with placeholder injection BEFORE spawning
character_prompts = []

for character in characters:
    # Load prompt template
    prompt_template = read('prompts/step4_character_development.md')

    # ⚠️ INJECT PLACEHOLDERS for this character
    char_prompt = prompt_template
    char_prompt = char_prompt.replace('{{CHARACTER_CONCEPT}}', character['concept'])

    # Inject BOTH templates - the subagent will select the appropriate one
    char_prompt = char_prompt.replace('{{MAIN_CHARACTER_TEMPLATE}}', main_template_content)
    char_prompt = char_prompt.replace('{{SECONDARY_CHARACTER_TEMPLATE}}', secondary_template_content)

    # Inject shared workflow outputs
    char_prompt = char_prompt.replace('{{NPE}}', npe_content)
    char_prompt = char_prompt.replace('{{DRAMATIC_SPINE}}', dramatic_spine)
    char_prompt = char_prompt.replace('{{THEMES}}', themes)

    # VALIDATE: No placeholders remain
    assert '{{' not in char_prompt and '}}' not in char_prompt

    character_prompts.append({
        'name': character['name'],
        'prompt': char_prompt  # Fully injected
    })

# Now spawn ALL characters in a SINGLE message (parallel execution)
for char_data in character_prompts:
    Task(
        subagent_type="character-architect",
        prompt=char_data['prompt'],  # ✅ Fully injected, NO placeholders
        description=f"Develop character profile for {char_data['name']}",
        model="sonnet"
    )
```

**Critical:**
1. **Inject ALL placeholders** before spawning any agents
2. **Validate** each prompt has no remaining `{{PLACEHOLDERS}}`
3. Send all Task tool calls in a **single message** to run them in parallel
4. Don't wait for one to complete before spawning the next

#### 4. Save Multiple Outputs

When agents complete, save each character to a separate file:

```
outputs/character_Sarah_Chen.md
outputs/character_Marcus_Reed.md
outputs/character_Dr_Elena_Vasquez.md
```

Naming pattern: `outputs/character_{Name_With_Underscores}.md`

#### 4. Confirm Completion

```
"Step 2 completed. Generated 3 character profiles:
- outputs/character_Sarah_Chen.md
- outputs/character_Marcus_Reed.md
- outputs/character_Dr_Elena_Vasquez.md"
```

### Why Parallel Processing?

- **Efficiency**: All characters develop simultaneously
- **Consistency**: All use the same NPE and template
- **Speed**: 3 characters in parallel is 3x faster than sequential
- **Independence**: Character profiles don't depend on each other

### Implementation Notes

1. Parse the character file carefully - look for `# CHARACTER:` markers
2. Extract character names for output filenames
3. Use Claude Code's ability to send multiple Tool calls in one message
4. Wait for all agents to complete before confirming to user
5. Handle errors per character (one character failing shouldn't block others)

---

## Special Case: Multiple Relationships (Step 7)

Step 7 is special because `outputs/relationship_mapping.md` can contain **multiple relationships**, and each relationship should get its own parallel subagent.

### Relationship Mapping File Format

The relationship mapping file (from Step 6) uses this structure:

```markdown
# RELATIONSHIP: Sarah Chen & Marcus Reed

**Situation:**
[Description of the relationship situation]

**Why this relationship matters:**
- [Reason 1]
- [Reason 2]

---

# RELATIONSHIP: Sarah Chen & Dr. Elena Vasquez

**Situation:**
[Description]

**Why this relationship matters:**
- [Reason 1]
- [Reason 2]

---

# RELATIONSHIP: Marcus Reed & Dr. Elena Vasquez

**Situation:**
[Description]

**Why this relationship matters:**
- [Reason 1]
- [Reason 2]

---
```

### Parallel Processing for Step 7

When executing Step 7:

#### 1. Parse Relationship Mapping File

Read `outputs/relationship_mapping.md` and split it into individual relationships:

```python
# Pseudocode
relationships = []
sections = relationship_file.split('# RELATIONSHIP:')
for section in sections[1:]:  # Skip first empty section
    lines = section.strip().split('\n')
    header = lines[0].strip()  # "Character A & Character B"

    # Extract character names
    parts = header.split('&')
    char_a = parts[0].strip()
    char_b = parts[1].strip()

    # Extract full relationship content (until next --- separator)
    content = '\n'.join(lines).split('---')[0].strip()

    relationships.append({
        'char_a': char_a,
        'char_b': char_b,
        'content': content
    })
```

Example result:
```python
[
  {'char_a': 'Sarah Chen', 'char_b': 'Marcus Reed', 'content': '# RELATIONSHIP: Sarah Chen & Marcus Reed\n\n**Situation:**...'},
  {'char_a': 'Sarah Chen', 'char_b': 'Dr. Elena Vasquez', 'content': '# RELATIONSHIP: Sarah Chen & Dr. Elena Vasquez\n\n**Situation:**...'},
  {'char_a': 'Marcus Reed', 'char_b': 'Dr. Elena Vasquez', 'content': '# RELATIONSHIP: Marcus Reed & Dr. Elena Vasquez\n\n**Situation:**...'}
]
```

#### 2. Load Character Profiles and Shared Inputs

For each relationship, you'll need both character profiles plus shared inputs:

```python
# Load shared inputs (used by all relationships)
npe_content = read('outputs/npe.md')
dramatic_spine_content = read('outputs/dramatic_spine.md')
themes_content = read('outputs/themes.md')
world_constraints_content = read('outputs/world_constraints.md')

# Load all character profiles into a dictionary
char_profiles = {}
for relationship in relationships:
    if relationship['char_a'] not in char_profiles:
        char_profiles[relationship['char_a']] = read(f"outputs/character_{clean_name(relationship['char_a'])}.md")
    if relationship['char_b'] not in char_profiles:
        char_profiles[relationship['char_b']] = read(f"outputs/character_{clean_name(relationship['char_b'])}.md")
```

Note: Character filenames use underscores for spaces (e.g., `character_Sarah_Chen.md`)

#### 3. Spawn Parallel Subagents with Placeholder Injection

For each relationship, **inject placeholders** then spawn a separate character-architect agent **in parallel**:

```python
# Prepare ALL prompts with placeholder injection BEFORE spawning
relationship_prompts = []

for relationship in relationships:
    # Load template
    prompt_template = read('prompts/step7_relationship_architecture.md')

    # ⚠️ INJECT PLACEHOLDERS for this relationship
    rel_prompt = prompt_template
    rel_prompt = rel_prompt.replace('{{RELATIONSHIP_MAPPING}}', relationship['content'])
    rel_prompt = rel_prompt.replace('{{CHARACTER_A_PROFILE}}', char_profiles[relationship['char_a']])
    rel_prompt = rel_prompt.replace('{{CHARACTER_B_PROFILE}}', char_profiles[relationship['char_b']])
    rel_prompt = rel_prompt.replace('{{NPE}}', npe_content)
    rel_prompt = rel_prompt.replace('{{DRAMATIC_SPINE}}', dramatic_spine_content)
    rel_prompt = rel_prompt.replace('{{THEMES}}', themes_content)
    rel_prompt = rel_prompt.replace('{{WORLD_CONSTRAINTS}}', world_constraints_content)

    # VALIDATE: No placeholders remain
    assert '{{' not in rel_prompt and '}}' not in rel_prompt

    relationship_prompts.append({
        'char_a': relationship['char_a'],
        'char_b': relationship['char_b'],
        'prompt': rel_prompt  # Fully injected
    })

# Now spawn ALL relationships in a SINGLE message (parallel execution)
for rel_data in relationship_prompts:
    Task(
        subagent_type="character-architect",
        prompt=rel_data['prompt'],  # ✅ Fully injected, NO placeholders
        description=f"Architect relationship: {rel_data['char_a']} & {rel_data['char_b']}",
        model="sonnet"
    )
```

**Critical:**
1. **Inject ALL placeholders** before spawning any agents
2. **Validate** each prompt has no remaining `{{PLACEHOLDERS}}`
3. Send all Task tool calls in a **single message** to run them in parallel
4. Don't wait for one to complete before spawning the next

#### 4. Save Multiple Outputs

When agents complete, save each relationship architecture to a separate file:

```
outputs/relationship_Sarah_Chen_Marcus_Reed.md
outputs/relationship_Sarah_Chen_Dr_Elena_Vasquez.md
outputs/relationship_Marcus_Reed_Dr_Elena_Vasquez.md
```

Naming pattern: `outputs/relationship_{CharA}_{CharB}.md` (with spaces converted to underscores)

#### 5. Confirm Completion

```
"Step 7 completed. Generated 3 relationship architectures:
- outputs/relationship_Sarah_Chen_Marcus_Reed.md
- outputs/relationship_Sarah_Chen_Dr_Elena_Vasquez.md
- outputs/relationship_Marcus_Reed_Dr_Elena_Vasquez.md"
```

### Why Parallel Processing?

- **Efficiency**: All relationship architectures develop simultaneously
- **Consistency**: All use the same NPE, themes, world constraints
- **Speed**: 3 relationships in parallel is 3x faster than sequential
- **Independence**: Relationship architectures don't depend on each other

### Implementation Notes

1. Parse the relationship mapping file carefully - look for `# RELATIONSHIP:` markers
2. Extract both character names from the header (format: "Character A & Character B")
3. Match character names to their profile filenames (replace spaces with underscores)
4. Use Claude Code's ability to send multiple Tool calls in one message
5. Wait for all agents to complete before confirming to user
6. Handle errors per relationship (one relationship failing shouldn't block others)

## Running All Steps

User says: **"Run the book design workflow"** or **"Run all steps"**

Execute steps sequentially in numerical order (1, 2, 3, ...):
- Run step 1
- Wait for completion
- Run step 2
- Wait for completion
- Continue until all steps complete

## Error Handling

### Missing Dependencies
```
"Step 2 requires Step 1 to complete first.
The file outputs/npe.md was not found.
Please run Step 1 first."
```

### Missing Input Files
```
"Cannot run Step 2: Required input file 'input/character-concept.md' not found.
Please create this file with your character concept."
```

### Agent Errors
```
"The character-architect agent encountered an error: [error details]
You may want to review the inputs and try again."
```

## Key Principles

1. **Placeholder Injection is MANDATORY**: Always replace `{{PLACEHOLDERS}}` before spawning subagents
2. **Minimal Context**: Only load files specified in `inputs` - don't load the entire codebase
3. **Sequential Dependencies**: Respect `depends_on` - never skip required steps
4. **Clear Communication**: Tell the user what you're doing at each stage
5. **Error Recovery**: Provide helpful error messages with clear next actions
6. **Agent Trust**: Trust the specialized agents' outputs - they're designed for their tasks

## Troubleshooting

### Problem: Subagent is reading input files again

**Symptom:** You notice the orchestrator reads files, then the subagent ALSO reads the same files.

**Root Cause:** Placeholder injection was skipped. The subagent received a prompt with `{{PLACEHOLDERS}}` still in it.

**Solution:**
1. **Verify step 5 was executed** - Check that you performed placeholder replacement
2. **Validate the final prompt** - Before spawning, check: `if "{{" in final_prompt: raise Error()`
3. **Check the Task call** - Ensure you're passing `final_prompt`, not `prompt_template`

**Example of the bug:**
```python
# ❌ BUG: Skipping placeholder injection
prompt_template = read('prompts/step2_dramatic_spine.md')
Task(
  subagent_type="story-architect",
  prompt=prompt_template,  # ❌ Still has {{PLACEHOLDERS}}
  ...
)
```

**Correct implementation:**
```python
# ✅ CORRECT: Full placeholder injection
prompt_template = read('prompts/step2_dramatic_spine.md')
npe_content = read('outputs/npe.md')
story_content = read('input/story-concept.md')

final_prompt = prompt_template
final_prompt = final_prompt.replace('{{NPE}}', npe_content)
final_prompt = final_prompt.replace('{{STORY_CONCEPT}}', story_content)

# Validate
assert '{{' not in final_prompt, "Placeholders still present!"

Task(
  subagent_type="story-architect",
  prompt=final_prompt,  # ✅ All content injected
  ...
)
```

### Problem: "File not found" error in subagent

**Symptom:** Subagent tries to read a file but can't find it.

**Root Cause:** Placeholder not replaced, subagent tries to read the file path literally.

**Solution:** Ensure placeholder injection happened. The subagent should NEVER need to read files.

### Validation Checklist

Before spawning ANY subagent, verify:

- [ ] All input files loaded from `step_config['inputs']`
- [ ] Prompt template loaded from `prompts/[step_config['prompt_template']]`
- [ ] All `{{PLACEHOLDER}}` tokens replaced with actual file contents
- [ ] Final prompt contains NO `{{` or `}}` characters
- [ ] Final prompt is significantly longer than template (because file contents are embedded)
- [ ] Using `final_prompt` variable, NOT `prompt_template` in Task call

## Notes for Future Steps

When adding new workflow steps:
1. Add step definition to `workflow_config.json`
2. Create prompt template in `prompts/`
3. Specify correct `agent_type` from `.claude/agents/`
4. Define `inputs` with placeholder names matching `{{TOKENS}}` in prompt
5. Define `outputs` with descriptive keys and paths
6. Set `depends_on` for any prerequisite steps

The orchestrator will automatically handle the rest!
