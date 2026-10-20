cask "macclip" do
  version "0.1.2"
  sha256 "693f663ae2e79f2e1c59889b31ffb78f4f2b23b559411f0914cb8d56a052c63b"

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
