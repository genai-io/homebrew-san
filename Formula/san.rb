class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.2), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.2/san_darwin_arm64.tar.gz"
      sha256 "95299a9fdfcadb7a442abc73defde5fa889b077aafe50ebc0d62a03a4423d7b5"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.2/san_darwin_amd64.tar.gz"
      sha256 "0610a48710cbe6550acd8ba7d256391c320fdb2b9ea3bfddce0ebfe5fb1988ad"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.2/san_linux_arm64.tar.gz"
      sha256 "11a1497bc55330ec7c50d5d707d79400956e8f764cb10b531e8bc729811bb2f2"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.2/san_linux_amd64.tar.gz"
      sha256 "17134a1cd5f94d06ef533cb44ee961455f9a3624d9c79cfa92fa015e8e632e25"
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
