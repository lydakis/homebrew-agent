cask "agent" do
  version "0.2.0"
  sha256 "6fdfb5199e82edbca3632399586b3b1998011d6261fd03f053e81d789e605418"

  url "https://github.com/lydakis/agent/releases/download/v#{version}/Agent_#{version}_universal.zip"
  name "Agent"
  desc "Desktop client for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Agent.app"
  binary "#{appdir}/Agent.app/Contents/MacOS/agent"

  # What the app writes at every start (its scripts, triggers and the skill
  # links in your .agents/skills) is there before its first window. Before it
  # goes, only its skill links are removed, so none is left leading nowhere.
  postflight do
    system_command "#{appdir}/Agent.app/Contents/MacOS/agent-app",
                   args:         ["--setup"],
                   must_succeed: false
  end

  uninstall_preflight do
    system_command "#{appdir}/Agent.app/Contents/MacOS/agent-app",
                   args:         ["--unlink-skills"],
                   must_succeed: false
  end

  # The app starts a daemon from its bundle that outlives the window. Stop it
  # (letting running turns finish) before the bundle goes, as on an upgrade.
  # The store is named: the uninstalling shell's AGENT_STORE or AGENT_SOCKET
  # may point elsewhere than the Dock-launched app did.
  uninstall quit:   "me.lydakis.agent",
            script: {
              executable:   "#{appdir}/Agent.app/Contents/MacOS/agent",
              args:         ["shutdown", "--store", "#{Dir.home}/.agent/state.sqlite", "--grace", "30s"],
              must_succeed: false,
            }

  zap trash: [
    "~/Library/Caches/me.lydakis.agent",
    "~/Library/Saved Application State/me.lydakis.agent.savedState",
    "~/Library/WebKit/me.lydakis.agent",
  ]
end
