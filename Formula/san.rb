class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.25.1), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.1/san_darwin_arm64.tar.gz"
      sha256 "238d2b66d2cf32cbb208288b39bc6991711ee047e5b072e0949253d794bb006c"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.1/san_darwin_amd64.tar.gz"
      sha256 "2ebb5f8ab1d9f8e880d9ed484a8d557065075d602fe4f31cabfe6419f139b870"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.1/san_linux_arm64.tar.gz"
      sha256 "197867c80e82b89f084c93c36dfc58d84dbdd8e012a467501b8311ab4b5dc68d"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.1/san_linux_amd64.tar.gz"
      sha256 "d9e296ec649e5f9b14b2e7171ab65ca74ba59cd1651fa71d1abe6ddf6619241d"
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
