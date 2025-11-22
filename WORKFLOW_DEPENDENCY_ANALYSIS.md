# Workflow Dependency Analysis

## Overview

This document provides a comprehensive analysis of the dependencies between all 11 steps in the Book Design Workflow, identifying execution constraints, parallelization opportunities, and critical paths.

## Executive Summary

- **Total Steps**: 11
- **Foundation Steps**: 3 (Steps 1-3 must run sequentially)
- **Parallelizable Steps**: 2 pairs (Steps 5-6, potentially Steps 10-11 if split)
- **Critical Path Length**: 9 steps (longest sequential chain)
- **Convergence Points**: 2 major (Steps 7 and 9)
- **Quality Assurance Loop**: Steps 10-11 (inspection and rewrite)

## Step-by-Step Dependency Map

### Step 1: NPE Extraction
**Agent**: npe-extractor
**Dependencies**: None (root step)
**Inputs**:
- `templates/npe_template`
- `input/existing_outline.md`

**Outputs**: `outputs/npe.md`
**Critical**: ✅ Foundation for entire workflow

**Description**: Extracts generic writing preferences from an existing outline to create a Narrative Physics Engine that constrains all subsequent creative decisions.

**Execution Notes**: Must run first. No parallelization possible.

---

### Step 2: Dramatic Spine Extraction
**Agent**: story-architect
**Dependencies**: `[1]`
**Inputs**:
- `input/story-concept.md`
- `input/characters-concept.md`
- `input/world-concept.md`
- `outputs/npe.md` (from Step 1)

**Outputs**: `outputs/dramatic_spine.md`
**Critical**: ✅ Required by all downstream steps

**Description**: Identifies 1-3 primary tension axes and the dominant energy that drives the narrative forward.

**Execution Notes**: Cannot run until Step 1 completes. No parallelization possible.

---

### Step 3: Theme Extraction
**Agent**: story-architect
**Dependencies**: `[1, 2]`
**Inputs**:
- `input/story-concept.md`
- `input/characters-concept.md`
- `input/world-concept.md`
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)

**Outputs**: `outputs/themes.md`
**Critical**: ✅ Required by all downstream steps

**Description**: Extracts core thematic questions (not statements) - ONE main theme and max 2 secondary themes.

**Execution Notes**: Cannot run until Steps 1 and 2 complete. No parallelization possible.

---

### Step 4: Character Development
**Agent**: character-architect
**Dependencies**: `[1, 2, 3]`
**Parallel Processing**: ✅ Yes (spawns one agent per character)
**Inputs**:
- `input/character-concept.md`
- `templates/main_character_template_v1.1.md`
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)

**Outputs**: `outputs/character_*.md` (multiple files)
**Critical**: ✅ Required by Steps 5, 6, 7, 8, 9

**Description**: Develops detailed character profiles using the Main Character Template. Supports multiple characters with parallel subagent spawning.

**Execution Notes**: Cannot run until Steps 1-3 complete. Internal parallelization across characters.

---

### Step 5: World Constraints Extraction
**Agent**: story-architect
**Dependencies**: `[1, 2, 3, 4]`
**Inputs**:
- `input/world-concept.md`
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)
- `outputs/character_*.md` (from Step 4)

**Outputs**: `outputs/world_constraints.md`
**Critical**: ✅ Required by Steps 7, 8, 9

**Description**: Extracts functional world constraints that limit movement, choices, and possibilities—not a travel guide, but plot-forcing parameters.

**Execution Notes**: ⚡ **CAN RUN IN PARALLEL WITH STEP 6** (both depend only on 1-4).

---

### Step 6: Relationship Mapping
**Agent**: character-architect
**Dependencies**: `[1, 2, 3, 4]`
**Inputs**:
- `input/story-concept.md`
- `input/characters-concept.md`
- `outputs/character_*.md` (from Step 4)
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)

**Outputs**: `outputs/relationship_mapping.md`
**Critical**: ✅ Required by Steps 7, 8, 9

**Description**: Identifies main/primary relationships that drive plot, character arcs, or themes. Filters to relationships that actually matter.

**Execution Notes**: ⚡ **CAN RUN IN PARALLEL WITH STEP 5** (both depend only on 1-4).

---

### Step 7: Relationship Architecture
**Agent**: character-architect
**Dependencies**: `[1, 2, 3, 4, 5, 6]`
**Parallel Processing**: ✅ Yes (spawns one agent per relationship)
**Inputs**:
- `outputs/relationship_mapping.md` (from Step 6)
- `outputs/character_*.md` (from Step 4)
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)
- `outputs/world_constraints.md` (from Step 5)

**Outputs**: `outputs/relationship_*.md` (multiple files)
**Critical**: ✅ Required by Steps 8, 9

**Description**: Defines relationship architecture for key character pairings across three-act structure. Creates specs for consistent, evolving interactions.

**Execution Notes**: Cannot run until both Steps 5 and 6 complete (convergence point). Internal parallelization across relationships.

---

### Step 8: Premise Refinement
**Agent**: story-architect
**Dependencies**: `[1, 2, 3, 4, 5, 6, 7]`
**Inputs**:
- `input/story-concept.md`
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)
- `outputs/character_*.md` (from Step 4)
- `outputs/world_constraints.md` (from Step 5)
- `outputs/relationship_*.md` (from Step 7)

**Outputs**: `outputs/refined_premise.md`
**Critical**: ✅ Required by Step 9

**Description**: Refines original story premise to align with all established structural foundations. Reads ONLY story-concept.md from original inputs plus all workflow outputs.

**Execution Notes**: Cannot run until Step 7 completes. No parallelization possible.

---

### Step 9: Story Outline
**Agent**: story-architect
**Dependencies**: `[1, 2, 3, 4, 5, 6, 7, 8]`
**Inputs**:
- `outputs/npe.md` (from Step 1)
- `outputs/dramatic_spine.md` (from Step 2)
- `outputs/themes.md` (from Step 3)
- `outputs/character_*.md` (from Step 4)
- `outputs/world_constraints.md` (from Step 5)
- `outputs/relationship_*.md` (from Step 7)
- `outputs/refined_premise.md` (from Step 8)

**Outputs**: `outputs/outline.md`
**Critical**: ✅ Required by Steps 10, 11

**Description**: Synthesizes ALL workflow outputs into complete 3-act story outline. Does NOT read original concept files—only uses NPE and workflow-generated outputs.

**Execution Notes**: Major convergence point. Cannot run until all foundation work (Steps 1-8) completes. No parallelization possible.

---

### Step 10: NPE Inspection
**Agent**: story-architect
**Dependencies**: `[1, 9]`
**Inputs**:
- `outputs/npe.md` (from Step 1)
- `outputs/outline.md` (from Step 9)

**Outputs**: `outputs/npe_inspection_report.md`
**Critical**: ✅ Required by Step 11

**Description**: Performs rigorous quality assurance inspection of the generated outline against the NPE. Identifies violations, strengths, and provides prioritized recommendations.

**Execution Notes**: Quality assurance step. Depends only on Steps 1 and 9 (not on intermediate steps 2-8).

---

### Step 11: Outline Rewrite
**Agent**: story-architect
**Dependencies**: `[1, 9, 10]`
**Inputs**:
- `outputs/npe.md` (from Step 1)
- `outputs/npe_inspection_report.md` (from Step 10)
- `outputs/outline.md` (from Step 9)

**Outputs**: `outputs/outline_revised.md`
**Critical**: ✅ Final output

**Description**: Rewrites the outline to achieve full NPE compliance based on inspection report. Authorized to rebuild entire acts and restructure scenes from scratch.

**Execution Notes**: Final step. Cannot run until Step 10 completes. No parallelization possible.

---

## Dependency Graph (ASCII Visualization)

```
Step 1: NPE Extraction
   │
   ├─────────────────────────────────────────────────────┐
   │                                                       │
   ▼                                                       │
Step 2: Dramatic Spine                                    │
   │                                                       │
   ├──────────────────────────────┐                       │
   │                               │                       │
   ▼                               │                       │
Step 3: Theme Extraction          │                       │
   │                               │                       │
   ├──────────┐                    │                       │
   │          │                    │                       │
   ▼          │                    │                       │
Step 4: Character Development     │                       │
   │          │                    │                       │
   ├──────────┼────────────────────┼───────────────────┐  │
   │          │                    │                   │  │
   ▼          ▼                    ▼                   ▼  │
Step 5: World      Step 6: Relationship Mapping          │
Constraints                                               │
   │                    │                                 │
   └────────┬───────────┘                                 │
            │                                             │
            ▼                                             │
Step 7: Relationship Architecture                        │
            │                                             │
            ├─────────────────────────────────────────┐   │
            │                                         │   │
            ▼                                         │   │
Step 8: Premise Refinement                           │   │
            │                                         │   │
            ├─────────────────────────────────────┐   │   │
            │                                     │   │   │
            ▼                                     │   │   │
Step 9: Story Outline ◄───────────────────────────┤   │   │
            │                                     │   │   │
            ├─────────────────────────────────────┘   │   │
            │                                         │   │
            ▼                                         ▼   ▼
Step 10: NPE Inspection ◄─────────────────────────────────┘
            │
            │
            ▼
Step 11: Outline Rewrite
```

## Critical Path Analysis

### Longest Sequential Path (Critical Path)
The critical path determines the minimum time to complete the workflow:

```
1 → 2 → 3 → 4 → 7 → 8 → 9 → 10 → 11
```

**Length**: 9 steps

**Why Step 7 instead of Steps 5 or 6?**
Step 7 depends on BOTH Step 5 and Step 6, making it the bottleneck. Even though Steps 5 and 6 can run in parallel, Step 7 cannot start until both complete.

### Alternative Paths

**Path through Step 5**:
```
1 → 2 → 3 → 4 → 5 → 7 → 8 → 9 → 10 → 11
```
Length: 9 steps (same as critical path)

**Path through Step 6**:
```
1 → 2 → 3 → 4 → 6 → 7 → 8 → 9 → 10 → 11
```
Length: 9 steps (same as critical path)

## Parallelization Opportunities

### Confirmed Parallelization

#### Opportunity 1: Steps 5 and 6
**Steps**: World Constraints Extraction (5) + Relationship Mapping (6)
**Dependencies**: Both depend only on `[1, 2, 3, 4]`
**Time Savings**: 1 step equivalent
**Implementation**: Both can spawn immediately after Step 4 completes

**Execution Strategy**:
```
After Step 4 completes:
- Spawn Step 5 agent (story-architect)
- Spawn Step 6 agent (character-architect) in parallel
- Wait for both to complete before proceeding to Step 7
```

#### Opportunity 2: Internal Parallelization

**Step 4: Character Development**
- Spawns multiple character-architect agents (one per character)
- Parallel processing flag: `true`
- All character profiles generated simultaneously

**Step 7: Relationship Architecture**
- Spawns multiple character-architect agents (one per relationship)
- Parallel processing flag: `true`
- All relationship architectures generated simultaneously

### Theoretical Parallelization (Not Recommended)

#### Steps 10 and 11 Split
Currently, Step 11 depends on Step 10's inspection report. However, if the user wanted to skip QA and go straight to a rewrite, they could theoretically run a modified Step 11 without Step 10.

**Not recommended because**:
- Step 10 provides critical quality assurance
- Step 11 needs the inspection report for targeted fixes
- Skipping inspection defeats the purpose of the QA loop

## Convergence Points

### Convergence Point 1: Step 7 (Relationship Architecture)
**Inputs from**:
- Step 1 (NPE)
- Step 2 (Dramatic Spine)
- Step 3 (Themes)
- Step 4 (Character Profiles)
- Step 5 (World Constraints)
- Step 6 (Relationship Mapping)

**Significance**: First major synthesis point. Combines character work, world constraints, and relationship mapping into concrete relationship architectures.

### Convergence Point 2: Step 9 (Story Outline)
**Inputs from**:
- Step 1 (NPE)
- Step 2 (Dramatic Spine)
- Step 3 (Themes)
- Step 4 (Character Profiles)
- Step 5 (World Constraints)
- Step 7 (Relationship Architectures)
- Step 8 (Refined Premise)

**Significance**: Final synthesis point. Combines ALL workflow outputs into the complete story outline. This is the primary deliverable before QA.

## Data Flow Analysis

### NPE (Step 1) Usage
The NPE is the most widely used output, referenced by:
- Steps 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

**Interpretation**: The NPE is the constraint system for the entire workflow. Every creative decision must align with it.

### Dramatic Spine (Step 2) Usage
Referenced by:
- Steps 3, 4, 5, 6, 7, 8, 9

**Interpretation**: The dramatic spine (tension axes and dominant energy) guides all structural decisions after theme extraction.

### Themes (Step 3) Usage
Referenced by:
- Steps 4, 5, 6, 7, 8, 9

**Interpretation**: Thematic questions inform character development, world constraints, relationships, and final synthesis.

### Character Profiles (Step 4) Usage
Referenced by:
- Steps 5, 6, 7, 8, 9

**Interpretation**: Character profiles are central to world constraints (how characters interact with world), relationships, and outline generation.

### World Constraints (Step 5) Usage
Referenced by:
- Steps 7, 8, 9

**Interpretation**: World constraints inform relationship dynamics and final synthesis, but are not needed for character or relationship mapping.

### Relationship Mapping (Step 6) Usage
Referenced by:
- Step 7 only

**Interpretation**: Relationship mapping is a preparatory step for relationship architecture. Its output is not directly referenced in later synthesis steps—only the architectures from Step 7 are.

### Relationship Architectures (Step 7) Usage
Referenced by:
- Steps 8, 9

**Interpretation**: Relationship architectures (not the mapping) are used in premise refinement and outline generation.

### Refined Premise (Step 8) Usage
Referenced by:
- Step 9 only

**Interpretation**: The refined premise is the final input before outline generation. It consolidates everything into a focused starting point.

### Outline (Step 9) Usage
Referenced by:
- Steps 10, 11

**Interpretation**: The outline is the primary deliverable, then evaluated and revised in the QA loop.

## Input File Dependencies

### Original Input Files (User-Provided)
These are read from the `input/` directory:

- `input/existing_outline.md` → Step 1 only
- `input/story-concept.md` → Steps 2, 3, 6, 8
- `input/characters-concept.md` → Steps 2, 3, 6
- `input/character-concept.md` → Step 4 only
- `input/world-concept.md` → Steps 2, 3, 5

### Template Files
- `templates/npe_template` → Step 1 only
- `templates/main_character_template_v1.1.md` → Step 4 only

**Observation**: Most original concept files are only used in the early steps (1-6). Steps 8 onwards primarily use workflow-generated outputs, with the exception of `story-concept.md` in Step 8.

### Design Rationale
This is intentional:
- Early steps extract and refine concepts
- Later steps synthesize workflow outputs
- Step 9 (Outline) intentionally does NOT read original concept files—only uses NPE and workflow-generated outputs to ensure consistency

## Execution Strategies

### Strategy 1: Maximum Parallelization
**Goal**: Minimize total execution time

**Execution Order**:
1. Run Step 1 (NPE Extraction)
2. Run Step 2 (Dramatic Spine Extraction)
3. Run Step 3 (Theme Extraction)
4. Run Step 4 (Character Development) with internal parallelization
5. **Run Steps 5 and 6 in parallel** ⚡
6. Run Step 7 (Relationship Architecture) with internal parallelization
7. Run Step 8 (Premise Refinement)
8. Run Step 9 (Story Outline)
9. Run Step 10 (NPE Inspection)
10. Run Step 11 (Outline Rewrite)

**Time Savings**: 1 step equivalent (Steps 5 and 6 run simultaneously)

### Strategy 2: Sequential Execution
**Goal**: Simplicity and clarity

**Execution Order**: Steps 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10 → 11

**Use Case**: Debugging, understanding workflow, or when execution time is not critical.

### Strategy 3: Iterative Refinement
**Goal**: High-quality outputs with user review between steps

**Execution Order**:
1. Run Steps 1-3 (foundation)
2. **User reviews** NPE, dramatic spine, themes
3. Run Step 4 (characters)
4. **User reviews** character profiles
5. Run Steps 5-6 in parallel (world + relationships)
6. **User reviews** world constraints and relationship mapping
7. Run Step 7 (relationship architectures)
8. **User reviews** relationship architectures
9. Run Steps 8-9 (premise + outline)
10. **User reviews** outline
11. Run Steps 10-11 (QA loop)
12. **User reviews** final revised outline

**Use Case**: Maximum quality and user control over creative direction.

## Bottleneck Analysis

### Bottleneck 1: Step 4 (Character Development)
**Why**: Required by Steps 5, 6, 7, 8, 9. No downstream work can proceed without it.

**Mitigation**: Internal parallelization across characters (already implemented with `parallel_processing: true`).

### Bottleneck 2: Step 7 (Relationship Architecture)
**Why**: Must wait for BOTH Steps 5 and 6 to complete. Even though they run in parallel, Step 7 is blocked until the slower of the two finishes.

**Mitigation**:
- Optimize Steps 5 and 6 to complete in similar timeframes
- Use faster model (haiku) if quality permits
- Consider using opus only where necessary

### Bottleneck 3: Step 9 (Story Outline)
**Why**: Requires inputs from Steps 1-8. No QA work can proceed without it.

**Mitigation**: None possible—this is a natural convergence point. Consider using opus model for highest quality since this is the primary deliverable.

## Quality Assurance Loop (Steps 10-11)

### Design Pattern
Steps 10-11 form a **quality assurance feedback loop**:

```
Step 9: Outline
    │
    ├─────────────┐
    │             │
    ▼             ▼
Step 10:      Step 1:
Inspection    NPE (reference)
    │             │
    └──────┬──────┘
           │
           ▼
Step 11: Rewrite
```

### Dependency Minimization
**Key Insight**: Step 10 depends only on `[1, 9]`, not on Steps 2-8.

**Why**: The NPE inspection only needs to compare the outline against the NPE constraints. Intermediate outputs (themes, characters, world, etc.) are not needed for QA—they're already baked into the outline.

**Benefit**: If Steps 2-8 outputs change, Step 10 doesn't need to re-run unless Step 9 (outline) also changes.

### Rewrite Philosophy
From the config:
> "Authorized to rebuild entire acts, restructure scenes from scratch, and make fundamental structural changes. Not a patch job—fluid reconstruction with focus on structural integrity over preservation."

**Interpretation**: Step 11 is not a minor edit pass. It's a full rewrite with permission to radically restructure.

## Recommendations

### For Orchestrator Implementation

1. **Implement parallel execution for Steps 5-6**
   - Spawn both agents simultaneously after Step 4 completes
   - Use Promise.all() or equivalent to wait for both
   - Only proceed to Step 7 after both complete

2. **Respect internal parallelization flags**
   - Steps 4 and 7 have `parallel_processing: true`
   - Parse input files to identify multiple entities (characters, relationships)
   - Spawn one subagent per entity
   - Aggregate outputs before proceeding

3. **Implement dependency validation**
   - Before running a step, verify all `depends_on` steps have completed
   - Check that all required input files exist
   - Fail fast with clear error messages

4. **Support selective re-runs**
   - If Step 5 output changes, automatically invalidate Steps 7, 8, 9, 10, 11
   - If Step 6 output changes, automatically invalidate Steps 7, 8, 9, 10, 11
   - Allow user to re-run individual steps while respecting dependencies

### For Workflow Design

1. **Consider splitting Step 9**
   - Step 9 has 7 input dependencies (most in the workflow)
   - Could potentially split into "Act Structure" and "Scene Breakdown"
   - Would allow for intermediate user review

2. **Consider iterative QA loop**
   - Currently, Step 11 runs once
   - Could support multiple inspection-rewrite cycles
   - Add Step 12: "Final NPE Validation" as optional final check

3. **Monitor bottlenecks in production**
   - Track execution time for each step
   - Identify which steps take longest
   - Consider model optimization (e.g., haiku for faster steps, opus for critical ones)

## Conclusion

The workflow has a well-designed dependency structure with:
- Clear sequential foundation (Steps 1-3)
- Strategic parallelization opportunities (Steps 5-6)
- Multiple convergence points for synthesis (Steps 7, 9)
- Minimal dependencies in QA loop (Steps 10-11)

The critical path is 9 steps long, with 1 parallelization opportunity that can reduce effective execution time by 1 step equivalent.

The NPE (Step 1) serves as the constraint system for the entire workflow, referenced by 10 of 11 steps. All creative decisions flow through and are validated against the NPE.
