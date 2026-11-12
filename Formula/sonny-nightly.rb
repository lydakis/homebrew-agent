class SonnyNightly < Formula
  desc "Nightly terminal coordinator with its matching agent daemon"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent.git", branch: "main"
  version "10.1"
  # Generated from revision: "4e17d3b7c7f6e630eeecc440e7ca3cc8ab07d832"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    skip "Updated by the nightly workflow"
  end

  depends_on "rust" => :build
  depends_on "agent-browser"
  depends_on "ripgrep"

  on_linux do
    depends_on "bubblewrap"
  end

  conflicts_with "sonny", because: "both install the sonny command"

  def install
    ENV["AGENT_BWRAP"] = (formula_opt_bin("bubblewrap")/"bwrap").to_s if OS.linux?
    system "cargo", "install", *std_cargo_args(root: libexec)
    libexec.install libexec/"bin/agent"
    system "cargo", "install", *std_cargo_args(path: "sonny")
  end

  test do
    sonny = shell_output("#{bin}/sonny --version").strip
    agent = shell_output("#{bin}/sonny agent --version").strip
    assert_match(/^sonny [0-9][0-9A-Za-z.+-]* \([0-9a-f]{9,40}\)$/, sonny)
    assert_match(/^agent-runtime [0-9][0-9A-Za-z.+-]* \([0-9a-f]{9,40}\)$/, agent)
    assert_equal sonny[/\(([0-9a-f]+)\)$/, 1], agent[/\(([0-9a-f]+)\)$/, 1]
  end
end
