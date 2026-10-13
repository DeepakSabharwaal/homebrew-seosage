cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.134.0"
  sha256 arm:   "eb0304ded2d1de9e39b634db92ece695fbd807790d29a8f1f0da9f5d37b5f5df",
         intel: "b83baa9e05e90d06d8c4a31432910004b66eda1684f2e35934308344e5d1fb0e"

  url "https://seosage.co/downloads/SEOSage-#{version}-Mac-#{arch}.dmg"
  name "SEOSage"
  desc "Desktop SEO audit software"
  homepage "https://seosage.co/"

  livecheck do
    url "https://seosage.co/updates/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on :macos

  app "SEOSage.app"

  # SEOSage is not Apple-notarised yet. Homebrew no longer skips the macOS
  # warning, so clear it here (same as the manual "xattr" step on the website).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SEOSage.app"]
  end

  uninstall quit: "co.seosage.app"

  zap trash: [
    "~/Library/Preferences/co.seosage.app.plist",
    "~/Library/Saved Application State/co.seosage.app.savedState",
  ]
end
