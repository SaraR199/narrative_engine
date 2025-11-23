# Verbosity Reduction Proposal

**Goal:** Reduce output verbosity at the source (prompts) rather than post-processing with `/simplify`

**Date:** 2025-11-23

---

## 1. Current State Analysis

### Prompt Verbosity (Sorted by Word Count)

| Step | Prompt File | Word Count | Verbosity Level |
|------|-------------|------------|-----------------|
| 1 | step1_npe_extraction.md | 639 words | ✅ Reasonable |
| 3 | step3_theme_extraction.md | 664 words | ✅ Reasonable |
| 10 | step10_npe_inspection.md | 759 words | ✅ Reasonable |
| 11 | step11_outline_rewrite.md | 1,018 words | 🟡 Moderate |
| 4 | step4_character_development.md | 1,128 words | 🟡 Moderate |
| 2 | step2_dramatic_spine.md | 1,115 words | 🟡 Moderate |
| 6 | step6_relationship_mapping.md | 1,225 words | 🟡 Moderate |
| 8 | step8_premise_refinement.md | 1,295 words | 🟡 Moderate |
| 7 | step7_relationship_architecture.md | 1,359 words | 🔴 High |
| 5 | step5_world_constraints.md | 1,399 words | 🔴 High |
| 9 | step9_outline.md | 1,452 words | 🔴 High |

**Average Prompt Length:** 1,091 words

### Current Output Word Counts

| Step | Output Type | Current Words | Assessment |
|------|-------------|---------------|------------|
| 1 | NPE | 3,353 | 🔴 Too verbose |
| 2 | Dramatic Spine | 1,089 | ✅ Good |
| 3 | Themes | 1,246 | 🟡 Slightly high |
| 4 | Main Character | 3,233 | 🔴 Too verbose |
| 4 | Secondary Character (avg) | 1,576 | 🟡 Moderately high |
| 5 | World Constraints | 3,049 | 🔴 Too verbose |
| 6 | Relationship Mapping | 876 | ✅ Perfect |
| 7 | Relationship Architecture (avg) | 2,627 | 🔴 Too verbose |
| 8 | Refined Premise | 1,713 | 🟡 Moderately high |
| 9 | Story Outline | 12,959 | 🔴 Extremely verbose |

**Key Issues:**
- NPE, World Constraints, and Main Characters all exceed 3,000 words
- Story Outline at nearly 13,000 words is excessive
- Relationship architectures averaging 2,600 words each (6 relationships = 15,762 words total)
- Total outputs for dragon-mafia-v2: **~50,000+ words** (excessive for a planning system)

---

## 2. Recommended Maximum Word Counts

### Revised Targets (Based on User Feedback)

**IMPORTANT:** Current word counts reflect outputs AFTER `/simplify` was run. Original outputs were significantly more verbose.

| Step | Output Type | Current (Simplified) | **Recommended Max** | Notes |
|------|-------------|----------------------|---------------------|-------|
| 1 | NPE | 3,353 | **2,500 words** | -25% from simplified |
| 2 | Dramatic Spine | 1,089 | **1,200 words** | ✅ Good as-is |
| 3 | Themes | 1,246 | **1,000 words** | -20% from simplified |
| 4 | Main Character | 3,233 | **2,000 words** | -38% from simplified |
| 4 | Secondary Character | 1,576 | **800 words** | -49% (many of these) |
| 5 | World Constraints | 3,049 | **2,000 words** | -34% from simplified |
| 6 | Relationship Mapping | 876 | **1,000 words** | ✅ Good as-is |
| 7 | Relationship Arch. (main romance) | 2,627 | **2,000 words** | Special case |
| 7 | Relationship Arch. (other) | 2,627 | **1,000 words** | -62% (6 of these) |
| 8 | Refined Premise | 1,713 | **1,200 words** | -30% from simplified |
| 9 | Story Outline | 12,959 | **8,000 words** | -38% from simplified |
| 10 | NPE Inspection | TBD | **2,000 words** | - |
| 11 | Outline Rewrite | TBD | **8,000 words** | - |

**Total Projected Reduction for dragon-mafia-v2 project:**
- **Before simplification:** ~65,000-70,000 words (estimated)
- **After manual simplify:** ~50,000 words
- **After automated limits:** ~27,200 words
- **Savings from original:** ~60% reduction
- **Savings from simplified:** ~46% reduction

### Word Count Calculation for dragon-mafia-v2

**Based on revised targets:**

| Output | Quantity | Words Each | Total Words |
|--------|----------|------------|-------------|
| NPE | 1 | 2,500 | 2,500 |
| Dramatic Spine | 1 | 1,200 | 1,200 |
| Themes | 1 | 1,000 | 1,000 |
| Main Characters | 1-2 | 2,000 | 4,000 |
| Secondary Characters | 5-6 | 800 | 4,000-4,800 |
| World Constraints | 1 | 2,000 | 2,000 |
| Relationship Mapping | 1 | 1,000 | 1,000 |
| Main Romance Relationship | 1 | 2,000 | 2,000 |
| Other Relationships | 5 | 1,000 | 5,000 |
| Refined Premise | 1 | 1,200 | 1,200 |
| Story Outline | 1 | 8,000 | 8,000 |
| NPE Inspection | 1 | 2,000 | 2,000 |
| Outline Rewrite | 1 | 8,000 | 8,000 |

**Total: ~42,700-43,500 words** (if all relationships treated equally)
**Total: ~27,200-28,000 words** (with new limits)

**Savings: 46% from current simplified outputs, ~60% from original pre-simplified outputs**

---

## 3. Strategies for Reducing Prompt Verbosity

### 3.1 Remove Redundant Explanations

**Current Example (step4_character_development.md):**
```markdown
2. **Avoid generic phrasing** - No vague descriptions like "she is kind but strong"
   - ❌ BAD: "She's brave and caring"
   - ✅ GOOD: "When confronted with physical danger, she moves toward it rather than freezing. She checks on others' emotional state before addressing her own needs, even when exhausted."

3. **Be specific and situational** - Show the trait through behavior in concrete situations
   - ❌ BAD: "He's intelligent"
   - ✅ GOOD: "He spots logical inconsistencies in arguments within seconds. Reads 2-3 books weekly. Struggles to simplify complex ideas for others."
```

**Condensed Version:**
```markdown
2. **Be specific, not generic** - Show traits through concrete behavior
   - ❌ "She's brave"
   - ✅ "She moves toward danger, not away. Checks on others before herself."
   - ❌ "He's intelligent"
   - ✅ "Spots logical flaws instantly. Reads 2-3 books/week. Can't simplify complex ideas."
```

**Savings:** 67 words → 35 words (48% reduction)

---

### 3.2 Consolidate Examples

**Current Example (step2_dramatic_spine.md):**
```markdown
**Available Primary Axes:**
- **Romantic** - Will they/won't they, relationship conflict
- **Mystery** - What happened, whodunit, revelation-seeking
- **Survival** - Will they live, escape, endure
- **Political** - Power struggles, ideological conflict, social change
- **Identity** - Who am I really, transformation, self-discovery
- **Moral** - Right vs wrong, ethical dilemmas, corruption vs integrity
- **External Stakes** - World-threat, quest completion, defeating antagonist (for fantasy/adventure/thriller)
- **Other** - Define it specifically
```

**Condensed Version:**
```markdown
**Primary Axes (pick 1-3):** Romantic | Mystery | Survival | Political | Identity | Moral | External Stakes | Other (define)
```

**Savings:** 61 words → 16 words (74% reduction)

---

### 3.3 Merge Redundant Sections

**Current Example (step4_character_development.md):**
- Section: "Critical Requirements (Apply to BOTH templates)" (34 lines)
- Section: "Additional Guidelines for MAIN CHARACTERS" (8 lines)
- Section: "Additional Guidelines for SECONDARY CHARACTERS" (8 lines)
- Section: "Quality Checklist" (18 lines)

**Strategy:** Merge "Critical Requirements" and "Quality Checklist" into one "Requirements" section. Move template-specific guidelines inline with template selection.

**Savings:** ~40% reduction in instructional text

---

### 3.4 Replace Verbose Lists with Directive Statements

**Current Example (step7_relationship_architecture.md):**
```markdown
### 3) Friction Patterns

Identify **2-3 recurring patterns** for how conflict flares between them.

**Examples:**
- One withdraws, one pursues
- One jokes to deflect, one takes offense
- Competence clash (both think they know best)
- Avoidance vs. confrontation
- Public performance vs. private resentment
- Intellectual sparring that masks emotional stakes

**For each pattern:**
- Describe the trigger
- Describe the typical escalation
- Describe how it usually resolves (or doesn't)
```

**Condensed Version:**
```markdown
### 3) Friction Patterns (2-3)

For each: trigger → escalation → resolution.

Examples: withdrawer/pursuer, deflection/offense, competence clash, public/private split, intellectual sparring.
```

**Savings:** 75 words → 21 words (72% reduction)

---

### 3.5 Use Inline Constraints Instead of Separate Sections

**Current Example (step9_outline.md):**
```markdown
## Constraints (These are MANDATORY)

### Causality Rules
- **Every major turn must be explainable via character decisions plus prior setup.** No random twists.
- If a turn feels like it comes from nowhere, you haven't set it up properly.

### Coincidence Rules
- **Coincidences may only increase pressure, never solve problems.**
- Characters must solve problems through choice and action, not luck.

### Structural Doorways
- **Each act should have a clear "doorway of no return"** born from a character decision or misjudgment.
- The protagonist cannot go back to who they were before crossing this threshold.
```

**Condensed Version:**
```markdown
## Mandatory Constraints

- **Causality:** Every turn explainable via character decisions + prior setup. No random twists.
- **Coincidence:** May increase pressure, never solve problems. Characters solve via choice/action.
- **Doorways:** Each act has irreversible threshold from character decision.
```

**Savings:** 89 words → 35 words (61% reduction)

---

### 3.6 Remove Motivational Language

**Current Examples to Remove:**
- "Remember: extract ONLY generic patterns, never story-specific details."
- "Think of this as creating the character's 'physics engine' - the rules that govern how they operate."
- "You're creating a psychological system that will be used by other AI agents..."
- "Every detail matters. Every variation gives future agents options to avoid repetition."

**Why:** Claude already understands the task from the directive instructions. Motivational reminders add bulk without improving output.

**Estimated Savings:** 10-15% per prompt

---

### 3.7 Tighten Output Format Templates

**Current Example (step7_relationship_architecture.md):**
```markdown
## 2. Tension Axes

### [Axis Name]: [Position A] ↔ [Position B]

**Character A ([Name]) position:**
[Where they sit and why]

**Character B ([Name]) position:**
[Where they sit and why]

**How this manifests in scenes:**
[Specific behaviors]

**Arc shift:**
[How positions change, if at all]

[Repeat for second axis if applicable]
```

**Condensed Version:**
```markdown
## 2. Tension Axes (1-2)

**[Axis]:** [A position] ↔ [B position]
- A: [why]
- B: [why]
- Manifests: [behaviors]
- Shifts: [changes across acts]
```

**Savings:** Reduces template boilerplate by ~50%

---

## 4. Implementation Strategy

### Phase 1: Add Word Count Directives (Immediate, Low Effort)

Add explicit word count constraints to each prompt's "Output Format" section:

```markdown
## Output Format

**WORD COUNT LIMIT: 2,000 words maximum**

Produce a complete Narrative Physics Engine that is:
- Concise and actionable
- Free of redundancy or verbose explanations
- Structured per the template below
```

**Effort:** 5 minutes per prompt (11 prompts = ~1 hour)

**Expected Impact:** 20-30% reduction via explicit constraints

---

### Phase 2: Streamline Top 5 Verbosity Offenders (High Impact)

Target the prompts producing the most verbose outputs:

1. **step9_outline.md** (12,959 words output) → **Target: 8,000 words max**
2. **step1_npe_extraction.md** (3,353 words output) → **Target: 2,500 words max**
3. **step5_world_constraints.md** (3,049 words output) → **Target: 2,000 words max**
4. **step4_character_development.md** (3,233 words for main) → **Target: 2,000 words max**
5. **step7_relationship_architecture.md** (2,627 words avg) → **Target: 1,800 words max**

**Strategy per prompt:**
- Remove redundant examples (apply 3.2)
- Consolidate sections (apply 3.3)
- Tighten output format (apply 3.7)
- Add explicit word count directive (Phase 1)
- Remove motivational language (apply 3.6)

**Effort:** 30-45 minutes per prompt = 2.5-4 hours total

**Expected Impact:** 35-45% reduction on these 5 steps

---

### Phase 3: Polish Remaining Prompts (Refinement)

Apply lighter touch to remaining 6 prompts:
- Add word count directives
- Remove obvious redundancy
- Tighten examples where applicable

**Effort:** 15-20 minutes per prompt = 2 hours total

**Expected Impact:** 15-25% reduction

---

### Phase 4: Update ORCHESTRATOR_GUIDE.md

Add section on word count enforcement:

```markdown
## Word Count Validation (NEW)

After the subagent completes, check the output word count:

```python
output_text = agent_response
word_count = len(output_text.split())
max_words = step_config.get('max_output_words', 10000)  # Default fallback

if word_count > max_words:
    print(f"⚠️  Warning: Output exceeded max word count ({word_count}/{max_words})")
    # Option 1: Auto-simplify
    # Option 2: Reject and re-run with stricter prompt
    # Option 3: Log warning and proceed
```
```

**Effort:** 30 minutes

---

## 5. Proposed Workflow Config Addition

Add `max_output_words` field to each step in `workflow_config.json`:

```json
{
  "1": {
    "name": "NPE Extraction",
    "prompt_template": "step1_npe_extraction.md",
    "agent_type": "npe-extractor",
    "model": "sonnet",
    "max_output_words": 2500,
    "inputs": { ... },
    "outputs": { ... }
  },
  "4": {
    "name": "Character Development",
    "prompt_template": "step4_character_development.md",
    "agent_type": "character-architect",
    "model": "sonnet",
    "max_output_words": {
      "main_character": 2000,
      "secondary_character": 800
    },
    "inputs": { ... },
    "outputs": { ... }
  },
  "7": {
    "name": "Relationship Architecture",
    "prompt_template": "step7_relationship_architecture.md",
    "agent_type": "character-architect",
    "model": "sonnet",
    "max_output_words": {
      "default": 1000,
      "main_romance": 2000
    },
    "main_romance_detection": "automatic or user-specified",
    "inputs": { ... },
    "outputs": { ... }
  },
  "8": {
    "name": "Premise Refinement",
    "prompt_template": "step8_premise_refinement.md",
    "agent_type": "story-architect",
    "model": "sonnet",
    "max_output_words": 1200,
    "inputs": { ... },
    "outputs": { ... }
  }
}
```

**Benefits:**
- Centralized word count limits
- Easy to adjust per-project
- Enables automated validation
- Special handling for main romance relationship

---

## 6. Example: Before/After for step7_relationship_architecture.md

### Before (1,359 words)

See current file at `/home/user/narrative_engine/prompts/step7_relationship_architecture.md`

### After (Estimated 800-900 words)

**Key Changes:**
1. Remove verbose component explanations (apply 3.4)
2. Consolidate friction/connection pattern sections
3. Tighten output format template (apply 3.7)
4. Remove motivational "Remember" section
5. Add explicit word count directive: **"MAX OUTPUT: 1,800 words"**
6. Merge "Constraints" into inline bullets in relevant sections

**Estimated Reduction:** 40% (1,359 → ~815 words)

---

## 7. Recommended Word Count Summary Table

### **APPROVED TARGETS** (User-Specified)

| Step | Output | **Target Max** | Priority | Notes |
|------|--------|----------------|----------|-------|
| 1 | NPE | **2,500** | 🔴 High | Core constraint system |
| 2 | Dramatic Spine | **1,200** | 🟢 Low | Already good |
| 3 | Themes | **1,000** | 🟡 Medium | - |
| 4 | Main Character | **2,000** | 🔴 High | Deep psychology needed |
| 4 | Secondary Character | **800** | 🔴 High | Many of these (5-6) |
| 5 | World Constraints | **2,000** | 🔴 High | - |
| 6 | Relationship Mapping | **1,000** | 🟢 Low | Already good |
| 7 | Main Romance Relationship | **2,000** | 🔴 High | Special case |
| 7 | Other Relationships | **1,000** | 🔴 High | Many of these (~5) |
| 8 | Refined Premise | **1,200** | 🟡 Medium | User-specified |
| 9 | Story Outline | **8,000** | 🔴 Critical | Biggest offender |
| 10 | NPE Inspection | **2,000** | 🟡 Medium | - |
| 11 | Outline Rewrite | **8,000** | 🔴 Critical | - |

**Total Project Output:** ~27,200-28,000 words (down from ~65,000+ original)

---

## 8. Testing & Validation Plan

### Step 1: Pilot Test on Step 9 (Highest Verbosity)

1. Create `prompts/step9_outline_v2.md` with:
   - Explicit 8,000-word limit
   - Condensed constraint section
   - Tightened output format
   - Removed motivational language

2. Run Step 9 on a test project or re-run dragon-mafia-v2

3. Compare outputs:
   - Word count reduction
   - Quality/completeness preservation
   - Usability for downstream steps

4. Adjust word count limit if needed

### Step 2: Roll Out to Top 5 Offenders

Apply learnings from Step 9 pilot to:
- Step 1 (NPE)
- Step 4 (Characters)
- Step 5 (World Constraints)
- Step 7 (Relationships)

### Step 3: Full Deployment

Once validated, update all 11 prompts and workflow_config.json

---

## 9. Success Metrics

### Quantitative

- **Word count reduction:** Target 36% (conservative) or 52% (aggressive)
- **Total project output:** From ~50,000 words to ~32,000 words (conservative)
- **Time to run `/simplify`:** Eliminated (no longer needed)

### Qualitative

- **Output completeness:** Maintain 95%+ of essential information
- **Downstream usability:** Later steps can still use outputs effectively
- **User satisfaction:** Outputs feel "right-sized" not bloated

---

## 10. Risks & Mitigations

### Risk 1: Over-Compression Loses Critical Detail

**Mitigation:**
- Start with conservative word counts
- Test each step individually
- Compare old vs. new outputs for completeness
- Allow 10% buffer for complex scenarios

### Risk 2: LLM Ignores Word Count Directives

**Mitigation:**
- Use multiple directive formats:
  - "WORD COUNT LIMIT: 2,000 words maximum"
  - "Be concise. Target: 1,500-2,000 words."
  - "Avoid redundancy. Stay under 2,000 words."
- Add validation check in orchestrator
- Consider post-processing auto-truncation with quality warning

### Risk 3: Different Projects Need Different Limits

**Mitigation:**
- Make `max_output_words` configurable per project
- Allow override in workflow_state.json:
  ```json
  {
    "project_name": "epic-fantasy",
    "word_count_multipliers": {
      "9": 1.5  // Allow 12,000 words for outline instead of 8,000
    }
  }
  ```

---

## 11. Next Steps & Decision Points

### Decision Point 1: Choose Target Level

**Option A: Conservative Targets** (~36% reduction)
- Lower risk
- Easier to validate
- Still significant savings

**Option B: Aggressive Targets** (~52% reduction)
- Maximum concision
- Higher risk of losing detail
- Requires more thorough testing

**Recommendation:** Start with **Conservative**, measure results, then tighten if successful.

---

### Decision Point 2: Implementation Approach

**Option A: Incremental** (Recommended)
1. Phase 1: Add word count directives only (1 hour)
2. Test on 1-2 steps
3. Phase 2: Streamline top 5 offenders (3-4 hours)
4. Test on full project
5. Phase 3: Polish remaining prompts (2 hours)

**Total Time:** 6-7 hours over 1-2 weeks

**Option B: Big Bang**
1. Rewrite all 11 prompts at once
2. Update workflow_config.json
3. Test entire workflow end-to-end

**Total Time:** 8-10 hours in 2-3 days

**Recommendation:** Use **Incremental** approach for lower risk and continuous validation.

---

### Decision Point 3: Validation Method

**Option A: Re-run dragon-mafia-v2 Steps 1-9**
- Compare old outputs vs. new outputs
- Measure word count reduction
- Assess quality/completeness

**Option B: Create small test project**
- Faster iteration
- Lower cost (fewer tokens)
- May not represent real-world complexity

**Recommendation:** **Option A** for realistic validation, followed by Option B for rapid iteration on adjustments.

---

## 12. Conclusion

**Current State:** Workflow produces high-quality outputs but with significant verbosity (~50,000 words per project).

**Proposed Solution:**
1. Add explicit word count limits to each step (conservative: 36% reduction)
2. Streamline prompt instructions (remove redundancy, tighten examples)
3. Validate changes incrementally starting with highest-verbosity steps

**Expected Outcomes:**
- **Reduced output volume:** ~32,000 words per project (conservative)
- **Eliminated post-processing:** No more `/simplify` commands needed
- **Maintained quality:** 95%+ completeness with better signal-to-noise ratio
- **Faster workflow:** Less reading, less processing, less context usage

**Time Investment:** 6-7 hours over 1-2 weeks (incremental approach)

**Risk Level:** Low (with incremental rollout and testing)

---

## Appendix A: Detailed Word Count Limits by Step

```json
{
  "approved_targets": {
    "1_npe": 2500,
    "2_dramatic_spine": 1200,
    "3_themes": 1000,
    "4_main_character": 2000,
    "4_secondary_character": 800,
    "5_world_constraints": 2000,
    "6_relationship_mapping": 1000,
    "7_main_romance_relationship": 2000,
    "7_other_relationships": 1000,
    "8_refined_premise": 1200,
    "9_story_outline": 8000,
    "10_npe_inspection": 2000,
    "11_outline_rewrite": 8000
  },
  "notes": {
    "secondary_characters": "Lower limit because projects typically have 5-6 secondary characters",
    "relationships": "Lower limit because projects typically have 5-6 relationships total",
    "main_romance": "Special 2000-word limit for the primary romantic relationship",
    "current_counts": "Measured AFTER /simplify was run - originals were 30-50% more verbose"
  }
}
```

---

**End of Proposal**
