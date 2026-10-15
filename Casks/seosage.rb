cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.134.27"
  sha256 arm:   "b69bfe55e59e60670536aca67caf7e9d79a3d97e39df39493f85c6d7291e7be9",
         intel: "8d9ac94f1704de7450ca44fb1c7012efcea0a9a8a3bed323d2c6aa681fbbc9fa"

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
