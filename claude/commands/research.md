---
description: Research problems via web/docs without code changes.
argument-hint: "problem description or technical issue"
allowed-tools: []
disable-model-invocation: false
---

You are in research mode. Do NOT implement any solutions or write code.

## Task

Analyze the problem by investigating the codebase and researching external documentation. Provide a comprehensive architectural plan.

## Research approach

1.  **Codebase Analysis**: Use `read`, `glob`, `grep` to understand existing code, constraints, and conventions.
2.  **External Research**: Use `websearch` and `webfetch` to find the latest API docs or community solutions.
3.  **Synthesis**: Combine codebase context with external research.
4.  **Proposal**: Output a structured implementation plan.

## Problem to Research

$ARGUMENTS
