# Input Files for test-fantasy-novel

Add the following files to this directory to use the Book Design Workflow:

## Required Files

### For NPE Extraction (Step 1)
- **existing_outline.md** - An existing book outline from another project you've worked on. This will be analyzed to extract your generic writing preferences and create your Narrative Physics Engine (NPE).

### For Story Development (Steps 2-11)
- **story-concept.md** - Your high-level story premise, logline, and core concept
- **characters-concept.md** - Initial character concepts and ideas
- **world-concept.md** - World-building concepts, setting details, and constraints
- **character-concept.md** - Detailed character concept for character development (Step 4)

## Optional Files
- **relationships-concept.md** - Relationship concepts between characters (used in Step 6)

## File Format

All files should be in Markdown format (.md). Be as detailed as possible - the more context you provide, the better the workflow outputs will be.

## Running the Workflow

Once you've added your input files, tell Claude Code:

```
Run step 1 for test-fantasy-novel
```

Or to run the entire workflow:

```
Run the book design workflow for test-fantasy-novel
```

## Outputs

Generated outputs will be saved to `projects/test-fantasy-novel/outputs/`
