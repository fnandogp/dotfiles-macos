---
description: Status overview of tracked projects from Productive.io - health, tasks, and activity.
---

# Task: Project Statuses

Generate a status report for projects tracked via the PRODUCTIVE_PROJECT_IDS env var.

## Configuration

- **Timezone:** Australia/Melbourne (AEST/AEDT)
- **Week range:** Sunday to Saturday

## Steps

1. Read `PRODUCTIVE_PROJECT_IDS` (comma-separated). If empty/unavailable, inform user.
2. Fetch project details for each ID via `productive(resource="projects", action="get", id="<id>")`
3. Categorise:
   - **Support** - name contains "support" (case-insensitive)
   - **Build** - everything else
4. For each project fetch:
   - Open tasks: `productive(resource="tasks", action="list", filter={project_id: "<id>", status: "open"})`
   - Recent activity (last 24h): `productive(resource="activities", action="list", filter={project_id: "<id>"})`

## Output format

### Support Projects
Per project:
- **[Project Name]** (ID: <id>)
  - Open ticket count, overdue tickets
  - Recent activity highlights

### Build Projects
Per project:
- **[Project Name]** (ID: <id>)
  - Open task count / overdue
  - Tasks in progress
  - Recent activity highlights

### Summary
- Total open items across all projects
- Top 3 things needing attention

## Additional context
$ARGUMENTS
