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
        return JSON.stringify({version: version, text: text});
    }
    if (argv[0] === 'replace') {
        const data = $.NSFileHandle.fileHandleWithStandardInput.readDataToEndOfFile;
        const input = JSON.parse(ObjC.unwrap(
            $.NSString.alloc.initWithDataEncoding(data, $.NSUTF8StringEncoding)));
        if (Number(board.changeCount) !== input.version) {
            return 'false';
        }
        board.clearContents;
        if (!board.setStringForType($(input.text), $.NSPasteboardTypeString)) {
            throw new Error('Cannot write clipboard');
        }
        return 'true';
    }
    throw new Error('Unknown clipboard action');
}
