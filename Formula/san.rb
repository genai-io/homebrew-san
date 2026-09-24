class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.11), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.11/san_darwin_arm64.tar.gz"
      sha256 "1f0b9b16eefba1888495c8ad066a0a8008dbf6a7cfbad32619c5e1478824f5b8"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.11/san_darwin_amd64.tar.gz"
      sha256 "1978ed090043d032b6ac72e13dcd7a75e1f98fb3faedcde1b036d97fcaaee20d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.11/san_linux_arm64.tar.gz"
      sha256 "d941df8acef9a51976d251cb136e1eadec7674ab5425edb532aa85f464dd394a"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.11/san_linux_amd64.tar.gz"
      sha256 "46601cd2199bfb93382966caa2910ffccfd226f901a261763d92f4462bdd6607"
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
