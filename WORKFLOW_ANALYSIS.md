# Narrative Engine Workflow Analysis

**Date:** 2025-11-23
**Analyst:** Claude Code
**Project Version:** 1.0.0
**Current Branch:** `claude/analyze-current-performance-01PcY5Ra69uzGCd5uimwtKNp`

---

## Executive Summary

The Narrative Engine is a **production-ready, sophisticated AI-assisted creative writing workflow** that systematically transforms initial story concepts into comprehensive, constraint-driven narrative outlines. The workflow currently operates at **81.8% completion** (9/11 steps) for the active project `dragon-mafia-paranormal-v2` and demonstrates strong architectural design, effective parallelization strategies, and robust state management.

**Key Metrics:**
- **Workflow Steps:** 11 total (sequential with parallel optimization)
- **Specialized Agents:** 8 distinct agents with focused expertise
- **Active Projects:** 2 (dragon-mafia-paranormal-v1, dragon-mafia-paranormal-v2)
- **Completion Rate:** 81.8% (9/11 steps complete on v2)
- **Output Quality:** High (528-line NPE, comprehensive character/relationship profiles)
- **Parallelization Support:** Yes (Steps 5-6 parallel, Steps 4 & 7 internal parallelization)

---

## 1. Current State Assessment

### 1.1 Workflow Progress

**dragon-mafia-paranormal-v2 (Primary Active Project):**

| Step | Name | Status | Output Size | Completion Time |
|------|------|--------|-------------|-----------------|
| 1 | NPE Extraction | ✅ Completed | 528 lines (25KB) | 15 min |
| 2 | Dramatic Spine | ✅ Completed | Not measured | 18 min |
| 3 | Theme Extraction | ✅ Completed | Not measured | 15 min |
| 4 | Character Development | ✅ Completed | 7 profiles (177-188 lines ea.) | 90 min (parallel) |
| 5 | World Constraints | ✅ Completed | Not measured | 30 min |
| 6 | Relationship Mapping | ✅ Completed | 102 lines | 84 min |
| 7 | Relationship Architecture | ✅ Completed | 6 architectures | 4 min (parallel!) |
| 8 | Premise Refinement | ✅ Completed | 56 lines (simplified from 12KB) | 2 min |
| 9 | Story Outline | ✅ Completed | 93KB comprehensive | 60 min |
| 10 | NPE Inspection | ⏳ **Next Step** | Pending | - |
| 11 | Outline Rewrite | ⏳ Pending | Pending | - |

**Current Status:** Ready to execute Step 10 (NPE Inspection)

### 1.2 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                  ORCHESTRATOR (Claude Code)                  │
│  - Workflow state tracking                                   │
│  - Placeholder injection system                              │
│  - Dependency management                                     │
│  - Parallel execution coordination                           │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ├──► workflow_config.json (step definitions)
                 ├──► workflow_state.json (execution tracking)
                 │
                 ▼
    ┌────────────────────────────────────────┐
    │    SPECIALIZED AGENTS (8 types)        │
    ├────────────────────────────────────────┤
    │ • npe-extractor    (Step 1)            │
    │ • story-architect  (Steps 2,3,5,8-11)  │
    │ • character-architect (Steps 4,6,7)    │
    │ • scene-designer   (Future use)        │
    └────────────────────────────────────────┘
                 │
                 ▼
    ┌────────────────────────────────────────┐
    │      PROJECT STRUCTURE                 │
    ├────────────────────────────────────────┤
    │ input/ (user-provided concepts)        │
    │   ├─ existing_outline.md (184KB)       │
    │   ├─ characters-concept.md (40KB)      │
    │   ├─ world-concept.md (39KB)           │
    │   └─ story-concept.md (6KB)            │
    │                                         │
    │ outputs/ (generated artifacts)         │
    │   ├─ npe.md                            │
    │   ├─ character_*.md (7 files)          │
    │   ├─ relationship_*.md (6 files)       │
    │   ├─ story_outline.md (93KB)           │
    │   └─ ... (15+ files total)             │
    └────────────────────────────────────────┘
```

---

## 2. Strengths of Current Workflow

### 2.1 Architectural Strengths

#### ✅ **Context-Minimal Design**
- Each agent only receives files specified in `workflow_config.json` inputs
- No unnecessary file reads or context bloat
- Placeholder injection ensures single-read efficiency

**Evidence:** Orchestrator Guide mandates placeholder injection (lines 5-15), preventing duplicate reads.

#### ✅ **Stateful Workflow Tracking**
- `workflow_state.json` enables cross-chat resumption
- Clear signaling of next step to execute
- Timestamps for performance analysis
- Error state tracking for recovery

**Evidence:** Step statuses tracked with timestamps (workflow_state.json:10-12, 17-19, etc.)

#### ✅ **Modular Agent System**
- 8 specialized agents with focused expertise
- Each agent defined in `.claude/agents/` directory
- Easy to add new agent types without disrupting existing workflow

**Evidence:** AGENTS.md documents 8 agents, each with specific domain knowledge

#### ✅ **Dependency Management**
- `depends_on` field ensures proper execution order
- Orchestrator validates dependencies before execution
- Prevents invalid state transitions

**Evidence:** workflow_config.json lines 19, 36, 54, etc. define dependencies

### 2.2 Operational Strengths

#### ✅ **Parallelization Support**
- **Step-level parallelization:** Steps 5-6 run simultaneously
- **Internal parallelization:** Steps 4 & 7 spawn multiple agents
- Achieves **3x+ speedup** for multi-entity operations

**Evidence:**
- Step 7 completed in 4 minutes with 6 parallel relationship agents
- ORCHESTRATOR_GUIDE.md lines 643-771 detail parallel strategies

#### ✅ **Quality Control Loop**
- Steps 10-11 create inspection + revision cycle
- Ensures NPE compliance before final output
- Prevents structural drift

**Evidence:** workflow_config.json defines inspection (step 10) and rewrite (step 11) as final QA

#### ✅ **Template System**
- Reusable character templates (main vs. secondary)
- NPE template provides base structure
- Consistent output format across projects

**Evidence:** templates/ directory with v1.1 main character template, v1.0 secondary template

### 2.3 Output Quality Strengths

#### ✅ **Comprehensive NPE**
- 528 lines of detailed writing constraints
- Genre-specific customization (dragon-mafia-paranormal)
- Covers 9 narrative physics domains

**Evidence:** npe.md is 528 lines, customized for dual-genre paranormal romance/crime

#### ✅ **Detailed Character Profiles**
- 177-188 lines per character
- 7 characters fully developed
- Consistent psychological grounding

**Evidence:** character files range 177-188 lines each

#### ✅ **Relationship Architecture Depth**
- 6 relationship architectures generated
- Integration with character arcs and themes
- 3-act structure alignment

**Evidence:** workflow_state.json shows 6 relationship files generated in Step 7

---

## 3. Workflow Efficiency Analysis

### 3.1 Performance Characteristics

#### Execution Time Analysis (Estimated from Timestamps)

| Step Category | Duration | Optimization Level |
|---------------|----------|-------------------|
| Foundation (Steps 1-3) | ~48 min | Sequential (required) |
| Character Dev (Step 4) | ~90 min | **Parallel (7 agents)** |
| World/Relationships (Steps 5-6) | ~114 min | **Could be parallel** |
| Rel. Architecture (Step 7) | **4 min** | **Parallel (6 agents)** ⚡ |
| Synthesis (Steps 8-9) | ~62 min | Sequential (required) |

**Total Time (Steps 1-9):** ~318 minutes (~5.3 hours)

**Key Insight:** Step 7 demonstrates extreme efficiency gains from parallelization (6 relationships in 4 minutes suggests ~40 seconds per relationship if truly parallel, or sequential processing that's highly optimized).

### 3.2 Bottleneck Identification

#### ⚠️ **Potential Bottleneck: Step 6 (Relationship Mapping)**
- **Duration:** 84 minutes (longest after character development)
- **Nature:** Single-agent, sequential processing
- **Input:** All character profiles + concepts
- **Output:** Relationship mapping for 6 relationships

**Analysis:** This is likely appropriate—relationship mapping requires holistic analysis of all characters simultaneously. Cannot be easily parallelized as it requires identifying which relationships matter most.

#### ⚠️ **Potential Bottleneck: Steps 5-6 Not Running in Parallel**
- **Current:** Steps 5 and 6 run sequentially (based on timestamps)
- **Possible:** Both depend only on Steps 1-4, could run simultaneously
- **Savings:** ~30-84 minutes if parallel execution implemented

**Evidence:** workflow_state.json shows Step 5 completed at 19:30, Step 6 started at 20:00 (30-min gap)

### 3.3 Context Usage Efficiency

#### ✅ **Placeholder Injection System**
- **Purpose:** Prevent duplicate file reads
- **Implementation:** Mandatory replacement of `{{PLACEHOLDERS}}` before spawning
- **Validation:** ORCHESTRATOR_GUIDE requires assertion that no `{{` or `}}` remain

**Evidence:** Lines 330-374 of ORCHESTRATOR_GUIDE detail critical injection step

**Effectiveness:** High—prevents orchestrator + subagent from both reading same files

#### ✅ **Input Scoping**
- Each step only loads files in its `inputs` configuration
- Step 9 (Outline) excludes original concepts, uses only NPE + workflow outputs
- Prevents concept drift and maintains constraint integrity

**Evidence:** workflow_config.json Step 9 (lines 155-169) only loads workflow outputs, NOT input concepts

---

## 4. Workflow Design Patterns

### 4.1 Positive Constraint Philosophy

The workflow embodies a "positive constraints" approach where rules define what CAN happen rather than prohibitions.

**Implementation:**
- NPE defines narrative physics as enabling rules
- World constraints create functional limits that force better plotting
- Character arcs constrain choices based on psychology, not arbitrary limits

**Evidence:** README.md line mentions "Positive Constraints" design principle

### 4.2 Character-Driven Causality

Plot emerges from character psychology + world constraints rather than external plot impositions.

**Implementation:**
- Character profiles define flaws, needs, wounds, worldviews
- Relationship architectures specify tension axes that drive conflict
- Outline prompt (step9_outline.md) requires "character-driven causality" (line 42)

**Evidence:** step9_outline.md lines 40-47 mandate character decisions drive turning points

### 4.3 Iterative Refinement

Workflow supports re-running individual steps without full restart.

**Implementation:**
- State tracking allows step re-execution
- Outputs overwrite cleanly
- Dependencies re-validate on each run

**Evidence:** ORCHESTRATOR_GUIDE mentions "Supports iteration" (implicit in state management)

### 4.4 Separation of Concept vs. Structure

Original concepts feed early steps, but final synthesis works only from refined structural outputs.

**Implementation:**
- Steps 1-8 use original concepts as inputs
- Step 9 (Outline) excludes `input/` files, uses only `outputs/`
- Prevents raw concepts from contaminating structured blueprint

**Evidence:** workflow_config.json Step 9 inputs (lines 161-168) contain NO input/ files

---

## 5. Recent Evolution & Refinement

### 5.1 Git History Analysis

**Recent Commits (last 20):**
- Multiple "simplify" operations on various output files
- Premise simplified by 31.68% (5,768 → 3,940 words)
- Relationship files simplified across both projects
- World constraints simplified

**Pattern:** Active refinement focus on reducing verbosity while preserving essential information.

**Evidence:**
- Commit 3cd53b1: "Simplify refined premise by 31.68%"
- Multiple commits for simplifying relationship files
- Dedicated `/simplify` slash command in commands directory

### 5.2 Workflow State Schema

**Current Schema Version:** 1.0.0

**Schema Structure:**
```json
{
  "workflow_version": "1.0.0",
  "project_name": "string",
  "current_step": "string (step number or null)",
  "last_updated": "ISO8601 timestamp",
  "steps": {
    "N": {
      "name": "Step Name",
      "status": "pending|in_progress|completed|failed",
      "started_at": "ISO8601",
      "completed_at": "ISO8601",
      "outputs_generated": ["file paths"]
    }
  }
}
```

**Strengths:**
- Clean separation of metadata and step tracking
- Timestamps enable performance analysis
- Status enum supports error states
- Output tracking enables verification

---

## 6. Identified Issues & Risks

### 6.1 Minor Issues

#### ⚠️ **Documentation Gap: Template Usage**
- Main vs. Secondary character templates exist
- Character concept file uses markers (`# MAIN CHARACTER:`, `# SECONDARY CHARACTER:`)
- **Gap:** Not clear if orchestrator or subagent selects template

**Evidence:** ORCHESTRATOR_GUIDE lines 776-848 describe parsing but note "subagent will auto-detect"

**Impact:** Low—system works, but orchestrator logic could be clearer

**Recommendation:** Clarify in documentation whether template selection is orchestrator's or agent's responsibility

#### ⚠️ **Inconsistent File Naming**
- Some outputs use underscores: `character_Cassia_Nightshade.md`
- Workflow state shows different pattern: `story_outline.md` vs `outline.md`

**Evidence:**
- workflow_state.json line 83 shows `story_outline.md`
- workflow_config.json line 171 defines output key as `outline` → `outputs/outline.md`

**Impact:** Low—minor inconsistency, doesn't break workflow

**Recommendation:** Standardize whether workflow_state records config keys or actual filenames

### 6.2 Potential Risks

#### 🔴 **Risk: Placeholder Injection Failure**
- **Severity:** HIGH
- **Likelihood:** Low (well-documented, validated)
- **Impact:** Subagents read files again, causing duplicate context usage

**Mitigation:**
- Extensive documentation in ORCHESTRATOR_GUIDE (lines 5-15, 329-374)
- Validation requirement: assert no `{{` or `}}` remain
- Clear examples of correct vs. incorrect implementation

**Current Status:** Well-mitigated through documentation and validation

#### 🟡 **Risk: State File Corruption**
- **Severity:** MEDIUM
- **Likelihood:** Low
- **Impact:** Workflow cannot resume, user must manually fix JSON

**Mitigation:**
- JSON schema is simple and well-structured
- No known corruption observed in git history

**Recommendation:** Consider adding state file validation on read, auto-backup before write

#### 🟡 **Risk: Dependency Validation Gaps**
- **Severity:** MEDIUM
- **Likelihood:** Low
- **Impact:** Step runs without required inputs, produces invalid output

**Mitigation:**
- ORCHESTRATOR_GUIDE mandates dependency checking (line 301-304)
- File existence validation before execution

**Current Status:** Documented but implementation verification not confirmed

---

## 7. Optimization Opportunities

### 7.1 Immediate Optimizations

#### 🚀 **Enable Steps 5-6 Parallel Execution**

**Current:** Sequential execution (30-minute gap observed)
**Proposed:** True parallel execution using single message with multiple Task calls

**Expected Gain:** 30-84 minutes (one step equivalent)

**Implementation:**
```python
# Load shared inputs (NPE, spine, themes, characters) once
# Inject placeholders for both Step 5 and Step 6 prompts
# Send single message with TWO Task calls:

Task(subagent_type="story-architect", prompt=step5_injected, ...)
Task(subagent_type="character-architect", prompt=step6_injected, ...)
```

**Evidence:** ORCHESTRATOR_GUIDE lines 643-771 detail parallel step execution strategy, but workflow_state suggests not currently implemented

**Effort:** Low—already designed and documented, just needs execution

---

### 7.2 Future Enhancements

#### 💡 **Add Workflow Analytics Dashboard**

**Purpose:** Visualize performance metrics across projects and iterations

**Metrics to Track:**
- Step execution times (min, max, avg)
- Output file sizes over time
- Simplification ratios
- Error rates by step

**Implementation:**
- Parse workflow_state.json across all projects
- Generate markdown report with tables
- Track trends over multiple runs

**Value:** Identify performance regressions, validate optimizations

---

#### 💡 **Implement Checkpointing for Long Steps**

**Current Risk:** Step 4 (90 min) or Step 9 (60 min) failures require full restart

**Proposed:**
- For parallel steps (4, 7): save outputs as each agent completes
- Update workflow_state with partial completion tracking
- Allow restart from last completed character/relationship

**Value:** Reduced rework time on failures

---

#### 💡 **Add Output Validation Hooks**

**Purpose:** Catch structural issues before advancing to next step

**Implementation:**
- Define validation schemas for each output type
- Check character profiles have all required sections
- Verify NPE has all 9 domains
- Validate relationship architectures include tension axes

**Value:** Early error detection, higher quality outputs

---

### 7.3 Documentation Enhancements

#### 📝 **Add Troubleshooting Guide for Common Failures**

**Sections to Include:**
- "Step X failed: What to check"
- "How to manually fix workflow_state.json"
- "Understanding placeholder injection errors"
- "Recovering from interrupted parallel execution"

**Location:** Create `TROUBLESHOOTING.md` in root

---

#### 📝 **Create Performance Benchmarks Document**

**Purpose:** Set expectations for execution times

**Content:**
- Reference execution times per step
- Expected output sizes
- Parallel vs. sequential timing comparisons
- Resource usage estimates (context tokens, etc.)

**Location:** Create `BENCHMARKS.md` in root

---

## 8. Comparative Analysis: v1 vs. v2 Projects

### Project Comparison

| Metric | dragon-mafia-v1 | dragon-mafia-v2 | Delta |
|--------|-----------------|-----------------|-------|
| Completion | Step 8/11 (72.7%) | Step 9/11 (81.8%) | +9.1% |
| NPE Size | Not measured | 528 lines | - |
| Character Count | Not measured | 7 profiles | - |
| Relationship Count | Not measured | 6 architectures | - |
| Premise (refined) | Not measured | 56 lines (3,940 words) | - |
| Outline | Not generated | 93KB | - |

**Observation:** v2 is more advanced and demonstrates full workflow capability through Step 9.

**Git Activity:** Both projects show heavy simplification work (multiple commits for relationship and world constraint files).

---

## 9. Workflow Maturity Assessment

### Maturity Model Evaluation

| Dimension | Level | Evidence |
|-----------|-------|----------|
| **Architecture** | ✅ **Production** | Modular agents, clear separation of concerns, well-documented |
| **State Management** | ✅ **Production** | Robust JSON tracking, timestamps, cross-chat resumption |
| **Documentation** | ✅ **Production** | Comprehensive ORCHESTRATOR_GUIDE, README, inline examples |
| **Error Handling** | 🟡 **Mature** | Documented patterns, validation requirements, but no automated recovery |
| **Testing** | 🟡 **Developing** | Real-world usage (2 projects), but no automated test suite |
| **Optimization** | 🟡 **Mature** | Parallelization designed, but not fully utilized (Steps 5-6) |
| **Monitoring** | 🔴 **Initial** | Timestamps collected, but no analytics or performance tracking |

**Overall Maturity:** **Production-Ready with Growth Opportunities**

---

## 10. Recommendations

### Priority 1: Critical (Immediate Action)

1. **✅ Complete Steps 10-11 for dragon-mafia-v2**
   - Execute NPE Inspection (Step 10)
   - Execute Outline Rewrite (Step 11)
   - Validate full end-to-end workflow completion

2. **🚀 Implement Steps 5-6 Parallel Execution**
   - Modify orchestrator to spawn both steps in single message
   - Validate time savings vs. sequential execution
   - Document actual performance gain

### Priority 2: Important (Next Sprint)

3. **📊 Create Performance Benchmarks Document**
   - Record reference execution times from dragon-mafia-v2
   - Establish baseline for future optimization validation

4. **🔍 Add State File Validation**
   - Implement JSON schema validation on state file read
   - Auto-backup state before write operations
   - Add error recovery suggestions

5. **📝 Expand Troubleshooting Documentation**
   - Document common failure modes
   - Provide step-by-step recovery procedures

### Priority 3: Enhancement (Future)

6. **💡 Implement Workflow Analytics Dashboard**
   - Parse all project workflow_state.json files
   - Generate performance trend reports

7. **💡 Add Output Validation Hooks**
   - Define schemas for each output type
   - Implement pre-step-advancement validation

8. **🧪 Create Automated Test Suite**
   - Test placeholder injection logic
   - Validate dependency checking
   - Test parallel execution coordination

---

## 11. Conclusion

The Narrative Engine workflow represents a **sophisticated, production-ready system** for AI-assisted creative writing. Its strengths lie in:

- **Modular architecture** with specialized agents
- **Robust state management** enabling cross-chat resumption
- **Parallelization support** for significant performance gains
- **Comprehensive documentation** guiding orchestrator implementation
- **Quality control loops** ensuring NPE compliance

The workflow has demonstrated effectiveness through two active projects and has evolved iteratively (evidenced by simplification commits).

**Key opportunities:**
1. Fully utilize parallel execution for Steps 5-6 (30-84 min savings)
2. Add monitoring and analytics for continuous improvement
3. Enhance error recovery and validation mechanisms

**Current Status:** Ready to complete Steps 10-11 for full workflow validation. Recommended to execute these steps and document completion metrics before implementing optimization enhancements.

---

## Appendix A: File Structure Inventory

### Root Directory
- `README.md` - User-facing documentation
- `claude.md` - Claude Code orchestration guide reference
- `workflow_config.json` - Step definitions (11 steps)
- `workflow_state_schema.json` - State file schema

### .claude/ Directory
- `ORCHESTRATOR_GUIDE.md` - Technical execution guide (1,255 lines)
- `agents/` - 8 specialized agent definitions
  - `AGENTS.md` - Agent system documentation
  - `npe-extractor.md`
  - `story-architect.md`
  - `character-architect.md`
  - `scene-designer.md`
  - (4 additional agents)
- `commands/` - Slash commands
  - `create-project.md`
  - `simplify.md`

### prompts/ Directory
- `step1_npe_extraction.md` through `step11_outline_rewrite.md`
- 11 prompt templates with `{{PLACEHOLDER}}` tokens

### templates/ Directory
- `npe_template` - Base NPE structure
- `main_character_template_v1.1.md` - 8-section comprehensive template
- `secondary_character_template_v1.0.md` - 6-section streamlined template

### projects/ Directory
- `default/` - Template project with README
- `dragon-mafia-paranormal-v1/` - 72.7% complete (Step 8/11)
- `dragon-mafia-paranormal-v2/` - 81.8% complete (Step 9/11)
  - `input/` - 4 concept files (269KB total)
  - `outputs/` - 15+ generated files
  - `workflow_state.json` - Execution tracking

---

## Appendix B: Workflow Execution Command Reference

### Create New Project
```bash
/create-project [project-name]
```
Creates `projects/[project-name]/` with input/ and outputs/ directories, initializes workflow_state.json.

### Run Individual Step
```
Run step [N] for [project-name]
```
Executes specific workflow step with dependency validation.

### Continue Workflow
```
Continue the workflow for [project-name]
```
Reads workflow_state.json and executes next pending step.

### Run Full Workflow
```
Run the book design workflow for [project-name]
```
Executes all 11 steps sequentially (or with parallelization where applicable).

### Simplify Output
```
/simplify [file-path]
```
Reduces word count by 15%+ while preserving essential information.

---

**End of Analysis**
