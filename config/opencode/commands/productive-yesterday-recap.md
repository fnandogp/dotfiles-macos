---
description: Yesterday's recap - what you and your teammates accomplished, time tracked, and activity across shared projects.
---

# Task: Yesterday's Recap

Generate a recap of yesterday's work across the team. Use the `productive` MCP tool to gather data.

## Configuration

- **Timezone:** Australia/Melbourne (AEST/AEDT)
- **Week range:** Sunday to Saturday (first day of week: Sunday)

Use this timezone for all date calculations ("yesterday", date boundaries, etc).

## Setup

1. Get the authenticated user via `productive(resource="people", action="me")`
2. Fetch squad projects dynamically: `productive(resource="projects", action="list", filter={responsible_id: PRODUCTIVE_PM_ID, status: "1"})` - this returns all active projects managed by the squad's PM
3. Extract project IDs from the result
4. Calculate yesterday's date boundaries (start of day to end of day, ISO 8601)

## Data to fetch

Use batch operations where possible: `productive(resource="batch", action="run", operations=[...])`.

### My data

1. **Tasks I closed yesterday** - `tasks` with `closed_after`/`closed_before` set to yesterday, `assignee_id` = me
2. **My time entries yesterday** - `time` with `date` = yesterday, `person_id` = me
3. **My activity yesterday** - `activities` filtered to yesterday, `person_id` = me

### Team data

Using the dynamically resolved project IDs from step 2:

4. **Project members** - `people` with `project_id` filter to identify teammates
5. **All tasks closed yesterday** - `tasks` with `closed_after`/`closed_before` = yesterday, `project_id` filter, include assignee
6. **All time entries yesterday** - `time` with `date` = yesterday, `project_id` filter
7. **All activity yesterday** - `activities` with `after`/`before` = yesterday, `project_id` filter, include creator

## Output format

### My Yesterday

**Tasks Completed:**
- List each task I closed with project name, task title, and time logged against it

**Time Logged:** Total hours with breakdown by project/service

**Activity Summary:** Brief list of comments, status changes, updates I made

---

### Team Yesterday

Group by teammate (skip yourself). For each person who had activity:

**[Person Name]**
- Tasks completed: list with project and title
- Time logged: total hours
- Key activity: notable comments, status changes, or updates

If a teammate had no activity yesterday, omit them.

---

### Project Highlights

For each tracked project, one-liner summary:
- **[Project Name]**: X tasks closed, Y hours logged, notable updates

### Standup Talking Points

Based on the above, suggest:
1. **What I did** - 2-3 bullet summary of my work
2. **What the team did** - 2-3 bullets on notable team progress
3. **Blockers/flags** - anything stale, overdue, or unusual (e.g. zero activity on an active project)

## Memory

After generating the report, save it using the memory MCP tool with the key `productive/yesterday-recap/YYYY-MM-DD` (use yesterday's date).

## Additional context
$ARGUMENTS
