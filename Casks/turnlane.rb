cask "turnlane" do
  version "0.7.1"
  sha256 "ad78ce1a59975a67b53316403c99dfd3eb266eb2ce7ba78059ae2319ffb73889"

  url "https://github.com/turnlane/turnlane/releases/download/v#{version}/Turnlane-#{version}.zip"
  name "Turnlane"
  desc "Daily planner for your calendar, tasks, and AI coding agents"
  homepage "https://github.com/turnlane/turnlane"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Turnlane.app"
  binary "#{appdir}/Turnlane.app/Contents/Helpers/turnlane"

  uninstall quit: "dev.turnlane.desktop"

  zap launchctl: [
        "dev.turnlane.calendar-helper",
        "dev.turnlane.daemon",
      ],
      trash:     [
        "~/Library/Application Support/turnlane",
        "~/Library/Caches/dev.turnlane.desktop",
        "~/Library/Logs/turnlane",
        "~/Library/Preferences/dev.turnlane.desktop.plist",
        "~/Library/Saved Application State/dev.turnlane.desktop.savedState",
        "~/Library/WebKit/dev.turnlane.desktop",
      ]

  caveats <<~EOS
    Turnlane's hooks and MCP entries in Claude Code and Codex are not removed by
    `brew uninstall`. Before uninstalling, run:
      turnlane uninstall --all
    Your data in ~/Library/Application Support/turnlane stays unless you use
    `brew uninstall --zap --cask turnlane`.
  EOS
end
