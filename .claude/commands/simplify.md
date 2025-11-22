---
description: Read a file and rewrite it to be more concise, eliminating verbosity and redundancy
---

Read the file specified by the user and rewrite it to be more concise and streamlined.

## Objectives

1. **Reduce word count by at least 15%**: The simplified version must contain at least 15% fewer words than the original
2. **Eliminate verbosity**: Remove unnecessarily wordy phrases and redundant explanations
3. **Remove redundancy**: Consolidate repeated information and redundant statements
4. **Preserve important information**: Keep all key facts, data, constraints, and essential details
5. **Improve clarity**: Make the content clearer and more direct while maintaining meaning
6. **Maintain structure**: Keep the overall organization and formatting intact where it serves clarity

## Process

1. Read the specified file completely
2. Count the total words in the original file
3. Identify verbose sections, redundant information, and unnecessarily complex phrasing
4. Rewrite the content to be more concise while preserving:
   - All essential facts and data
   - All constraints and requirements
   - All key relationships and dependencies
   - The intended meaning and purpose
5. Count the words in the simplified version
6. **Verify at least 15% reduction**: If the word count reduction is less than 15%, revise the content to be more concise until the target is met
7. Show the user a summary of changes including:
   - Original word count
   - New word count
   - Percentage reduction (must be at least 15%)
   - Brief description of changes made
8. Overwrite the original file with the simplified version

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
