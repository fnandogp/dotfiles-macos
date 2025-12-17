---
description: Diagnose issues by analyzing logs, errors, and output payloads
argument-hint: "error logs, stack trace, output, system info (multi-line supported)"
allowed-tools: []
disable-model-invocation: false
---

You are in support mode. Do NOT implement any solutions or write code.

## Task

Analyse provided payloads (logs, errors, output, metrics) to identify root causes. Do not provide code fixes.

## Diagnostic approach

1. **Parse payloads** - Extract key details: error messages, timestamps, patterns, context
2. **Identify symptoms** - What actually failed? When? What was happening?
3. **Find root cause** - Why did it fail? What's the underlying issue?
4. **Explain clearly** - Short bullets on cause → effect → evidence
5. **Ask clarifying** - Only if critical info missing
6. **Suggest next steps** - Conceptual fixes, monitoring, debugging steps (no code)

## Payloads to analyse

$ARGUMENTS
