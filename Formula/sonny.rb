class Sonny < Formula
  desc "Terminal coordinator for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.9.2/agent-0.9.2.tar.gz"
  sha256 "1d8c3b015bee7d19c88d315f56d0e90d26e6850983e7e902c5d304345e6f2ff1"
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
