# Workflow State Examples

This directory contains example `workflow_state.json` files demonstrating different workflow scenarios.

## Overview

Each project maintains a `workflow_state.json` file in its root directory (`projects/{project-name}/workflow_state.json`) that tracks:
- Which steps are completed, in-progress, pending, or failed
- When each step started and finished
- What output files were generated
- What step should run next
- Any error messages if a step failed

## Example Files

### 1. Fresh Project (`workflow_state_fresh.json`)
**Scenario:** A brand new project that hasn't started yet.

- **Current step:** 1
- **Status:** All steps are "pending"
- **Use case:** Just created with `/create-project`

### 2. Mid-Workflow (`workflow_state_mid_workflow.json`)
**Scenario:** Workflow in progress - steps 1-4 completed, step 5 in progress.

- **Current step:** 5
- **Status:** Steps 1-4 completed, step 5 in_progress, steps 6-11 pending
- **Use case:** Resume work in a new chat session - "continue the workflow"

### 3. Failed Step (`workflow_state_with_failure.json`)
**Scenario:** Step 2 failed due to missing input file.

- **Current step:** 2
- **Status:** Step 1 completed, step 2 failed with error message
- **Use case:** User needs to fix the error (add missing file) then retry step 2

### 4. Completed Workflow (`workflow_state_completed.json`)
**Scenario:** All 11 steps successfully completed.

- **Current step:** null (workflow complete)
- **Status:** All steps completed with timestamps and outputs
- **Use case:** Workflow finished - all deliverables generated

## Field Descriptions

### Root Level
- `workflow_version`: Version of the workflow (from `workflow_config.json`)
- `project_name`: Name of the project
- `current_step`: The step number that should run next, or `null` if workflow is complete
- `last_updated`: ISO 8601 timestamp of last state update
- `steps`: Object containing status of each step (keyed by step number)

### Step Status Fields
- `name`: Human-readable name of the step
- `status`: One of: "pending", "in_progress", "completed", "failed"
- `started_at`: ISO 8601 timestamp when step started (if started)
- `completed_at`: ISO 8601 timestamp when step completed (if completed)
- `failed_at`: ISO 8601 timestamp when step failed (if failed)
- `error`: Error message explaining why step failed (if failed)
- `outputs_generated`: Array of output file paths created by this step (if completed)

## State Transitions

### Normal Flow
```
pending → in_progress → completed
```

### Error Flow
```
pending → in_progress → failed → in_progress → completed
                         ↑                ↓
                         └────── retry ───┘
```

## Using State in Orchestrator

The orchestrator should:

1. **Read state before any operation** to understand current workflow position
2. **Update state to "in_progress"** before starting a step
3. **Update state to "completed"** after successful step completion (with outputs)
4. **Update state to "failed"** if step encounters errors (with error message)
5. **Advance `current_step`** to next step number after completion

See `.claude/ORCHESTRATOR_GUIDE.md` for detailed state management instructions.
