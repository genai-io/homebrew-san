class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.4), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.4/san_darwin_arm64.tar.gz"
      sha256 "532c72037dc71e3619db77b112f7e04a0ed437c46a563e655101cac3bdf4e36b"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.4/san_darwin_amd64.tar.gz"
      sha256 "6c7bc5b21a7c03ecaa87867e6826040074a8cb10e0381beb848b43051af6693c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.4/san_linux_arm64.tar.gz"
      sha256 "a87ccfb10dcb32777dd86190a3b68e8ebbfcc4ce13b5797404b9d5715eb62b9b"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.4/san_linux_amd64.tar.gz"
      sha256 "bad2536ded66cefb99427417b1cff630a3a1af0a4ec251d790b828d13e5e2f05"
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
