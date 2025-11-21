# Orchestrator Guide for Claude Code

This document explains how Claude Code should execute the book design workflow steps.

## Overview

When the user says **"Run step [N]"** or **"Run the book design workflow"**, Claude Code acts as the orchestrator, spawning specialized subagents for each creative task.

## Orchestration Process

### Step-by-Step Execution

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

#### 5. Inject Inputs into Prompt Template

Replace all `{{PLACEHOLDER_NAME}}` tokens in the prompt template with the loaded file contents:

```
Before: "Here is the NPE: {{NPE}}"
After: "Here is the NPE: [full contents of outputs/npe.md]"
```

#### 6. Build the Complete Agent Prompt

The final prompt sent to the subagent consists of:

**The agent is already loaded via the agent_type field** - Claude Code's Task tool will automatically load the agent definition from `.claude/agents/[agent_type].md` when you specify the subagent_type parameter.

So you just need to pass the **injected prompt template** as the task prompt.

#### 7. Spawn the Subagent

Use the Task tool to spawn the specialized agent:

```
Task tool parameters:
- subagent_type: [agent_type from config]
- prompt: [injected prompt template]
- description: [brief description of what this step does]
- model: [model from config, or default to sonnet]
```

Example:
```python
Task(
  subagent_type="character-architect",
  prompt="[full injected prompt with all placeholders replaced]",
  description="Develop character profile from concept",
  model="sonnet"
)
```

#### 8. Save the Output

When the subagent completes:
- Take the agent's output
- Save it to the path specified in `outputs`
- Confirm to the user that the step completed

Example:
```
outputs: {
  "character_profile": "outputs/character_profile.md"
}
```
Save the agent's response to `outputs/character_profile.md`

## Example: Running Step 2

User says: **"Run step 2"**

### Orchestrator Actions:

1. **Load config**: Read `workflow_config.json`, get step "2"
   ```json
   {
     "name": "Character Development",
     "agent_type": "character-architect",
     "prompt_template": "step2_character_development.md",
     "inputs": {
       "CHARACTER_CONCEPT": "input/character-concept.md",
       "MAIN_CHARACTER_TEMPLATE": "templates/main_character_template_v1.1.md",
       "NPE": "outputs/npe.md"
     },
     "outputs": {
       "character_profile": "outputs/character_profile.md"
     },
     "depends_on": ["1"]
   }
   ```

2. **Check dependencies**: Verify Step 1 completed by checking `outputs/npe.md` exists

3. **Load inputs**:
   - Read `input/character-concept.md` → store as CHARACTER_CONCEPT
   - Read `templates/main_character_template_v1.1.md` → store as MAIN_CHARACTER_TEMPLATE
   - Read `outputs/npe.md` → store as NPE

4. **Load prompt template**: Read `prompts/step2_character_development.md`

5. **Inject inputs**: Replace placeholders:
   - `{{CHARACTER_CONCEPT}}` → contents of character-concept.md
   - `{{MAIN_CHARACTER_TEMPLATE}}` → contents of template
   - `{{NPE}}` → contents of npe.md

6. **Spawn subagent**:
   ```
   Task(
     subagent_type="character-architect",
     prompt="[fully injected prompt]",
     description="Develop character profile from concept",
     model="sonnet"
   )
   ```

7. **Save output**: When agent completes, save response to `outputs/character_profile.md`

8. **Confirm**: Tell user "Step 2 completed. Character profile saved to outputs/character_profile.md"

## Special Case: Multiple Characters (Step 2)

Step 2 is special because `input/character-concept.md` can contain **multiple characters**, and each character should get its own parallel subagent.

### Character File Format

The character-concept file uses this structure:

```markdown
# CHARACTER: Sarah Chen
[concept for Sarah]

---

# CHARACTER: Marcus Reed
[concept for Marcus]

---

# CHARACTER: Dr. Elena Vasquez
[concept for Elena]

---
```

### Parallel Processing

When executing Step 2:

#### 1. Parse Character File

Read `input/character-concept.md` and split it into individual characters:

```python
# Pseudocode
characters = []
sections = character_file.split('# CHARACTER:')
for section in sections[1:]:  # Skip first empty section
    lines = section.strip().split('\n')
    name = lines[0].strip()  # First line is the name
    concept = '\n'.join(lines[1:]).split('---')[0].strip()  # Content until ---
    characters.append({'name': name, 'concept': concept})
```

Example result:
```python
[
  {'name': 'Sarah Chen', 'concept': 'Sarah is the protagonist...'},
  {'name': 'Marcus Reed', 'concept': 'Marcus is the antagonist...'},
  {'name': 'Dr. Elena Vasquez', 'concept': 'Elena is Sarah\'s mentor...'}
]
```

#### 2. Spawn Parallel Subagents

For each character, spawn a separate character-architect agent **in parallel**:

```python
# Send a SINGLE message with MULTIPLE Task tool calls
for character in characters:
    # Build prompt for this character
    prompt = load_prompt_template('step2_character_development.md')
    prompt = prompt.replace('{{CHARACTER_CONCEPT}}', character['concept'])
    prompt = prompt.replace('{{MAIN_CHARACTER_TEMPLATE}}', template_content)
    prompt = prompt.replace('{{NPE}}', npe_content)

    # Spawn task (all in same message = parallel execution)
    Task(
        subagent_type="character-architect",
        prompt=prompt,
        description=f"Develop character profile for {character['name']}",
        model="sonnet"
    )
```

**Critical:** Send all Task tool calls in a **single message** to run them in parallel. Don't wait for one to complete before spawning the next.

#### 3. Save Multiple Outputs

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

1. **Minimal Context**: Only load files specified in `inputs` - don't load the entire codebase
2. **Sequential Dependencies**: Respect `depends_on` - never skip required steps
3. **Clear Communication**: Tell the user what you're doing at each stage
4. **Error Recovery**: Provide helpful error messages with clear next actions
5. **Agent Trust**: Trust the specialized agents' outputs - they're designed for their tasks

## Notes for Future Steps

When adding new workflow steps:
1. Add step definition to `workflow_config.json`
2. Create prompt template in `prompts/`
3. Specify correct `agent_type` from `.claude/agents/`
4. Define `inputs` with placeholder names matching `{{TOKENS}}` in prompt
5. Define `outputs` with descriptive keys and paths
6. Set `depends_on` for any prerequisite steps

The orchestrator will automatically handle the rest!
