class Sonny < Formula
  desc "Terminal coordinator for a daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.6.0/agent-0.6.0.tar.gz"
  sha256 "af55a50fc5c4db144c18b0a5ae99cc55781f636891251c6aa172b732b250603d"
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
