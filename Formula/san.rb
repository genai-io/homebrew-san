class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.9), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.9/san_darwin_arm64.tar.gz"
      sha256 "6438c56d38192b85bf3500f860903af927b97d6fb823980d2e07cf24d0f6bcbf"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.9/san_darwin_amd64.tar.gz"
      sha256 "59ab63b6f386a8cdc7075331968b77567a97cfe3356da22a634e1735fba762ba"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.9/san_linux_arm64.tar.gz"
      sha256 "cf3704fefe2e276acbca0345c7e891ddfeac877183999d19d3488a2bdf81e364"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.9/san_linux_amd64.tar.gz"
      sha256 "cca571526f837ccd598c562a2569b62d2111f249ad54ce8f03881f63b49355f8"
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
