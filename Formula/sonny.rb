class Sonny < Formula
  desc "Terminal coordinator for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.10.4/agent-0.10.4.tar.gz"
  sha256 "3ba548652ba4ab2dbc60013a2a3bdb52fb68ab84d86a2ade1a0d0619c6f59409"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/lydakis/agent.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on "lydakis/agent/agent"
  depends_on "ripgrep"

  def install
    system "cargo", "install", *std_cargo_args(path: "sonny")
  end

  test do
    assert_equal "sonny #{version}", shell_output("#{bin}/sonny --version").strip
  end
end
