class Sonny < Formula
  desc "Terminal coordinator for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.3.1/sonny-0.3.1.tar.gz"
  sha256 "330e539bd1c97d5f0f8e640973021c765d7edb2a78fc49698bbf72fa1b6eee1d"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  def install
    # Sonny starts this daemon when none runs. It stays off PATH, where
    # Agent.app's `agent` (or another program's) may already be. Sonny
    # starts it by its `opt` path: the daemon outlives Sonny and hands its
    # own path to agents as AGENT_BIN, and that path must outlast the
    # version an upgrade and `brew cleanup` remove.
    libexec.install "bin/sonny", "libexec/agent"
    (bin/"sonny").write_env_script libexec/"sonny", AGENT_BIN: opt_libexec/"agent"
  end

  test do
    assert_equal "sonny #{version}", shell_output("#{bin}/sonny --version").strip
    assert_equal "agent-runtime #{version}", shell_output("#{libexec}/agent --version").strip
  end
end
