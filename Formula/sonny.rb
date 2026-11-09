class Sonny < Formula
  desc "Terminal coordinator for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.9.1/agent-0.9.1.tar.gz"
  sha256 "9aafee1a754a415561415d4941ab0201395cbadd2f5c8e845e881bceefe6a4b6"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/lydakis/agent.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on "agent-browser"
  depends_on "lydakis/agent/agent"
  depends_on "ripgrep"

  def install
    system "cargo", "install", *std_cargo_args(path: "sonny")
  end

  test do
    assert_equal "sonny #{version}", shell_output("#{bin}/sonny --version").strip
  end
end
