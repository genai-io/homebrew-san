class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.3), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.3/san_darwin_arm64.tar.gz"
      sha256 "a3f15c1aea2f39c70e7eba36382be941179fa60ddf62251c44bfa4d09b5e400d"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.3/san_darwin_amd64.tar.gz"
      sha256 "efaf51438fd8ad3675469b17df8c28bd981fff8c5df5a228681bf499701f795c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.3/san_linux_arm64.tar.gz"
      sha256 "3553280d67c4674a5e125611054bf1c3f78569c2a7114643cd10d2ac9a5a9670"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.3/san_linux_amd64.tar.gz"
      sha256 "7e660d87cb1259b40e848fb8ab718e2450f8359b9c22e70919705a4ba7cd026b"
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
