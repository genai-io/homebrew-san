class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.8), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.8/san_darwin_arm64.tar.gz"
      sha256 "d85679e331c43c2ce33d097071672ff2429bdd3c97a13a6b7d52b8086f8b9b6b"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.8/san_darwin_amd64.tar.gz"
      sha256 "deb93df25c59903467d2331c9e60395701aaa408b612e64eba948a3b8211db08"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.8/san_linux_arm64.tar.gz"
      sha256 "a5f46f863f031433b4de2ac1e874fd4b13995179e3e323e0e9613337ceee6b95"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.8/san_linux_amd64.tar.gz"
      sha256 "ae845c5ccb6c360329ae28b09c664a1815c6f76df50698dcc068cdf932b77b62"
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
