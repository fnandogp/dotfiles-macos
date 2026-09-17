// tmux-agent-indicator plugin for OpenCode V2.
// Auto-discovered from ~/.config/opencode/plugins/.
// Tracks session state and calls agent-state.sh to update tmux pane visuals.

import { execFile } from "node:child_process"
import { promisify } from "node:util"

const run = promisify(execFile)

export default {
  id: "tmux-agent-indicator",
  setup(ctx) {
    const dir = process.env.TMUX_AGENT_INDICATOR_DIR
      || `${process.env.HOME}/.config/tmux/plugins/tmux-agent-indicator`
    const script = `${dir}/scripts/agent-state.sh`

    let lastState = "off"
    let idleAt = 0

    const setState = async (state) => {
      if (state === lastState) return
      lastState = state
      try {
        if (state === "running") {
          await run("bash", [script, "--agent", "opencode", "--state", "off"])
        }
        await run("bash", [script, "--agent", "opencode", "--state", state])
      } catch {
        // non-fatal: tmux may not be available
      }
    }

    const controller = new AbortController()

    void (async () => {
      for await (const event of ctx.event.subscribe({ signal: controller.signal })) {
        const properties = event.properties ?? {}

        if (event.type === "session.status") {
          const type = properties.status?.type ?? properties.type
          if (type === "busy") {
            // Guard: don't override done/error if idle fired recently (race condition)
            if (Date.now() - idleAt < 2000) continue
            await setState("running")
          }
        }

        if (event.type === "permission.updated") {
          await setState("needs-input")
        }

        if (event.type === "session.idle" || event.type === "session.error") {
          idleAt = Date.now()
          await setState("done")
        }
      }
    })()

    void (async () => {
      await ctx.tool.hook("execute.before", async (event) => {
        if (event.tool === "question") {
          await setState("needs-input")
        }
      })
    })()

    return () => controller.abort()
  },
}
