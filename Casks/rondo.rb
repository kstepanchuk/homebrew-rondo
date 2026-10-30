cask "rondo" do
  version "0.2.2"
  sha256 "3a7aedbec577ff555da2fbfe506dc47bb413543fc8e50a2384663eb0e6e6af81"

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
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/Rondo.app"], must_succeed: false
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
