import AppKit

struct CleanupStatus: Codable {
    let state: String
    let message: String
    let model: String
    let updated: Double

    var title: String {
        switch state {
        case "working": return "Qwen ⏳"
        case "error": return "Qwen ⚠"
        default: return "Qwen ✓"
        }
    }

    func isVisible(at now: Double) -> Bool {
        // A request normally times out after 90 seconds. Don't leave a hung
        // process looking active forever if it was killed outside the shortcut.
        if state == "working" { return now - updated < 120 }
        if state == "error" { return true }
        return now - updated < 5
    }
}

final class StatusController: NSObject, NSApplicationDelegate {
    private let statusURL: URL
    private let diagnostics: Bool
    private var item: NSStatusItem!
    private var timer: Timer?
    private var current: CleanupStatus?
    private var dismissed: Double?
    private var lastSnapshot = ""

    init(statusURL: URL, diagnostics: Bool) {
        self.statusURL = statusURL
        self.diagnostics = diagnostics
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item.isVisible = false
        refresh()
        timer = Timer(timeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.refresh()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func refresh() {
        guard let data = try? Data(contentsOf: statusURL),
              let status = try? JSONDecoder().decode(CleanupStatus.self, from: data) else {
            item.isVisible = false
            return
        }
        let now = Date().timeIntervalSince1970
        let visible = status.isVisible(at: now) && dismissed != status.updated
        if current?.updated != status.updated {
            current = status
            let color: NSColor = status.state == "error" ? .systemRed
                : status.state == "working" ? .labelColor : .systemGreen
            item.button?.attributedTitle = NSAttributedString(
                string: status.title,
                attributes: [.foregroundColor: color, .font: NSFont.boldSystemFont(ofSize: 13)]
            )
            item.button?.toolTip = "\(status.model): \(status.message)"
            item.button?.setAccessibilityLabel("\(status.title): \(status.message)")
            let menu = NSMenu()
            let detail = NSMenuItem(title: "\(status.model): \(status.message)", action: nil, keyEquivalent: "")
            detail.isEnabled = false
            menu.addItem(detail)
            menu.addItem(.separator())
            let dismiss = NSMenuItem(title: "Dismiss", action: #selector(dismissStatus), keyEquivalent: "")
            dismiss.target = self
            menu.addItem(dismiss)
            item.menu = menu
        }
        item.isVisible = visible
        // Optional diagnostics report the native item's actual state for local QA.
        if diagnostics {
            let snapshot = "\(status.updated):\(visible)"
            if snapshot != lastSnapshot {
                let record: [String: Any] = [
                    "title": item.button?.title ?? "",
                    "visible": item.isVisible,
                    "state": status.state,
                    "message": status.message,
                ]
                if let data = try? JSONSerialization.data(withJSONObject: record) {
                    FileHandle.standardOutput.write(data)
                    FileHandle.standardOutput.write(Data("\n".utf8))
                }
                lastSnapshot = snapshot
            }
        }
    }

    @objc private func dismissStatus() {
        dismissed = current?.updated
        refresh()
    }
}

let arguments = CommandLine.arguments
let statusPath: String
if let index = arguments.firstIndex(of: "--status-file"), index + 1 < arguments.count {
    statusPath = arguments[index + 1]
} else {
    statusPath = NSHomeDirectory() + "/Library/Caches/clipboard-cleanup/status.json"
}
let app = NSApplication.shared
app.setActivationPolicy(.accessory)
let controller = StatusController(
    statusURL: URL(fileURLWithPath: statusPath),
    diagnostics: arguments.contains("--diagnostics")
)
app.delegate = controller
app.run()
