require "formula"

class Helios < Formula
  homepage "https://github.com/spotify/helios"
  url "https://oss.sonatype.org/service/local/repositories/releases/content/com/spotify/helios-tools/0.9.281/helios-tools-0.9.281-shaded.jar"
  sha256 "11e6ed824e7c0671821b24d7bdb864f404a60be03646f074da6e2fcea546464a"
  version "0.9.281"

  depends_on :java => "1.7+"

  def install
    jarfile = "helios-tools-#{version}-shaded.jar"
    libexec.install jarfile
    (bin+"helios").write <<~EOS
      #!/usr/bin/env bash
      export SUPPRESS_GCLOUD_CREDS_WARNING=true
      exec java -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none -jar #{libexec}/#{jarfile} "$@"
    EOS
  end

  test do
    system "#{bin}/helios", "--version"
  end
end
