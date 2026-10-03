cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.104.3"
  sha256 arm:   "201bdae51ba7990c1516a807c4afbc5bdff5a5bde8764619f3c5e73b15938437",
         intel: "7682edc3aceed7fea533e4dcb649e043066fa9d9ab6be6f9f6115f87547eb642"

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
