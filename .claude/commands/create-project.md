---
description: Create a new narrative project with input and outputs directories
---

Create a new narrative project with the following structure:

1. Create `projects/{project_name}/input/` directory
2. Create `projects/{project_name}/outputs/` directory
3. Create a README in the input directory explaining what files to add

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

Usage example:
```
/create-project fantasy-novel
```

Then the user can run:
```
Run step 1 for fantasy-novel
Run the entire workflow for fantasy-novel
```
