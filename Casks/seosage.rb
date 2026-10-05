cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.111.13"
  sha256 arm:   "87725f7fbe0f10db4ac6076573e3a2b5c3754d29c1f2625d5a3237e4b5c51bd4",
         intel: "f840c44e8f65725e63400bd176b108092e3c0ccc90f75b70d6ba1191b2769923"

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
