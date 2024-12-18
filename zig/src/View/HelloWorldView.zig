const std = @import("std");
const Common = @import("root").Common;
const raylib = Common.raylib;

const HelloWorldViewModel = Common.ViewLocator.getViewModel(.HelloWorld);

pub const HelloWorldView = Common.ViewLocator.createView(
    struct {
        pub fn draw() Common.ViewLocator.Views {
            const screen_color = raylib.Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
            raylib.ClearBackground(screen_color);

            raylib.DrawText("Hello OpenGL World", 190, 200, 20, raylib.LIGHTGRAY);

            var buf: [128:0]u8 = undefined;
            if (std.fmt.bufPrintZ(&buf, "Mouse X: {}, Mouse Y: {}, Click: {}, Screen Width: {}, Screen Height: {}", .{
                raylib.GetMouseX(),
                raylib.GetMouseY(),
                raylib.IsMouseButtonDown(raylib.MOUSE_BUTTON_LEFT),
                raylib.GetScreenWidth(),
                raylib.GetScreenHeight(),
            })) |_| {
                raylib.DrawText(&buf, 90, 225, 20, raylib.LIGHTGRAY);
            } else |_| {
                raylib.DrawText("Failed to get mouse position!", 190, 225, 20, raylib.LIGHTGRAY);
            }

            const music = HelloWorldViewModel.music;
            if (Common.Input.Held(.A)) {
                raylib.DrawText("A/Space/Enter Held", 190, 250, 20, raylib.BLUE);

                music.Play();
            } else {
                music.Pause();
            }

            if (Common.Focused == false or Common.Input.Pressed(.Start)) {
                return .Test;
            } else {
                return .HelloWorld;
            }
        }
    },
    struct {
        pub fn init() void {
            Common.Log.Info("Hello World Init");
            HelloWorldViewModel.music = Common.Music.Get(.Test);
        }
    },
);
