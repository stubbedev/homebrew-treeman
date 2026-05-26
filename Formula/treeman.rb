class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.3.3"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "3cf37ecb0d6f04471d983e6430566b85cdb121df0a1f022f85b28c063329a3b6"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "41f50a153ab43ebe3e0e02b1b5eea9407d6d1cad440571c61e766e1fa01598cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "36f6a73e6ce09bffd8576162b6bd4a61b762a07de9b1b1e29d405b9a7e6a9f1e"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "eccc4ad1bb157377b3fb351bd64d8caafea81e37b72d117f681a5c6453feb977"
    end
  end

  def install
    bin.install "treeman", "treemand"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/treeman --version")
  end
end
