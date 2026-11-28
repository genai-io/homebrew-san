class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.25.6), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.6/san_darwin_arm64.tar.gz"
      sha256 "458ee2a88cac24b63226aa8d4c5f9b7f460f535d62c84a09297c913fbd6203b8"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.6/san_darwin_amd64.tar.gz"
      sha256 "b366c8eac00bf4ef0749963d97b49c233e90eb9aa9a523d5f75f05f5078f0ecc"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.6/san_linux_arm64.tar.gz"
      sha256 "874ae85a20a16c16946b2571615dd6b19ae63d9123c517e704109ef93694d177"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.6/san_linux_amd64.tar.gz"
      sha256 "087e09d586e848be6da7124fc599ce84a8ddcaeff1e2708d3a4d76e6e7f46afe"
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
