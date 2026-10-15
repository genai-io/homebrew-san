class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.24.3), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.24.3/san_darwin_arm64.tar.gz"
      sha256 "b04cc22af769859b1095e08ba02ee6dfe7800d8070d1cecd9635950a6a54b207"
    else
      url "https://github.com/genai-io/san/releases/download/v1.24.3/san_darwin_amd64.tar.gz"
      sha256 "3d0280a280999f349de0ff3145cbd6d3152248cae904c771d6eefb108e5d0d3c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.24.3/san_linux_arm64.tar.gz"
      sha256 "5943359ff8c83750b75a9aeaed714088c6d9862a0d26b07923173ac9efe0b0ea"
    else
      url "https://github.com/genai-io/san/releases/download/v1.24.3/san_linux_amd64.tar.gz"
      sha256 "b9ebf303a4eeb613dee737fb57584a3031d2af023a7cc7991193f4113245b0b3"
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
