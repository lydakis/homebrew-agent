cask "agent" do
  version "0.1.3"
  sha256 "0c26b8a9b7edec2a3bee01d1a7a3a17d094328a8ca42bc632d2c777aa0d9b8ff"

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

  # The app starts a daemon from its bundle that outlives the window. Stop it
  # (letting running turns finish) before the bundle goes, as on an upgrade.
  # The store is named: the uninstalling shell's AGENT_STORE or AGENT_SOCKET
  # may point elsewhere than the Dock-launched app did.
  uninstall quit:   "me.lydakis.agent",
            script: {
              executable:   "#{appdir}/Agent.app/Contents/MacOS/agent",
              args:         ["shutdown", "--store", "#{Dir.home}/.agent/state.sqlite", "--grace", "30"],
              must_succeed: false,
            }

  zap trash: [
    "~/Library/Caches/me.lydakis.agent",
    "~/Library/Saved Application State/me.lydakis.agent.savedState",
    "~/Library/WebKit/me.lydakis.agent",
  ]
end
