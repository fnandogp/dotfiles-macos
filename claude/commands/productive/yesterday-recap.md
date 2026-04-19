---
description: Yesterday's recap - accomplishments, time tracked, and activity across shared projects.
---

# Task: Yesterday's Recap

Generate a recap of yesterday's work across the team using the `productive` MCP tool.

## Configuration

- **Timezone:** Australia/Melbourne (AEST/AEDT)
- **Week range:** Sunday to Saturday

## Setup

1. Get me via `productive(resource="people", action="me")`
2. Fetch squad projects: `productive(resource="projects", action="list", filter={responsible_id: PRODUCTIVE_PM_ID, status: "1"})`
3. Extract project IDs
4. Calculate yesterday's date boundaries (ISO 8601)

## Data to fetch

### My data
1. **Tasks I closed yesterday** - `tasks` with `closed_after`/`closed_before` = yesterday, `assignee_id` = me
2. **My time entries yesterday** - `time` with `date` = yesterday, `person_id` = me
3. **My activity yesterday** - `activities` filtered to yesterday, `person_id` = me

### Team data
Using resolved project IDs:
4. **Project members** - `people` with `project_id` filter
5. **All tasks closed yesterday** - include assignee
6. **All time entries yesterday** - by project
7. **All activity yesterday** - include creator

## Output format

### My Yesterday
**Tasks Completed:** each with project name, title, time logged
**Time Logged:** total hours, breakdown by project/service
**Activity Summary:** comments, status changes, updates

### Team Yesterday
Group by teammate (skip self). Per person with activity:
- Tasks completed with project and title
- Time logged total
- Key activity highlights

Omit teammates with no activity.

### Project Highlights
Per project one-liner: X tasks closed, Y hours logged, notable updates

### Standup Talking Points
1. **What I did** - 2-3 bullets
2. **What the team did** - 2-3 bullets
3. **Blockers/flags** - stale, overdue, or unusual items

## Additional context
$ARGUMENTS
