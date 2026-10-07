// macOS pasteboard bridge. Clipboard content travels over stdin, never shell code.
ObjC.import('AppKit');
ObjC.import('Foundation');

function run(argv) {
    const board = $.NSPasteboard.generalPasteboard;
    if (argv[0] === 'read') {
        const version = Number(board.changeCount);
        const value = board.stringForType($.NSPasteboardTypeString);
        const text = value.isNil() ? null : ObjC.unwrap(value);
        if (Number(board.changeCount) !== version) {
            throw new Error('Clipboard changed during read');
        }
        return JSON.stringify({version: version, text: text,
            app_pid: Number($.NSWorkspace.sharedWorkspace.frontmostApplication.processIdentifier)});
    }
    if (argv[0] === 'replace' || argv[0] === 'replace-and-paste') {
        const data = $.NSFileHandle.fileHandleWithStandardInput.readDataToEndOfFile;
        const input = JSON.parse(ObjC.unwrap(
            $.NSString.alloc.initWithDataEncoding(data, $.NSUTF8StringEncoding)));
        if (Number(board.changeCount) !== input.version) {
            return argv[0] === 'replace' ? 'false' : JSON.stringify('clipboard_changed');
        }
        board.clearContents;
        if (!board.setStringForType($(input.text), $.NSPasteboardTypeString)) {
            throw new Error('Cannot write clipboard');
        }
        if (argv[0] === 'replace') {
            return 'true';
        }
        if (Number($.NSWorkspace.sharedWorkspace.frontmostApplication.processIdentifier)
                !== input.app_pid) {
            return JSON.stringify('focus_changed');
        }
        // Send the native paste shortcut; text never enters keyboard or shell code.
        try {
            Application('System Events').keystroke('v', {using: ['command down']});
        } catch (error) {
            throw new Error('Cannot paste. Corrected text is on the clipboard. ' +
                'Allow Karabiner-Elements to control the computer in macOS ' +
                'Privacy & Security > Accessibility and Automation.');
        }
        return JSON.stringify('pasted');
    }
    throw new Error('Unknown clipboard action');
}
