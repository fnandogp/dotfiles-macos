---
description: Daily planning briefing - tasks, deadlines, activity, and time tracking from Productive.io.
---

# Task: Daily Plan

Generate my daily plan for today using the `productive` MCP tool.

## Configuration

- **Timezone:** Australia/Melbourne (AEST/AEDT)
- **Week range:** Sunday to Saturday

## Data to fetch

1. Get me via `productive(resource="people", action="me")`
2. **My open tasks** - assigned to me, status open
3. **Overdue tasks** - due before today
4. **Tasks due today**
5. **Tasks due this week** - next 7 days
6. **Recent activity** - last 24h on my tasks/projects
7. **Time entries** - current week
8. **Active projects** - I am assigned to

## Output format

### Overdue (action required)
Tasks with project name, title, due date. If none: "None - you're on track."

### Due Today
Tasks with project and title.

### Due This Week
Tasks grouped by day.

### Other Open Tasks
Remaining open tasks with no upcoming due date, grouped by project.

### Recent Activity (last 24h)
Brief summary of updates, comments, status changes.

### Time Tracking - This Week
Total hours logged. Breakdown by project/day if available.

### Suggested Focus
Top 3 priorities: overdue first, then today's deadlines, then high-activity items.

## Additional context
$ARGUMENTS
