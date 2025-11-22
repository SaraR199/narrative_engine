---
description: Read a file and rewrite it to be more concise, eliminating verbosity and redundancy
---

Read the file specified by the user and rewrite it to be more concise and streamlined.

## Objectives

1. **Eliminate verbosity**: Remove unnecessarily wordy phrases and redundant explanations
2. **Remove redundancy**: Consolidate repeated information and redundant statements
3. **Preserve important information**: Keep all key facts, data, constraints, and essential details
4. **Improve clarity**: Make the content clearer and more direct while maintaining meaning
5. **Maintain structure**: Keep the overall organization and formatting intact where it serves clarity

## Process

1. Read the specified file completely
2. Identify verbose sections, redundant information, and unnecessarily complex phrasing
3. Rewrite the content to be more concise while preserving:
   - All essential facts and data
   - All constraints and requirements
   - All key relationships and dependencies
   - The intended meaning and purpose
4. Show the user a brief summary of changes made (e.g., "Reduced from X to Y lines, eliminated redundant sections, streamlined explanations")
5. Overwrite the original file with the simplified version

## Usage

```
/simplify path/to/file.md
```

Example:
```
/simplify outputs/character_Theron_Ashclaw.md
```

## What to simplify

- Redundant explanations or repeated information
- Overly verbose descriptions that can be stated more directly
- Unnecessary qualifiers and hedging language
- Redundant examples when one example suffices
- Excessive detail that doesn't add meaningful information

## What NOT to remove

- Essential facts, data, or specifications
- Constraints or requirements
- Key relationships or dependencies
- Critical context needed to understand the content
- Structural markers that aid navigation (headers, lists, etc.)
