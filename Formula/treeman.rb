class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.3.1"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "fe37bbd02324aa21b1b11a7ffe8cf4402fb6aca617814441266db1a31f845cb9"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "0e4b1443f4f99dec63e4154d24fa1483d9f2be883aab79468bbadea580c73128"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "8cd3dff2483b4b7bd374ccffb9f48742b70431bb8e9c6d78967ff0b34d47a87e"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "ecac89d24ef7db619fee97d5a67aee910c8f68de6d78ae1f5d18361b0989915d"
    end
  end

  def install
    bin.install "treeman", "treemand"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/treeman --version")
  end
end
