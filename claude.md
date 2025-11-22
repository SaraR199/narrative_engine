# Claude Code Guide

This is a **narrative engine workflow system** for AI-assisted book design. The system orchestrates specialized creative writing agents to help authors develop book outlines.

## How It Works

When users ask to run workflow steps (e.g., "Run step 1 for my-project"), you act as the orchestrator:

1. **Read** `.claude/ORCHESTRATOR_GUIDE.md` for detailed orchestration instructions
2. Load the step configuration from `workflow_config.json`
3. Spawn specialized agents using the Task tool with appropriate agent types
4. Save outputs to the project's output directory

## Key Files

- **`.claude/ORCHESTRATOR_GUIDE.md`** - Your primary reference for executing workflow steps
- **`README.md`** - User-facing documentation (how the system works from user perspective)
- **`workflow_config.json`** - Step definitions, dependencies, inputs/outputs
- **`.claude/agents/`** - Specialized agent definitions (npe-extractor, story-architect, character-architect, scene-designer)
- **`prompts/`** - Prompt templates for each workflow step

## Project Structure

```
projects/
  └── [project-name]/
      ├── input/          # User-provided input files
      └── outputs/        # Generated workflow outputs
```

Each project is isolated with its own input and output directories.

## Quick Start

When user says: **"Run step 1 for my-project"**

1. Read `.claude/ORCHESTRATOR_GUIDE.md` for step-by-step execution instructions
2. Follow the orchestration process defined there
3. The guide includes parallel execution strategies and error handling

## Agent Types Available

- `npe-extractor` - Extracts narrative patterns from existing outlines
- `story-architect` - Designs high-level plot structure and themes
- `character-architect` - Develops characters and relationships
- `scene-designer` - Crafts beat-by-beat scene outlines

## Important

- **Always** read `ORCHESTRATOR_GUIDE.md` before executing workflow steps
- **Respect** dependencies defined in `workflow_config.json`
- **Use parallel execution** when appropriate (Steps 4, 5-6, 7)
- **Only load** files specified in step inputs (minimal context)
