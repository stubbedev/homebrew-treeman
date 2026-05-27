class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.4.0"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "b45a2c5c23dd6157849464c16c1d33d17664eff00b92e5932b558926c337188d"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "2c1240d72e46e2eecec2c17f9bd775e311c7a45c68ff67639fa451c612a02f9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "7fa59da24320eaca03a9beeb6cc293d6d01fbb7cc2750407fcd966067cf9800f"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "374afa1689a2652f7501482576e1f009f28846795de078b116329b1609be9eea"
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
