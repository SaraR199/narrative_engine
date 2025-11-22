# Input Files for default project

Add the following files to this directory to use the Book Design Workflow:

## Required Files

### For NPE Extraction (Step 1)
- **existing_outline.md** - An existing book outline from another project you've worked on. This will be analyzed to extract your generic writing preferences and create your Narrative Physics Engine (NPE).

### For Story Development (Steps 2-11)
- **story-concept.md** - Your high-level story premise, logline, and core concept
- **characters-concept.md** - Character concepts and ideas (used in Steps 2, 3, 4, 6)
- **world-concept.md** - World-building concepts, setting details, and constraints

## Generated Files

The workflow automatically generates:
- **Relationship mapping** (Step 6) - Extracted from your characters and story concepts
- **Character profiles** (Step 4) - One file per character
- **Relationship architectures** (Step 7) - One file per key relationship

## File Format

All files should be in Markdown format (.md). Be as detailed as possible - the more context you provide, the better the workflow outputs will be.

## Running the Workflow

Once you've added your input files, tell Claude Code:

```
Run step 1 for default
```

Or to run the entire workflow:

```
Run the book design workflow for default
```

## Outputs

Generated outputs will be saved to `projects/default/outputs/`
