class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.22.5), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.5/san_darwin_arm64.tar.gz"
      sha256 "7e0688828f446c557c4fb8715a913518c96954a358e932aeb8350f3b9073af3d"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.5/san_darwin_amd64.tar.gz"
      sha256 "2aaefdc1ea46e4db1b31d2c945ea12bf5fccb2de412cb508c0f8420334262964"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.22.5/san_linux_arm64.tar.gz"
      sha256 "167ccd8122db942c0da3daa45fa451a0503a77c6dc11acc7a2d1ebc9b86ce486"
    else
      url "https://github.com/genai-io/san/releases/download/v1.22.5/san_linux_amd64.tar.gz"
      sha256 "d2acf6280f6729b1cb17876f0d14bd2ad2610fadb803fe2786e9a3b4f13f3535"
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
