cask "rondo" do
  version "0.1.3"
  sha256 "03b8bbd7290853a73224b44d2a1363788fbec3db9e80ac43f71c5eae8a995a6a"

  url "https://github.com/kstepanchuk/rondo/releases/download/v#{version}/Rondo-#{version}.zip"
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
