class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.5.32"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "e6c2d0cff3c2d89a5f18933fe6f3c24f0056b0e9bd7ee7046714011648adec3c"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "13d976853a1cde28b1e948862b8f9bb3e891349f582c83dd34cfbadbd88007d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "dc5c48bc6d564679faeb3f6b87f48f2bd74b8a6330b7cfcd9186cc7204a1f413"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "42bdec60117ea461346ae52d174d7a8faf32736f3e535a97d8bce02d35c57bd1"
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
