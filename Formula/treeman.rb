class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.5.38"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "335384376fe622828303161d483da1eb1722c0f1c0dd00a10fc4067c1c653bf0"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "1a7a3cf4142bd946742695032acef8c6a4a72a7cf8a4ae849e400cf35e7f07b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "8aa8339eeabe56224c92f86324ecb28cf02af4247899721478bc10839b448539"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "192edd71a7d4c30400eb0f79a710f91f394af96b3c3639ba84db2aa86af0982d"
    end
  end

  def install
    bin.install "treeman", "treemand"
  end

  # Lets users run `brew services start treeman` to keep
  # treemand running across reboots without invoking
  # `treeman daemon install` manually. The two installers
  # are mutually exclusive — both bind the same SOCK_STREAM
  # at $XDG_RUNTIME_DIR/treeman.sock — so the caveats
  # below ask users to pick one.
  service do
    run [opt_bin/"treemand"]
    # KeepAlive only on unexpected exits — `brew services
    # stop` and `treeman daemon stop` (clean exit 0) leave
    # the daemon down. Mirrors the dict the
    # `treeman daemon install` LaunchAgent writes so
    # behaviour matches across install paths.
    keep_alive successful_exit: false
    process_type :background
    log_path var/"log/treemand.log"
    error_log_path var/"log/treemand.log"
  end

  def caveats
    <<~CAVEATS
      To start treemand in the background:
        brew services start treeman

      Or, without homebrew-services:
        treeman daemon install

      Don't enable both — they bind the same socket.
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/treeman --version")
  end
end
