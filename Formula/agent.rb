class Agent < Formula
  desc "Small daemon that hosts many durable AI agents"
  homepage "https://github.com/lydakis/agent"
  url "https://github.com/lydakis/agent/releases/download/v0.4.0/agent-0.4.0.tar.gz"
  sha256 "43c87cf947ae60e7d1831aca4f54068d3a85a2d1f642a05a311a13e9fbb8e389"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/lydakis/agent.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "agent-runtime #{version}", shell_output("#{bin}/agent --version").strip
  end
end
