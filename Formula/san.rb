class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.24.4), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.24.4/san_darwin_arm64.tar.gz"
      sha256 "1eda3e6c090b25a8d4a7f4527b79ae554d9f797af06272a6f7a804c38b74846f"
    else
      url "https://github.com/genai-io/san/releases/download/v1.24.4/san_darwin_amd64.tar.gz"
      sha256 "f72f8d0ead8e430931f18843ac66fb93ced87af06542337b46d954d2aa7b3025"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.24.4/san_linux_arm64.tar.gz"
      sha256 "6305f79006d6c5806e84589b6d8d08cc03422861f6dacdb0d5d46594c66f7eb0"
    else
      url "https://github.com/genai-io/san/releases/download/v1.24.4/san_linux_amd64.tar.gz"
      sha256 "66a64cb12a916a0a40e80c820b7abfc1bb3788b57ca75ce8fd0cec49e65bb407"
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
