cask "turnlane" do
  version "0.8.0"
  sha256 "4616caade3c8f898f5bedb673a9e470fbdd92ce62add6bda1aa6b413826b0f02"

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
