class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.6), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.6/san_darwin_arm64.tar.gz"
      sha256 "36118a1e15399486fdcf2cae8dda97569be4defe2da9df029d6d5423c4402401"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.6/san_darwin_amd64.tar.gz"
      sha256 "bcc7c77d3365b95852b352e0367610a8abba4a6cb6bdff312a8d936682cec3c2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.6/san_linux_arm64.tar.gz"
      sha256 "0794eb9d77dfe1ebf4409e428f1cba53d23636d1bc5c83269343a90c025f5d7f"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.6/san_linux_amd64.tar.gz"
      sha256 "b91df8df0019086a263850bedc58e2b40307550da227ac37b1c370d999d0b79f"
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
