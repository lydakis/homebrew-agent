class Agent < Formula
  desc "Small daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.8.1/agent-0.8.1.tar.gz"
  sha256 "e92c4392ebd2efa4f0c99a3109cb8c2b0442621c935cff1f0269cc5e1fa92816"
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
