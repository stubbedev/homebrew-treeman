class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.2.14"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "e1cd3dbcd2381263b7a154869e8f73b349d886ea50c9c86efa41d1bf167bcdae"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "9236bc30c3fc994f9bb3c5d1e6a392bf73ef5cc9b65de1eaf789c026e0031198"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "e3c1227b94ec0800db6dd656fafc2798d1e354b6e94d9e2543e2e4136408a07f"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "2729d4841cc2164834d1ab400b0fe2d827fd017f129f0c31cbb4bfa75aec4612"
    end
  end

  def install
    bin.install "treeman", "treemand"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/treeman --version")
  end
end
