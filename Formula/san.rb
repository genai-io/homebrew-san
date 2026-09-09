class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.7), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.7/san_darwin_arm64.tar.gz"
      sha256 "37541c7567e1f43cf3a84d4c098720eba8f2024803a3006e78a7de8a2b5b1dc9"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.7/san_darwin_amd64.tar.gz"
      sha256 "5ff82b3e02e8cce7591eeb8c6162056e35aaf46b6de0d66304d2cf7b676cdf8a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.7/san_linux_arm64.tar.gz"
      sha256 "8fc008b1b85235fb1fbba6f5f3348b21d674913873bc491d230daa01b48c9ec5"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.7/san_linux_amd64.tar.gz"
      sha256 "5835cbb1c782ae342fbf08669f65c553fd94b78ad4073b01eb7b16d25a60a12e"
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
