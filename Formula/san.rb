class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.25.5), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.5/san_darwin_arm64.tar.gz"
      sha256 "83cae2f26d19a57da7a252a79fe53ead9a300a01887e336f50c54c07b6d375df"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.5/san_darwin_amd64.tar.gz"
      sha256 "e16fa3a54297b677de5ea7189819c5d2673a6fa18cdb71fb304755c05ed9ec86"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.5/san_linux_arm64.tar.gz"
      sha256 "f563bcc875f39246f21120a606dd2a5590716b3bedd6990cc15c46c26b4b6933"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.5/san_linux_amd64.tar.gz"
      sha256 "69922a9c6c6bd5a6587e7c24c22874b7c649217a81f4eb96aec46dd263f04743"
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
