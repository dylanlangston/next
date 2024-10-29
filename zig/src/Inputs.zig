const std = @import("std");
const Common = @import("root").Common;
const raylib = Common.raylib;
const emscripten = Common.emscripten;
const JSButtons = @import("JSController.zig").JSGameController.Buttons;
const JSButtonsIterator = Common.Generic.Iterator(JSButtons);
const KeyIterator = Common.Generic.Iterator(raylib.KeyboardKey);
const JSGameController = @import("JSController.zig").JSGameController;

pub const Inputs = struct {
    const Keys = enum { Up, Down, Left, Right, A, Start };
    const Direction = enum { Up, Down, Left, Right };

    inline fn GetJSKeys(keys: Keys) JSButtonsIterator {
        switch (keys) {
            .Up => {
                return JSButtonsIterator{
                    .items = &[_:0]JSButtons{
                        JSButtons.Up,
                    },
                };
            },
            .Down => {
                return JSButtonsIterator{
                    .items = &[_:0]JSButtons{
                        JSButtons.Down,
                    },
                };
            },
            .Left => {
                return JSButtonsIterator{
                    .items = &[_:0]JSButtons{
                        JSButtons.Left,
                    },
                };
            },
            .Right => {
                return JSButtonsIterator{
                    .items = &[_:0]JSButtons{
                        JSButtons.Right,
                    },
                };
            },
            .A => {
                return JSButtonsIterator{
                    .items = &[_]JSButtons{
                        JSButtons.A,
                    },
                };
            },
            .Start => {
                return JSButtonsIterator{
                    .items = &[_]JSButtons{
                        JSButtons.Start,
                    },
                };
            },
        }
    }

    inline fn GetRaylibKeys(keys: Keys) KeyIterator {
        switch (keys) {
            .Up => {
                return KeyIterator{
                    .items = &[_:0]raylib.KeyboardKey{
                        raylib.KEY_W,
                        raylib.KEY_UP,
                    },
                };
            },
            .Down => {
                return KeyIterator{
                    .items = &[_:0]raylib.KeyboardKey{
                        raylib.KEY_S,
                        raylib.KEY_DOWN,
                    },
                };
            },
            .Left => {
                return KeyIterator{
                    .items = &[_:0]raylib.KeyboardKey{
                        raylib.KEY_A,
                        raylib.KEY_UP,
                    },
                };
            },
            .Right => {
                return KeyIterator{
                    .items = &[_:0]raylib.KeyboardKey{
                        raylib.KEY_D,
                        raylib.KEY_UP,
                    },
                };
            },
            .A => {
                return KeyIterator{
                    .items = &[_:0]c_uint{
                        raylib.KEY_SPACE,
                        raylib.KEY_ENTER,
                    },
                };
            },
            .Start => {
                return KeyIterator{
                    .items = &[_:0]raylib.KeyboardKey{
                        raylib.KEY_ESCAPE,
                    },
                };
            },
        }
    }

    pub inline fn Held(key: Keys) bool {
        var jskeyIterator = GetJSKeys(key);
        while (jskeyIterator.next()) |b| {
            if (JSGameController.ButtonHeld(b)) return true;
        }

        var raylibIterator = GetRaylibKeys(key);
        while (raylibIterator.next()) |k| {
            if (raylib.IsKeyDown(@intCast(k))) return true;
        }
        return false;
    }
    pub inline fn Pressed(key: Keys) bool {
        var jskeyIterator = GetJSKeys(key);
        while (jskeyIterator.next()) |b| {
            if (JSGameController.ButtonPressed(b)) return true;
        }

        var raylibIterator = GetRaylibKeys(key);
        while (raylibIterator.next()) |k| {
            if (raylib.IsKeyPressed(@intCast(k))) return true;
        }
        return false;
    }

    pub inline fn PointerPosition() raylib.Vector2 {
        return raylib.GetMousePosition();
    }

    pub inline fn Pointing(pointer: raylib.Vector2, screen: raylib.Vector2, direction: Direction) bool {
        if (!raylib.IsMouseButtonDown(raylib.MOUSE_BUTTON_LEFT)) return false;

        switch (direction) {
            .Up => {
                if (pointer.y < (screen.y / 2)) {
                    return true;
                }
                return false;
            },
            .Down => {
                if (pointer.y > (screen.y / 2)) {
                    return true;
                }
                return false;
            },
            .Left => {
                if (pointer.x < (screen.x / 2)) {
                    return true;
                }
                return false;
            },
            .Right => {
                if (pointer.x > (screen.x / 2)) {
                    return true;
                }
                return false;
            },
        }
    }
};
