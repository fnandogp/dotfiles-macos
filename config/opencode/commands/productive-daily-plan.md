---
description: Daily planning briefing - shows your tasks, deadlines, activity, and time tracking from Productive.io.
---

# Task: Daily Plan

Generate my daily plan for today. Use the `productive` MCP tool to gather the following data about ME (the authenticated user).

## Data to fetch

1. **My open tasks** - all tasks assigned to me with status open
2. **Overdue tasks** - my tasks where due date is before today
3. **Tasks due today** - my tasks due today
4. **Tasks due this week** - my tasks due within the next 7 days
5. **Recent activity** - activity on my tasks/projects in the last 24 hours
6. **Time entries** - my time entries for the current week
7. **Active projects** - projects I am assigned to

## Output format

Structure the output exactly as follows:

### Overdue (action required)
List overdue tasks with project name, task title, due date, and link. If none, say "None - you're on track."

### Due Today
Tasks due today with project and title.

### Due This Week
Tasks due in the next 7 days, grouped by day.

### Other Open Tasks
Remaining open tasks with no upcoming due date, grouped by project.

### Recent Activity (last 24h)
Brief summary of updates, comments, status changes on your tasks.

### Time Tracking - This Week
Total hours logged this week. Breakdown by project/day if available.

### Suggested Focus
Based on the above, suggest the top 3 things to focus on today. Prioritise overdue items first, then today's deadlines, then high-activity items.

## Additional context
$ARGUMENTS
