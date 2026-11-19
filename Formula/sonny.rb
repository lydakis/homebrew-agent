class Sonny < Formula
  desc "Terminal coordinator for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.10.2/agent-0.10.2.tar.gz"
  sha256 "52e682f71fe3983b4d7e907d647bc454c17882ad016a47ce27218130cbe03031"
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
