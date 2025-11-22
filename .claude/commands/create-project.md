---
description: Create a new narrative project with input and outputs directories
---

Create a new narrative project with the following structure:

1. Create `projects/{project_name}/input/` directory
2. Create `projects/{project_name}/outputs/` directory
3. Initialize `projects/{project_name}/workflow_state.json` with all steps in "pending" status
4. Create a README in the input directory explaining what files to add

The project name should be provided by the user after the command (e.g., `/create-project fantasy-novel`).

After creating the project, inform the user:
- Where the project was created
- What input files they need to add to `projects/{project_name}/input/`
- How to run the workflow for this project

Required input files for the workflow:
- `existing_outline.md` - Existing outline for NPE extraction (for Step 1)
- `story-concept.md` - High-level story premise and concept
- `characters-concept.md` - Character concepts and initial ideas (used in Steps 2, 3, 4, 6)
- `world-concept.md` - World-building concepts and setting

Note: Relationship mapping is automatically generated in Step 6 from your characters and story concepts.

## Workflow State Initialization

When creating a new project, you MUST initialize `workflow_state.json` with the following structure:

```json
{
  "workflow_version": "1.0.0",
  "project_name": "{project_name}",
  "current_step": "1",
  "last_updated": "{current_timestamp_iso8601}",
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

Replace `{project_name}` with the actual project name and `{current_timestamp_iso8601}` with the current timestamp in ISO 8601 format (e.g., "2025-11-22T21:45:00Z").

This state file enables:
- Resuming workflow across multiple chat sessions
- Tracking which steps are completed
- Clear signaling of what step to run next

Usage example:
```
/create-project fantasy-novel
```

Then the user can run:
```
Run step 1 for fantasy-novel
Run the entire workflow for fantasy-novel
```
