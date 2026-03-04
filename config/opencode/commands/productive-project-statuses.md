---
description: Status overview of your tracked projects from Productive.io - health, tasks, and activity across support and build projects.
---

# Task: Project Statuses

Generate a status report for the projects tracked via the PRODUCTIVE_PROJECT_IDS environment variable.

Read the env var PRODUCTIVE_PROJECT_IDS. It contains a comma-separated list of Productive.io project IDs. If the env var is empty or unavailable, inform the user they need to set it.

Use the `productive` MCP tool for all data fetching.

## Steps

1. Parse the comma-separated project IDs from PRODUCTIVE_PROJECT_IDS
2. Fetch project details for each ID: `productive(resource="projects", action="get", id="<id>")`
3. Categorise each project:
   - **Support** - project name contains "support" (case-insensitive)
   - **Build** - everything else
4. For each project, fetch using batch operations where possible:
   - Project health: `productive(resource="summaries", action="project_health", project_id="<id>")`
   - Open tasks: `productive(resource="tasks", action="list", filter={project_id: "<id>", status: "open"})`
   - Recent activity (last 24h): `productive(resource="activities", action="list", filter={project_id: "<id>"})`

## Output format

### Support Projects
For each support project:
- **[Project Name]** (ID: <id>)
  - Health summary
  - Open ticket count
  - Overdue tickets
  - Recent activity highlights

### Build Projects
For each build project:
- **[Project Name]** (ID: <id>)
  - Health summary
  - Open task count / overdue
  - Tasks in progress
  - Recent activity highlights

### Summary
- Total open items across all projects
- Top 3 things needing attention

## Memory
After generating the report, save it using the memory MCP tool with the key `productive/project-statuses/YYYY-MM-DD` (use today's date).

## Additional context
$ARGUMENTS
