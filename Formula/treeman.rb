class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.2.20"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "fc967e1266f1b103b2613c78989fc79dbfe0f58cfa1751482a1c1289bcb8c208"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "fd844eab0126bee079fe923e3f897763c1928ca53921ae38e8438441b7253142"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "6654ddb24dc736676ee1f6c07e64ab417c8203b379d16347c21450d407463242"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "13aa8b78e11a1b23000902d21cc0f5eb171664a33c31ebda141c6ba19988239c"
    end
  end

  def install
    bin.install "treeman", "treemand"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/treeman --version")
  end
end
