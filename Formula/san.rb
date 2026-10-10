class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.24.1), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.24.1/san_darwin_arm64.tar.gz"
      sha256 "0bb4f8b1bb1da3fb507df2b408374eae12303362fba096d349d168e151b850d2"
    else
      url "https://github.com/genai-io/san/releases/download/v1.24.1/san_darwin_amd64.tar.gz"
      sha256 "5fd7892330d7cb808e9ac8f998fae5243d533296958b01a3c84d56d21877f14f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.24.1/san_linux_arm64.tar.gz"
      sha256 "86ddc6c3eef14f06004da780395543f755896c26e7a9b3a483032d8f143c4800"
    else
      url "https://github.com/genai-io/san/releases/download/v1.24.1/san_linux_amd64.tar.gz"
      sha256 "29d85c8b8378ea62069f0a814737aa6f68ebd59041039a86749915d34ee3063f"
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
