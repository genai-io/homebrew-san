class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.23.0), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.23.0/san_darwin_arm64.tar.gz"
      sha256 "7e3ca69118a51d368bf4397cc9ed644cb2aa95bdb6f4992a97f9b27f69cec943"
    else
      url "https://github.com/genai-io/san/releases/download/v1.23.0/san_darwin_amd64.tar.gz"
      sha256 "a230e4b2c1f14ddc14eaea5f59389e3bc29f5a09e5ac38098528233462a9a694"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.23.0/san_linux_arm64.tar.gz"
      sha256 "beb1806552658c05f4f80a436408cc40f9ef53123d071e4e7b9a6663eaadb1a1"
    else
      url "https://github.com/genai-io/san/releases/download/v1.23.0/san_linux_amd64.tar.gz"
      sha256 "f5c850cb85c7a864b3ec9ee926b89eccf1acf707c5e2d882257cfc5908b16b84"
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
