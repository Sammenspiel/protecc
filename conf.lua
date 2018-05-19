function love.conf(t)
    t.identity              = nil
    t.appendidentity        = false
    t.version               = '11.1'
    t.console               = false
    t.accelerometerjoystick = true
    t.externalstorage       = false
    t.gammacorrect          = false

    t.window.title          = 'p r o t e c c'
    t.window.icon           = nil
    t.window.width          = 600
    t.window.height         = 600
    t.window.borderless     = false
    t.window.resizable      = true
    t.window.minwidth       = 1
    t.window.minheight      = 1
    t.window.fullscreen     = false
    t.window.fullscreentype = 'desktop'
    t.window.vsync          = 0
    t.window.msaa           = 0
    t.window.display        = 1
    t.window.highdpi        = false
    t.window.x              = nil
    t.window.y              = nil

    t.audio.mixwithsystem = true

    t.modules.audio    = true
    t.modules.data     = true
    t.modules.event    = true
    t.modules.font     = true
    t.modules.graphics = true
    t.modules.image    = true
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.math     = true
    t.modules.mouse    = true
    t.modules.physics  = true
    t.modules.sound    = true
    t.modules.system   = true
    t.modules.thread   = true
    t.modules.timer    = true
    t.modules.touch    = true
    t.modules.video    = true
    t.modules.window   = true
end