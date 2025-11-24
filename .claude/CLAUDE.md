# Orchestrator Guide for Claude Code

## Critical Rule: Placeholder Injection

**BEFORE spawning any subagent, replace ALL `{{PLACEHOLDER}}` tokens with file path instructions.**

```python
# ❌ WRONG - sending raw template
prompt = "Here is the NPE: {{NPE}}"

# ✅ CORRECT - inject file paths
prompt = "Here is the NPE: Read the NPE from outputs/npe.md"

# Always validate before spawning
assert '{{' not in prompt and '}}' not in prompt
```

---

## Workflow State Tracking

Location: `projects/{project-name}/workflow_state.json`

### State File Structure
```json
{
  "workflow_version": "1.0.0",
  "project_name": "my-project",
  "current_step": "3",
  "last_updated": "2025-11-22T21:45:00Z",
  "steps": {
    "1": {"name": "NPE Extraction", "status": "completed", "completed_at": "..."},
    "2": {"name": "Dramatic Spine", "status": "completed", "completed_at": "..."},
    "3": {"name": "Theme Extraction", "status": "in_progress", "started_at": "..."}
  }
}
```

### State Management Rules
- **Before starting step**: Set status to `in_progress`, record `started_at`
- **After completing step**: Set status to `completed`, record `completed_at`, advance `current_step`
- **On failure**: Set status to `failed`, record error message
- **On "continue" command**: Read state, execute `current_step`

---

## Step Execution Process

### 1. Check Dependencies
- Read `workflow_config.json` for step definition
- Verify all `depends_on` steps are completed
- Verify all input files exist (don't read contents)

### 2. Load & Inject Prompt
```python
prompt = read(f"prompts/{step_config['prompt_template']}")

for placeholder, path in step_config['inputs'].items():
    token = f"{{{{{placeholder}}}}}"
    if '*' in path:
        instruction = f"Read all files matching {path}"
    else:
        instruction = f"Read the {placeholder.lower().replace('_', ' ')} from {path}"
    prompt = prompt.replace(token, instruction)

assert '{{' not in prompt  # Validate
```

### 3. Update State & Spawn
```python
# Mark in_progress
state['steps'][step]['status'] = 'in_progress'
write(state_file, state)

# Spawn subagent
Task(
    subagent_type=step_config['agent_type'],
    prompt=prompt,  # Path-injected, NO placeholders
    description=step_config['description'],
    model=step_config.get('model', 'sonnet')
)
```

### 4. Save Output & Update State
```python
# Save agent output
write(step_config['outputs']['key'], agent_response)

# Mark completed, advance step
state['steps'][step]['status'] = 'completed'
state['current_step'] = str(int(step) + 1) if int(step) < 11 else None
write(state_file, state)
```

---

## Parallelization

### Parallel Steps (5 & 6)
Both depend only on steps 1-4, so run simultaneously:

```python
# Prepare BOTH prompts with path injection first
step5_prompt = inject_paths(step5_template, step5_inputs)
step6_prompt = inject_paths(step6_template, step6_inputs)

# Spawn BOTH in single message
Task(subagent_type="story-architect", prompt=step5_prompt, ...)
Task(subagent_type="character-architect", prompt=step6_prompt, ...)
```

### Internal Parallelization

**Step 4 (Characters)**: Parse `input/characters-concept.md` to extract individual characters, spawn one agent per character.

**Step 7 (Relationships)**: Parse `outputs/relationship_mapping.md` to extract relationships, spawn one agent per relationship.

```python
# Parse entities (use Explore agent for complex files)
entities = parse_file(input_file)

# Prepare ALL prompts first
prompts = [inject_paths(template, entity) for entity in entities]

# Spawn ALL in single message
for entity, prompt in zip(entities, prompts):
    Task(subagent_type="character-architect", prompt=prompt, ...)
```

**Output naming**:
- Characters: `outputs/character_{Name_With_Underscores}.md`
- Relationships: `outputs/relationship_{CharA}_{CharB}.md`

---

## Common Placeholder Injections

| Placeholder | Injection |
|-------------|-----------|
| `{{NPE}}` | `Read the npe from outputs/npe.md` |
| `{{STORY_CONCEPT}}` | `Read the story concept from input/story-concept.md` |
| `{{CHARACTER_PROFILES}}` | `Read all files matching outputs/character_*.md` |
| `{{MAIN_CHARACTER_TEMPLATE}}` | `Read the main character template from templates/main_character_template_v1.1.md` |

---

## Error Handling

| Error | Response |
|-------|----------|
| Missing dependency | "Step N requires Step M. Run Step M first." |
| Missing input file | "Cannot run Step N: Required file X not found." |
| Agent error | "Agent encountered error: [details]. Review inputs and retry." |

---

## Validation Checklist

Before spawning ANY subagent:
- [ ] All input files exist
- [ ] Prompt template loaded
- [ ] ALL `{{PLACEHOLDER}}` tokens replaced with file paths
- [ ] No `{{` or `}}` in final prompt
- [ ] File paths are relative
- [ ] Workflow state updated to `in_progress`