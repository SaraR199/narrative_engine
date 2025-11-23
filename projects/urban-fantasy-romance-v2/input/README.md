# Urban Fantasy Romance V2 - Input Files

This directory contains the input files needed to run the narrative workflow for your project.

## Required Input Files

Please add the following files to this directory before running the workflow:

### 1. `existing_outline.md` (Required for Step 1: NPE Extraction)
Your existing story outline that will be analyzed to extract your narrative physics engine (NPE) - the implicit rules and patterns you follow in storytelling.

### 2. `story-concept.md` (Required)
High-level story premise and concept. This should include:
- Core story idea
- Central conflict
- Setting overview
- Genre elements

### 3. `characters-concept.md` (Required for Steps 2, 3, 4, 6)
Character concepts and initial ideas. Include:
- Main characters
- Supporting characters
- Initial character traits and motivations
- Any relationships you envision

### 4. `world-concept.md` (Required)
World-building concepts and setting details:
- Magic system (if applicable)
- World rules and constraints
- Setting details
- Cultural/societal elements

## Note on Relationship Mapping

Relationship mapping is automatically generated in **Step 6** from your characters and story concepts - you don't need to create this manually.

## Running the Workflow

Once you've added all required input files, you can run the workflow using:

```
Run step 1 for urban-fantasy-romance-v2
```

Or run the entire workflow at once:

```
Run the entire workflow for urban-fantasy-romance-v2
```

## Workflow Steps

The complete workflow includes:
1. **NPE Extraction** - Extract your narrative physics engine
2. **Dramatic Spine Extraction** - Identify core dramatic structure
3. **Theme Extraction** - Pull out thematic elements
4. **Character Development** - Develop multi-dimensional characters
5. **World Constraints Extraction** - Define world rules
6. **Relationship Mapping** - Map character relationships
7. **Relationship Architecture** - Design relationship dynamics
8. **Premise Refinement** - Refine your story premise
9. **Story Outline** - Create detailed story outline
10. **NPE Inspection** - Validate narrative physics
11. **Outline Rewrite** - Final outline refinement

All outputs will be saved to `projects/urban-fantasy-romance-v2/outputs/`
