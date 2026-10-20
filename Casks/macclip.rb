cask "macclip" do
  version "0.1.1"
  sha256 "16dacf4b41dacc011f1fb42ebd39caf93852063bbb3d7914d9a9254ecd7239be"

  url "https://github.com/mehedihsiam/macclip/releases/download/v#{version}/MacClip.dmg"
  name "MacClip"
  desc "Clipboard history manager that pastes with Option+V"
  homepage "https://mehedihsiam.github.io/macclip/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "MacClip.app"

  # MacClip is not notarized by Apple, so remove the download quarantine flag
  # to avoid the "could not verify" prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/MacClip.app"],
        must_succeed: false
  end

  uninstall quit: "com.macclip.app"

  zap trash: [
    "~/Library/Application Support/MacClip",
    "~/Library/Logs/MacClip",
  ]
end
