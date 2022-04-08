local g = vim.g

g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"
--g.dashboard_custom_header = {
--" ███████╗███╗   ██╗ █████╗ ███╗   ██╗██████╗  ██████╗  ██████╗ ██████╗  ",
--" ██╔════╝████╗  ██║██╔══██╗████╗  ██║██╔══██╗██╔═══██╗██╔════╝ ██╔══██  ",
--" █████╗  ██╔██╗ ██║███████║██╔██╗ ██║██║  ██║██║   ██║██║  ███╗██████╔╝ ",
--" ██╔══╝  ██║╚██╗██║██╔══██║██║╚██╗██║██║  ██║██║   ██║██║   ██║██╔═══╝  ",
--" ██║     ██║ ╚████║██║  ██║██║ ╚████║██████╔╝╚██████╔╝╚██████╔╝██║      ",
--" ╚═╝     ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚═════╝ ╚═╝      ",
--}

g.dashboard_custom_header = {
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

g.dashboard_custom_section = {
  a = { description = { "" }, command = "" },
}

--g.dashboard_custom_section = {
--a = { description = { "  Find File                 <leader> f f" }, command = "Telescope find_files" },
--b = { description = { "  Recents                   <leader> f o" }, command = "Telescope oldfiles" },
--c = { description = { "  Find Word                 <leader> f w" }, command = "Telescope live_grep" },
--d = { description = { "  New File                  <leader> f n" }, command = "DashboardNewFile" },
--f = { description = { "  Load Last Session         <leader> l  " }, command = "SessionLoad" },
--}

g.dashboard_custom_footer = {
  "   ",
}
