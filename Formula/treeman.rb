class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.2.19"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "893f725d982e5b2d61f70c826536c7f7630effdeade19f72a295f975e858db71"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "1addf90cf3c999b6ef8d6c045acb9d532538d8efeee7c14bf0d7b531230fe067"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "8e1486655802fe3334dccd974729f0a3ce3dc3c78ad1f21ff22d544cd5b3dd58"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "cbad1fc7e71f0b0531af439caebf57346421eae02b98ec936a8cea68eb23ec67"
    end
  end

  def install
    bin.install "treeman", "treemand"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/treeman --version")
  end
end
