class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.23.1), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.23.1/san_darwin_arm64.tar.gz"
      sha256 "4298628bf89343fa84ea731a74036eba005ebe8b572c6297bcf5a2c40f4d5a33"
    else
      url "https://github.com/genai-io/san/releases/download/v1.23.1/san_darwin_amd64.tar.gz"
      sha256 "fed73a44855524348cb2a831200ccd529d98c58c99946a85d7e1ffa1313bc595"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.23.1/san_linux_arm64.tar.gz"
      sha256 "0a49a161efb6cb37fcc36fa6cb2e7ba9d5d24d1ba4500b5a34a83cae0e160853"
    else
      url "https://github.com/genai-io/san/releases/download/v1.23.1/san_linux_amd64.tar.gz"
      sha256 "009b39035282403f1daebd2bac3c45584414f2056a024628a7b53f87a83b4ad3"
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
