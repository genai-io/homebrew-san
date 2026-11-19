class San < Formula
  desc "Minimal overhead, maximum agent: a fast, open agent harness for the terminal"
  homepage "https://github.com/genai-io/san"
  # No explicit `version`: it is scanned from the literal release tag in the
  # URLs below (v1.25.4), so the audit "version redundant" check stays quiet.
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.4/san_darwin_arm64.tar.gz"
      sha256 "35bf0c41f91be1916cb0fb53bc8660bc9246161480890d4d9f1befced2db63cb"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.4/san_darwin_amd64.tar.gz"
      sha256 "8840a13dfe39b6ec1906604c8ca62cc32a9224284b2be254da71b2076f3c4656"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/genai-io/san/releases/download/v1.25.4/san_linux_arm64.tar.gz"
      sha256 "730d023e8786b383f919309494d0858d972a07c6fed1fc363b421015be331ad6"
    else
      url "https://github.com/genai-io/san/releases/download/v1.25.4/san_linux_amd64.tar.gz"
      sha256 "9d73f91b4ea0fcccd08e22ffe36af46fab088040f113f50295cd56c7854de5b9"
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
