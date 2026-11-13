class Agent < Formula
  desc "Small daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.9.5/agent-0.9.5.tar.gz"
  sha256 "c397d93fa58c6f98f01ba60b243e83beebfd8c5f1b9955dc6769ebca63e4d758"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/lydakis/agent.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  on_linux do
    depends_on "bubblewrap"
  end

  def install
    ENV["AGENT_BWRAP"] = (formula_opt_bin("bubblewrap")/"bwrap").to_s if OS.linux?
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "agent-runtime #{version}", shell_output("#{bin}/agent --version").strip
  end
end
