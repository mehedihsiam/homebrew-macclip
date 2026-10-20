cask "macclip" do
  version "0.1.0"
  sha256 "d086b7ef2caef13898b462f835e8089101182c2bf3e1adeb4094abe4dc2016a3"

  url "https://github.com/mehedihsiam/macclip/releases/download/v#{version}/MacClip.dmg"
  name "MacClip"
  desc "Clipboard history for macOS"
  homepage "https://mehedihsiam.github.io/macclip/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "MacClip.app"

  # MacClip is not notarized by Apple, so remove the download quarantine flag
  # to avoid the "could not verify" prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MacClip.app"],
                   sudo: false
  end

  uninstall quit: "com.macclip.app"

  zap trash: [
    "~/Library/Application Support/MacClip",
    "~/Library/Logs/MacClip",
  ]
end
