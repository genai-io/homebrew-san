class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.23.2), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.23.2/san_darwin_arm64.tar.gz"
      sha256 "ebb6a4b2244111816686bd63555dae494c722ce0c0e382ea50e569bd98931846"
    else
      url "https://github.com/genai-io/san/releases/download/v1.23.2/san_darwin_amd64.tar.gz"
      sha256 "6544f87a432981c325cf31ab5706afdff53a1fc0d11ffbe89f2e8bbae92cea00"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.23.2/san_linux_arm64.tar.gz"
      sha256 "9a2c97fc499dc1e31d776c35484b11162abde273e34613a0b33f283246606015"
    else
      url "https://github.com/genai-io/san/releases/download/v1.23.2/san_linux_amd64.tar.gz"
      sha256 "35b5d3030b2d63dc808713498593562269108d660089c013e5e44af92bd54951"
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
