cask "rondo" do
  version "0.1.6"
  sha256 "c2166a0a771748f5dfca142459f807f2c4e9592c5d462a11f1ee91960e308551"

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
