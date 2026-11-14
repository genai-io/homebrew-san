class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.25.2), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.2/san_darwin_arm64.tar.gz"
      sha256 "88b12fa437aa15f9e48003d06155ff22559c27f7f5387db73ac2a232f9b3545f"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.2/san_darwin_amd64.tar.gz"
      sha256 "c35d37a132cb83d2000d8dd7a361c01fe65ebf485105064784d59644d74b5408"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.2/san_linux_arm64.tar.gz"
      sha256 "10b9961f77822e2be0b35d9557f93d17e131d8bc2ff5647a9d3e3787a83e3047"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.2/san_linux_amd64.tar.gz"
      sha256 "4d8ed8c83c8c91a03a5037f6a9edff8b7efeb7ee0770227a36f2260139f1af6d"
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
