class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.25.3), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.3/san_darwin_arm64.tar.gz"
      sha256 "cda69e6607bdf643215017546dca8c1772f571e3c7bbe2f9d74a49869ef763ff"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.3/san_darwin_amd64.tar.gz"
      sha256 "c9ab93eebd1ee8b583099749b7f2186e67ba7cab5b70bb99b060eaafa6ed0aa9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.3/san_linux_arm64.tar.gz"
      sha256 "036c5bc8dff829a7222e2e1f83714384c7225c9a1159f7afb40940be556dc68b"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.3/san_linux_amd64.tar.gz"
      sha256 "9dc1e9cc3dfdef04b3e40054eed474d1520294ac6c7352755b814092ea87ab6d"
    end
  else
    odie "Unsupported platform"
  end

  def install
    bin.install "san"
  end

  def caveats
    <<~EOS
      Upgrading is done with Homebrew:
        brew upgrade san

      Do not use the built-in `san update` command: it overwrites the binary
      in place, which would clobber the Homebrew-managed copy inside the
      Cellar and break `brew upgrade` bookkeeping.
    EOS
  end

  test do
    # Released binaries carry a v prefix ("san version v1.22.2") because the
    # Makefile versions them with `git describe --tags`.
    assert_match(/san version v?#{version}/, shell_output("#{bin}/san version"))
  end
end
