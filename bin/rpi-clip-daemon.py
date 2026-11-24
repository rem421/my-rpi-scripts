#!/usr/bin/env python3
import os
os.environ["GDK_BACKEND"] = "x11"
import base64
import sys
import threading
import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, GLib


def set_clip(text: str) -> bool:
    cb = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
    cur = cb.wait_for_text()
    if cur != text:
        cb.set_text(text, -1)
        cb.store()
    pr = Gtk.Clipboard.get(Gdk.SELECTION_PRIMARY)
    if pr.wait_for_text() != text:
        pr.set_text(text, -1)
    return False


def reader():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            text = base64.b64decode(line).decode("utf-8", errors="replace")
            GLib.idle_add(set_clip, text)
        except Exception:
            pass
    GLib.idle_add(Gtk.main_quit)


t = threading.Thread(target=reader, daemon=True)
t.start()
Gtk.main()
