class Agent < Formula
  desc "Small daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.10.8/agent-0.10.8.tar.gz"
  sha256 "539d2bc6edb196a9fe665a0e95fac2c5f4495ff8067e3a62b218396de2019f06"
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
    libexec.install "release/store_down.py", "release/store_lift_yields.py"
  end

  test do
    assert_equal "agent-runtime #{version}", shell_output("#{bin}/agent --version").strip
    assert_match "store_down.py STORE SCHEMA", shell_output("#{libexec}/store_down.py --help")
  end
end
