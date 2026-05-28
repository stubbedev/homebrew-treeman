class Treeman < Formula
  desc "Per-worktree development environment helper (DBs, hooks, test clones)"
  homepage "https://github.com/stubbedev/treeman"
  version "2.4.4"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-arm64.tar.gz"
      sha256 "42b7c146e7c7afe59d15b559295141d183a712fc8791ae8ccc2f0fa0e0edf89b"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-darwin-amd64.tar.gz"
      sha256 "40010f95f2395709337ac8332533bab27b301ed244c170915fccbb6efb49d956"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-arm64.tar.gz"
      sha256 "719a06cd834c2215fc16f8320005a9df07465a577ea807a193f1bab64e40dab4"
    end
    on_intel do
      url "https://github.com/stubbedev/treeman/releases/download/v#{version}/treeman-#{version}-linux-amd64.tar.gz"
      sha256 "20da83128fd38af2334a30b652b538b41365b022eff531dc514d4e87ad14cc20"
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
