cask "rondo" do
  version "0.2.0"
  sha256 "b8404f59a0d882d908998dbac8cd82abfa538dbc8db9b88d037dc893d66bcafa"

  url "https://github.com/kstepanchuk/rondo/releases/download/v#{version}/Rondo-#{version}.dmg"
  name "Rondo"
  desc "Radial-menu file converter: drag a file, hold a modifier, drop on a format"
  homepage "https://github.com/kstepanchuk/rondo"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Rondo.app"
  binary "#{appdir}/Rondo.app/Contents/MacOS/Rondo", target: "rondo"

  # The app is ad-hoc signed (not notarized), so Gatekeeper would block the first launch.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Rondo.app"]
  end

  uninstall quit: "io.github.kstepanchuk.rondo"

  zap trash: [
    "~/Library/Preferences/io.github.kstepanchuk.rondo.plist",
    "~/Library/Group Containers/UBF8T346G9.Office/Rondo",
  ]

  caveats <<~EOS
    Optional engines:
      brew install ffmpeg pandoc sevenzip
  EOS
end
