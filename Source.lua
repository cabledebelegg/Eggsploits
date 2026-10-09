local Config = {
    General = {
        Open = Enum.KeyCode.Minus,
        PingUpdateTime = 3,
        DisplayOrder = 999999999,
        InitTable = getgenv and getgenv() or _G,
        InitKey = "EggsploitsInitialised",
        RestartWhenAlreadyInitialised = true,
        CurrentVersionUrl = "https://raw.githubusercontent.com/cabledebelegg/Eggsploits/refs/heads/main/CurrentVersion.log",
        VersionHistoryUrl = "https://raw.githubusercontent.com/cabledebelegg/Eggsploits/refs/heads/main/VersionHistory.log",
        LastVersionPath = "LastEggsploitsVersion.log",
        Random = Random.new(),
        NameLength = 10,
        UpdateNotificationWait = 0.5,
    },
    Loading = {
        ImageColourTop = Color3.fromRGB(75, 75, 75),
        ImageColourBottom = Color3.fromRGB(255, 255, 255),
        PercentExponent = 5,
        PercentFeedBackSpeed = 0.5,
        TextColour = Color3.fromRGB(255, 204, 19),
        TextShimmerColour = Color3.fromRGB(255, 255, 255),
        ShimmerSize = 0.2,
        ShimmerExponent = 5/8,
        ShimmerDebounceTime = 1,
        ShimmerSpeed = 0.5,
        StartAnimation = TweenInfo.new(
            0.25,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        EndAnimation = TweenInfo.new(
            0.5,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out,
            0,
            false,
            0.5
        ),
        AfterWait = 0.5
    },
    Window = {
        FadeAnimation = TweenInfo.new(
            0.25,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out
        ),
        MaximiseAnimation = TweenInfo.new(
            0.25,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out
        )
    },
    Highlight = {
        Transparency = 1/4,
        MaxAmount = 500,
    },
    Notification = {
        Time = 7.5,
        Animation = TweenInfo.new(
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        BarColour = Color3.fromRGB(131, 107, 23)
    },
    Section = {
        SwitchAnimation = TweenInfo.new(
            0.5,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out
        ),
        ButtonInactiveColor = Color3.fromRGB(155, 155, 155),
        ButtonActiveColor = Color3.fromRGB(255, 255, 255),
    },
    Sizing = {
        StrokeThickness = 3/650,
        CornerRadius = 1/100,
        Topbar = 4/60,
        Frame = 1/10,
        ListPadding = 1/30,
        SuggestionButton = 1/20,
        SuggestionListPadding = 1/60,
        WindowResizeThickness = 5,
        ChangelogText = 40/580,
        TopbarInsetWhenMaximised = 225,
    },
    GenericProperties = {
        Gui = {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            ResetOnSpawn = false,
        },
        Text = {
            TextScaled = true,
            FontFace = Font.fromEnum(Enum.Font.FredokaOne),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Active = true,
            InputSink = Enum.InputSink.All,
        },
        Image = {
            ScaleType = Enum.ScaleType.Fit,
            Active = true,
            InputSink = Enum.InputSink.All,
        },
        TextBox = {
            TextScaled = true,
            FontFace = Font.fromEnum(Enum.Font.FredokaOne),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(20, 20, 20),
            PlaceholderColor3 = Color3.fromRGB(49, 49, 49),
            ClearTextOnFocus = false
        },
        Primary = {
            BackgroundColor3 = Color3.fromRGB(255, 204, 19),
            BorderSizePixel = 0,
            Active = true,
            InputSink = Enum.InputSink.All,
        },
        Secondary = {
            BackgroundColor3 = Color3.fromRGB(232, 185, 17),
            BorderSizePixel = 0,
            Active = true,
            InputSink = Enum.InputSink.All,
        },
        Stroke = {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        },
        Scroll = {
            BorderSizePixel = 0,
            ScrollBarImageColor3 = Color3.new(),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(0,0),
            Active = true,
            InputSink = Enum.InputSink.All,
        }
    },
    Images = {
        ExpressionlessEgg = 95063492825713,
        HUHEgg = 118621106143064,
        SadEgg = 75952115388174,
        XDEgg = 126710606924682,
        YouIcon = 7992557358,
        PlayersIcon = 124929180840291,
        ObjectsIcon = 12988752403,
        LightingIcon = 74888619733969,
        MiscIcon = 9405921255,
        MaximiseButton = 117275190545393,
    }
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if Config.General.InitTable[Config.General.InitKey] then
    Config.General.InitTable[Config.General.InitKey](Config.General.RestartWhenAlreadyInitialised)
    if not Config.General.RestartWhenAlreadyInitialised then
        return
    end
end

---- services, utils, janitor, object, global, notification, window, version, suggestions, highlight, main, button ----
local s = {}
local u = {}
local j = {}
local o = {}
local g = {}
local v = {}
local n = {}
local w = {}
local a = {}
local h = {}
local m = {}
local b = {}

---- services

setmetatable(s, {
    __index = function(self, name)
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
        local service = game:GetService(name)
        local ref = cloneref and cloneref(service) or service
        self[name] = ref
        return ref
    end
})

---- utils ----

function u.pos(x: number?, y: number?)
    return UDim2.fromScale(x or 0, y or 0)
end

function u.posOff(x: number?, y: number?)
    return UDim2.fromOffset(x or 0, y or 0)
end

u.pos0 = u.pos()
u.pos1 = u.pos(1, 1)

function u.posWithOffset(xs: number?, xo: number?, ys: number?, yo: number?)
    return UDim2.new(UDim.new(xs, xo), UDim.new(ys, yo))
end

function u.centre(x: number, y: number, size: UDim2)
    return u.pos(y-size.X.Scale/2, y-size.X.Scale/2)
end

function u.fromV2(v2: Vector2)
    return u.posOff(v2.X, v2.Y)
end

function u.asset(id: number?)
    return `rbxassetid://{id}`
end

function u.unaryWithBool(num: number, bool: boolean?)
    return
        if bool
        then num
        elseif bool == false
        then -num
        else 0
end

function u.boolToBit(bool: boolean?)
    return
        if bool
        then 1
        else 0
end

function u.buttonOrLabel(btn: boolean?): string
    return
        if btn
        then "Button"
        else "Label"
end

function u.insert<T>(tb: {T}, thingy: T): number
    local idx = #tb + 1
    tb[idx] = thingy
    return idx
end

function u.remove<T>(tb: {T}, thingy: T)
    local find = table.find(tb, thingy)
    if find then
        table.remove(tb, find)
    end
end

function u.filter(tb: {string}, str: string): {string}
    local out = {}
    for _, ostr in tb do
        if not ostr:find(str, nil, true) then continue end
        u.insert(out, ostr)
    end
    return out
end

function u.removeNan(num: number): number
    if math.isnan(num) then
        return 0
    end
    return num
end

do
    local nameColours =
            {
                BrickColor.new("Bright red").Color,
                BrickColor.new("Bright blue").Color,
                BrickColor.new("Earth green").Color,
                BrickColor.new("Bright violet").Color,
                BrickColor.new("Bright orange").Color,
                BrickColor.new("Bright yellow").Color,
                BrickColor.new("Light reddish violet").Color,
                BrickColor.new("Brick yellow").Color,
            }

    function u.nameColour(name: string)
        local value = 0
        for index = 1, #name do
            local char = string.byte(string.sub(name, index, index))
            local reverseIndex = #name - index + 1
            if #name % 2 == 1 then
                reverseIndex = reverseIndex - 1
            end
            if reverseIndex % 4 >= 2 then
                char = -char
            end
            value += char
        end
        return nameColours[(value % #nameColours) + 1]
    end
end

function u.pcall(fn: (...any) -> (...any), ...: any): (boolean, ...any)
    local tb = {pcall(fn, ...)}
    if not tb[1] then
        tb[2] = `Error: {tb[2]}`
    end
    return unpack(tb)
end

function u.httpGet(url: string): (boolean, string)
    return u.pcall(function(urllll)
        return game:HttpGet(urllll)
    end, url)
end

function u.readFile(path: string): (boolean, string)
    return u.pcall(readFile or readfile, path)
end

function u.writeFile(path: string, data: string): boolean
    return u.pcall(writeFile or writefile, path, data)
end

function u.randomString(len: number): string
    local str = ""
    for i = 1, len do
        str ..= string.char(
            Config.General.Random:NextInteger(
                0,
                255
            )
        )
    end
    return str
end

---- janitor ----

j.stuff = {}

function j.add(item: any, method: any?)
    u.insert(j.stuff, {
        item = item,
        method = method
    })
    return item
end

function j.remove(item: any)
    for idx = #j.stuff, 1, -1 do
        if j.stuff[idx].item ~= item then continue end
        table.remove(j.stuff, idx)
        return
    end
end

function j.cleanUpSingleRaw(idx: number, things: {item: any, method: any?})
    local item = things.item
    local typ = typeof(item)
    if typ == "RBXScriptConnection" then
        item:Disconnect()
    elseif typ == "Instance" then
        item:Destroy()
    elseif typ == "thread" then
        task.cancel(item)
    elseif typ == "function" then
        item()
    elseif typ == "table" then
        item[things.method](item)
    end
    table.remove(j.stuff, idx)
end

function j.cleanUpSingle(item: any)
    for idx = #j.stuff, 1, -1 do
        local things = j.stuff[idx]
        if things.item ~= item then continue end
        j.cleanUpSingleRaw(idx, things)
        return
    end
end

function j.cleanUp()
    for idx = #j.stuff, 1, -1 do
        j.cleanUpSingleRaw(idx, j.stuff[idx])
    end
end

---- object ----

function o.mould(inst: Instance, props: {[string]: any}?, ...: string)
    for _, tag in {...} do
        local tprops = Config.GenericProperties[tag]
        if not tprops then
            continue
        end
        for prop, val in tprops do
            inst[prop] = val
        end
    end
    if props then
        for k, v in props do
            inst[k] = v
        end
    end
end

function o.addName(props: {[string]: any}?)
    if not props or props.Name then
        return
    end
    props.Name = u.randomString(Config.General.NameLength)
end

function o.make(class: string, props: {[string]: any}?, ...: string)
    local inst = Instance.new(class)
    o.addName(props)
    o.mould(
        inst,
        props,
        ...
    )
    return inst
end

o.stros = {}
o.stroThickness = 0

function o.stro(parent: Instance?)
    local stro = o.make("UIStroke", {
        Parent = parent,
        Thickness = o.stroThickness,
    }, "Stroke")
    u.insert(o.stros, stro)
    return stro
end

o.corns = {}
o.cornRadius = UDim.new()

function o.corn(parent: Instance?)
    local corn = o.make("UICorner", {
        Parent = parent,
        CornerRadius = o.cornRadius
    })
    u.insert(o.corns, corn)
    return corn
end

function o.strocorn(parent: Instance?): (UIStroke, UICorner)
    return o.stro(parent), o.corn(parent)
end

function o.thingy(class: string, parent: Instance?, pos: UDim2?, size: UDim2?, bgTransparency: number?, ...: string): GuiObject
    return o.make(class, {
        Parent = parent,
        Position = pos or u.pos0,
        Size = size or u.pos0,
        BackgroundTransparency = bgTransparency or 1,
    }, ...)
end

function o.img(parent: Instance?, pos: UDim2?, size: UDim2?, id: number?, bgTransparency: number?, btn: boolean?, ...: string): any
    local img = o.thingy(`Image{u.buttonOrLabel(btn)}`, parent, pos, size, bgTransparency, "Image", ...)
    img.Image = u.asset(id)
    return img
end

function o.txt(parent: Instance?, pos: UDim2?, size: UDim2?, txt: string?, bgTransparency: number?, btn: boolean?, ...: string): any
    local kllgvj = o.thingy(`Text{u.buttonOrLabel(btn)}`, parent, pos, size, bgTransparency, "Text", ...);
    kllgvj.Text = txt or ""
    return kllgvj
end

function o.txtBox(parent: Instance?, pos: UDim2?, size: UDim2?, txt: string?, bgTransparency: number?, ...: string)
    local kllgvj = o.thingy(`TextBox`, parent, pos, size, bgTransparency, "TextBox", ...)
    kllgvj.PlaceholderText = txt or ""
    kllgvj.Text = ""
    return kllgvj
end

function o.scroll(parent: Instance?, pos: UDim2?, size: UDim2?, bgTransparency: number?, ...: string): ScrollingFrame
    return o.make("ScrollingFrame", {
        Parent = parent,
        Position = pos or u.pos0,
        Size = size or u.pos1,
        BackgroundTransparency = bgTransparency or 1
    }, "Scroll", ...)
end

function o.dragDetect(parent: Instance?): UIDragDetector
    return o.make("UIDragDetector", {
        ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset,
        Parent = parent
    })
end

function o.flex(parent: Instance?, mode: Enum.UIFlexMode?): UIFlexItem
    return o.make("UIFlexItem", {
        Parent = parent,
        FlexMode = mode or Enum.UIFlexMode.Shrink
    })
end

function o.part(parent: Instance?, size: Vector3?, transparency: number?, anchored: boolean?, collide: boolean?, query: boolean?, touch: boolean?): Part
    return o.make("Part", {
        Parent = parent,
        Transparency = transparency or 1,
        Size = size or Vector3.one,
        Anchored = anchored or false,
        CanCollide = collide or false,
        CanQuery = query or false,
        CanTouch = touch or false
    })
end

function o.list(
    parent: Instance?,
    horizontal: boolean?,
    vAlignment: Enum.VerticalAlignment?,
    hAlignment: Enum.HorizontalAlignment?,
    flex: Enum.UIFlexAlignment?,
    ps: number?,
    po: number?
)
    local list: UIListLayout = o.make("UIListLayout", {
        Parent = parent,
        FillDirection = horizontal and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(ps, po)
    })
    if vAlignment then
        list.VerticalAlignment = vAlignment
    end
    if hAlignment then
        list.HorizontalAlignment = hAlignment
    end
    if flex then
        list.VerticalFlex = flex
        list.HorizontalFlex = flex
    end
    return list
end

function o.padding(parent: Instance, ls: number?, lo: number?, rs: number?, ro: number?,ts: number?, to: number?, bs: number?, bo: number?)
    return o.make("UIPadding", {
        Parent = parent,
        PaddingLeft = UDim.new(ls, lo),
        PaddingRight = UDim.new(rs, ro),
        PaddingTop = UDim.new(ts, to),
        PaddingBottom = UDim.new(bs, bo)
    })
end

function o.paddingEzy(parent: Instance, l: number?, r: number?, t: number?, b: number?)
    return o.padding(parent, l, nil, r, nil, t, nil, b, nil)
end

function o.setPad(pad: UIPadding, udim: UDim)
    pad.PaddingLeft = udim
    pad.PaddingRight = udim
    pad.PaddingTop = udim
    pad.PaddingBottom = udim
end

o.stroPads = {}

function o.stroPad(parent: Instance): UIPadding
    local pad = o.make("UIPadding", {
        Parent = parent
    })
    o.setPad(pad, UDim.new(0, o.stroThickness))
    u.insert(o.stroPads, pad)
    return pad
end

function o.weak(tb: {}, k: boolean?, v: boolean?)
    local kv = ""
    if k ~= false then
        kv ..= "k"
    end
    if v ~= false then
        kv ..= "v"
    end
    setmetatable(tb, {
        mode = kv
    })
end

o.weak(o.stros)
o.weak(o.corns)
o.weak(o.stroPads)

---- global ----

g.plr = s.Players.LocalPlayer
g.mouse = g.plr:GetMouse()
g.uiFolder = gethui and gethui() or s.CoreGui or g.plr:WaitForChild("PlayerGui")

g.ui = j.add(o.make("ScreenGui", {
    DisplayOrder = Config.General.DisplayOrder,
    Parent = g.uiFolder,
}, "Gui"))

g.ping = 0
g.pingRound = 0
j.add(task.spawn(function()
    while task.wait(Config.General.PingUpdateTime) do
        g.pingRound = g.plr:GetNetworkPing()
        g.ping = g.pingRound / 2
    end
end))

do
    local function onCharAdded(newChar: Model)
        g.char = newChar
        g.hum = newChar:WaitForChild("Humanoid")
        g.root = newChar:WaitForChild("HumanoidRootPart")
        g.anim = g.hum:WaitForChild("Animator") or Instance.new("Animator", g.hum)
        g.att = g.root:WaitForChild("RootAttachment") or Instance.new("Attachment", g.root)
    end

    local upds = {}
    local function updOne(cam: Camera, ratio, fn)
        fn(ratio * math.min(cam.ViewportSize.X, cam.ViewportSize.Y))
    end

    local function updStuff(cam: Camera)
        for _, fjisdhf in upds do
            updOne(cam, fjisdhf[1], fjisdhf[2])
        end
    end

    local currentUpd
    local function onCamAdded(newCam: Camera)
        g.cam = newCam
        updStuff(newCam)
        if currentUpd then
            j.cleanUpSingle(currentUpd)
        end
        currentUpd = newCam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            updStuff(newCam)
        end)
        j.add(currentUpd)
    end

    onCharAdded(g.plr.Character or g.plr.CharacterAdded:Wait())
    j.add(g.plr.CharacterAdded:Connect(onCharAdded))

    onCamAdded(workspace.CurrentCamera)
    j.add(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCamAdded))

    function g.camUpd(ratio: number, fn: (number) -> ())
        u.insert(upds, {ratio, fn})
        updOne(g.cam, ratio, fn)
    end
end

function g.tp(v0: CFrame | Model | BasePart | Vector3 | number, v1: number?, v2: number?)
    local cf = CFrame.identity
    local typee = typeof(v0)
    if typee == "CFrame" then
        cf = v0
    elseif typee == "Instance" then
        if (v0 :: any):IsA("Model") then
            cf = (v0 :: any):GetPivot()
        elseif (v0 :: any):IsA("BasePart") then
            cf = (v0 :: any).CFrame
        end
    elseif typee == "Vector3" then
        cf = CFrame.new(v0 :: Vector3)
    elseif typee == "number" and v1 and v2 then
        cf = CFrame.new(v0 :: number, v1, v2)
    end
    g.char:PivotTo(cf)
end

function g.stay()
    local root = g.root
    root.Anchored = true
    while root.AssemblyLinearVelocity ~= Vector3.zero or root.AssemblyAngularVelocity ~= Vector3.zero do
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        s.RunService.Stepped:Wait()
    end
    root.Anchored = false
end

function g.getPrimaryPart(model: Model): BasePart?
    local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
    if part then
        return part.AssemblyRootPart
    end
    return
end

function g.getVelocity(v0: Model | BasePart): Vector3
    local part
    if v0:IsA("Model") then
        part = g.getPrimaryPart(v0)
        if not part then
            return Vector3.zero
        end
    else
        part = v0
    end
    return part.AssemblyLinearVelocity
end

g.camUpd(Config.Sizing.CornerRadius, function(num)
    local rad = UDim.new(0, num)
    o.cornRadius = rad
    for _, corn in o.corns do
        corn.CornerRadius = rad
    end
end)

function g.remove()
    j.cleanUp()
    Config.General.InitTable[Config.General.InitKey] = nil
end

function g.sinker(thing: Instance, zIndex: number?): Instance -- before v711 of rbx
    local gui = o.make("ScreenGui", {
        DisplayOrder = zIndex,
        Parent = g.ui
    }, "Gui")
    thing.Parent = gui
    return gui
end

---- notification ----

n.frame = o.make("Frame", {
    BackgroundTransparency = 1,
    Position = u.pos(0.3, 0.03),
    Size = u.pos(0.4, 0.1),
})
g.sinker(n.frame, Config.General.DisplayOrder)
n.padding = 1.5
n.notifs = {}
n.normInfo = TweenInfo.new(
    Config.Notification.Time,
    Enum.EasingStyle.Linear
)

type notifCallback = (number?) -> ()

function n.pop(ui: GuiObject)
    local idx = table.find(n.notifs, ui)
    if not idx then
        return
    end
    ui:Destroy()
    table.remove(n.notifs, idx)
    n.upd()
end

function n.upd()
    for idx, ui:CanvasGroup in n.notifs do
        local pos = u.pos(0, (idx - 1) * n.padding)
        if ui.Position == pos then
            continue
        end
        s.TweenService:Create(
            ui,
            Config.Notification.Animation,
            {Position = pos}
        ):Play()
    end
end

function n.call(ui: GuiObject, callback: any, idx: number?)
    n.pop(ui)
    if callback then
        callback(idx)
    end
end

function n.capSend(max: number?)
    local num = 0
    max = max or 1
    return function(img: number?, txt: string?, options: {string}?, callback: notifCallback?): boolean
        if num == max then
            return false
        end
        n.send(img, txt, options, function(idx)
            num -= 1
            if callback then
                callback(idx)
            end
        end)
        num += 1
        return true
    end
end

function n.send(img: number?, txt: string?, options: {string}?, callback: notifCallback?)
    local ui = o.make("CanvasGroup", {
        Size = u.pos1,
        Parent = n.frame,
        Position = u.pos(0, -n.padding)
    }, "Primary")
    local iui = o.make("Frame", {
        Size = u.pos1,
        BackgroundTransparency = 1,
        Parent = ui
    })
    o.strocorn(ui)
    o.paddingEzy(iui, 0.01, 0.025, 0.1, 0.1)
    o.list(iui, true, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Right, nil, 0.02)
    if img then
        o.img(iui, nil, u.pos(.1, 1), img).LayoutOrder = -1
    end
    if txt then
        local gthurgh = o.txt(iui, nil, u.pos1, txt)
        gthurgh.TextXAlignment = Enum.TextXAlignment.Left
        gthurgh.LayoutOrder = 0
        o.flex(gthurgh)
    end
    if options then
        for idx, str in options do
            local btn = o.txt(iui, nil, u.pos(.15, 0.8), str, 0, true, "Secondary")
            btn.LayoutOrder = idx
            o.strocorn(btn)
            btn.Activated:Once(function()
                n.call(ui, callback, idx)
            end)
        end
    end
    local twen = s.TweenService:Create(
        o.make("Frame", {
            Parent = ui,
            Position = u.pos(0, .93),
            Size = u.pos(1, 0.07),
            BorderSizePixel = 0,
            BackgroundColor3 = Config.Notification.BarColour
        }),
        n.normInfo,
        {Size = u.pos(0, .07)}
    )
    twen:Play()
    twen.Completed:Once(function()
        n.call(ui, callback)
    end)
    table.insert(n.notifs, 1, ui)
    s.RunService.RenderStepped:Once(n.upd)
end

function n.capSendImgStuffToo(img: number?, max: number?)
    local send = n.capSend(max)
    return function(txt: string, options: {string}?, callback: notifCallback?)
        return send(img, txt, options, callback)
    end
end

function n.normal(max: number?)
    return n.capSendImgStuffToo(Config.Images.ExpressionlessEgg, max)
end

function n.HUH(max: number?)
    return n.capSendImgStuffToo(Config.Images.HUHEgg, max)
end

function n.sad(max: number?)
    return n.capSendImgStuffToo(Config.Images.SadEgg, max)
end

function n.XD(max: number?)
    return n.capSendImgStuffToo(Config.Images.XDEgg, max)
end

do
    local XD = n.XD(3)
    Config.General.InitTable[Config.General.InitKey] = function(remove: boolean)
        if remove then
            g.remove()
        else
            XD("Already initialised, silly!", {"Ok"})
        end
    end
end

---- window ----

w.__index = w
w.windows = {}
w.topbarSize = 0
w.modals = {}
type btnCallback = (InputObject, number) -> ()

do
    local img
    local vis
    j.add(s.RunService.RenderStepped:Connect(function()
        for _ in w.modals do
            if not img then
                img = s.UserInputService.MouseIcon
                vis = s.UserInputService.MouseIconEnabled
            end
            s.UserInputService.MouseIcon = ""
            s.UserInputService.MouseIconEnabled = true
            return
        end
        if img then
            s.UserInputService.MouseIcon = img
            s.UserInputService.MouseIconEnabled = vis
        end
        img = nil
    end))
end

function w.new(
    sizeX: number,
    sizeY: number,
    minSizeX: number,
    minSizeY: number,
    maxSizeX: number,
    maxSizeY: number, title: string?,
    noCloseButton: boolean?,
    nonModal: boolean?,
    maximiseButton: boolean?
)
    local size = u.pos(sizeX, sizeY)
    local self = setmetatable({}, w)
    self.topButtons = {}
    self.bars = {}
    self.cns = {}
    self.buttonAmount = 0
    self.minSizeX = minSizeX
    self.minSizeY = minSizeY
    self.maxSizeX = maxSizeX
    self.maxSizeY = maxSizeY
    self.enabled = false
    self.ui = o.make("CanvasGroup", {
        Position = u.centre(.5,.5,size),
        Size = size,
        Visible = false,
        BackgroundTransparency = 1
    })
    o.stroPad(self.ui)
    self.inside = o.make("Frame", {
        Parent = self.ui,
        Position = u.pos0,
        Size = u.pos1,
    }, "Primary")
    self.screen = g.sinker(self.ui)
    self.stro = o.stro(self.inside)
    o.corn(self.inside)
    self.content = o.make("Frame", {
        Parent = self.inside,
        BackgroundTransparency = 1,
    })
    self.topbar = o.make("Frame", {
        Parent = self.inside
    }, "Secondary")
    self.topbarInsetPad = o.padding(self.topbar)
    o.paddingEzy(self.topbar, .01, .01)
    o.list(self.topbar, true, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Right)
    self.stro, self.corn = o.strocorn(self.topbar)
    self.drag = o.dragDetect(self.topbar)
    self.title = o.txt(self.topbar, nil, u.pos1, title)
    self.title.TextXAlignment = Enum.TextXAlignment.Left
    self.title.LayoutOrder = -math.huge
    o.flex(self.title)
    if not noCloseButton then
        self:addTxtBtn(
            "X",
            function()
                self:disable()
            end
        )
    end
    if not nonModal then
        self.modaler = o.txt(self.ui, nil, nil, nil, 1, true)
    end
    self.maximised = false
    if maximiseButton then
        self:addImgBtn(
            Config.Images.MaximiseButton,
            function()
                self:toggleMaximised()
            end
        )
    end
    for x = -1, 1 do
        self.bars[x] = {}
        for y = -1, 1 do
            if x == 0 and y == 0 then
                continue
            end
            local drag = self:makeBar(x, y)
            local dragging = false
            drag.DragStart:Connect(function()
                local oX = self.ui.Position.X.Scale
                local oY = self.ui.Position.Y.Scale
                local oSX = self.ui.Size.X.Scale
                local oSY = self.ui.Size.Y.Scale
                dragging = true
                while dragging and self.enabled and not self.maximised and s.RunService.RenderStepped:Wait() do
                    local du = drag.DragUDim2
                    local posX, sizeX = w.resizeAmount(x, oX, oSX, du.X.Offset / g.cam.ViewportSize.X, self.minSizeX, self.maxSizeX)
                    local posY, sizeY = w.resizeAmount(y, oY, oSY, du.Y.Offset / g.cam.ViewportSize.Y, self.minSizeY, self.maxSizeY)
                    self.ui.Position = u.pos(posX, posY)
                    self.ui.Size = u.pos(sizeX, sizeY)
                end
                dragging = false
            end)
            drag.DragEnd:Connect(function()
                dragging = false
            end)
            self.bars[x][y] = drag
        end
    end
    u.insert(w.windows, self)
    local dragging = false
    self.drag.DragStart:Connect(function()
        self:sendToLayer()
        dragging = true
        local x = self.ui.Position.X.Scale
        local y = self.ui.Position.Y.Scale
        local sx = 1 - self.ui.Size.X.Scale
        local sy = 1 - self.ui.Size.Y.Scale
        while dragging and self.enabled and not self.maximised and s.RunService.RenderStepped:Wait() do
            local du = self.drag.DragUDim2
            self.ui.Position = u.pos(
                math.clamp(x + du.X.Offset / g.cam.ViewportSize.X, 0, sx),
                math.clamp(y + du.Y.Offset / g.cam.ViewportSize.Y, 0, sy)
            )
        end
        dragging = false
    end)
    self.drag.DragEnd:Connect(function()
        dragging = false
    end)
    self:updTopbarSize(w.topbarSize)
    return self
end

function w.newEzier(
    size: number,
    minSize: number,
    maxSize: number,
    title: string?,
    noCloseButton: boolean?,
    nonModal: boolean?,
    maximiseButton: boolean?
)
    return w.new(
        size,
        size,
        minSize,
        minSize,
        maxSize,
        maxSize,
        title,
        noCloseButton,
        nonModal,
        maximiseButton
    )
end

function w:addBtn(btn: GuiButton, callback: btnCallback)
    self.buttonAmount += 1
    btn.Parent = self.topbar
    btn.Size = u.pos(0.8, 0.8)
    btn.SizeConstraint = Enum.SizeConstraint.RelativeYY
    btn.LayoutOrder = -self.buttonAmount
    self.topButtons[btn] = callback
    btn.Activated:Connect(callback)
end

function w:addTxtBtn(txt: string, callback: btnCallback)
    self:addBtn(
        o.make("TextButton", {
            BackgroundTransparency = 1,
            Text = txt
        }, "Text"),
        callback
    )
end

function w:addImgBtn(img: number, callback: btnCallback)
    self:addBtn(
        o.make("ImageButton", {
            BackgroundTransparency = 1,
            Image = u.asset(img)
        }, "Image"),
        callback
    )
end

function w:addContent(content: Instance)
    content.Parent = self.content
end

function w:updTopbarSize(num: number)
    self.topbar.Size = u.posWithOffset(1, 0, 0, num)
    self.content.Size = u.posWithOffset(1, 0, 1, -num)
    self.content.Position = u.posWithOffset(0, 0, 0, num)
end

function w:makeBar(x: number, y: number): UIDragDetector
    return o.dragDetect(o.make("Frame", {
        Parent = self.ui,
        Position = u.pos(
            u.boolToBit(x == 1),
            u.boolToBit(y == 1)
        ),
        Size = u.posWithOffset(
            u.boolToBit(x == 0),
            u.unaryWithBool(Config.Sizing.WindowResizeThickness, x ~= -1),
            u.boolToBit(y == 0),
            u.unaryWithBool(Config.Sizing.WindowResizeThickness, y ~= -1)
        ),
        BackgroundTransparency = 1
    }))
end

function w.resizeAmount(
    thingy: number,
    originPos: number,
    originSize: number,
    change: number,
    min: number,
    max: number
): (number, number)
    local size = math.clamp(change * thingy + originSize, min, max)
    return
        math.clamp((thingy == -1 and -size + originSize or 0) + originPos, 0, 1 - size),
        size
end

function w:sendToLayer(layer: number?)
    local amount = #self.windows
    layer = layer or amount
    if self.screen.DisplayOrder == layer then return end
    u.remove(w.windows, self)
    table.insert(w.windows, layer :: number, self)
    for z, win in w.windows do
        win.screen.DisplayOrder = z
    end
end

function w:maximise(maximised: boolean?)
    local maxi = maximised ~= false
    if self.maximised == maxi then
        return
    end
    self.maximised = maxi
    local pos
    local size
    local padding
    if maxi then
        self.lastPos = self.ui.Position
        self.lastSize = self.ui.Size
        pos = u.pos0
        size = u.pos1
        padding = UDim.new(0, Config.Sizing.TopbarInsetWhenMaximised)
        self:sendToLayer()
    else
        pos = self.lastPos
        size = self.lastSize
        padding = UDim.new()
    end
    s.TweenService:Create(
        self.ui,
        Config.Window.MaximiseAnimation,
        {Position = pos, Size = size}
    ):Play()
    s.TweenService:Create(
        self.topbarInsetPad,
        Config.Window.MaximiseAnimation,
        {PaddingLeft = padding}
    ):Play()
end

function w:minimise()
    self:maximise(false)
end

function w:toggleMaximised()
    self:maximise(not self.maximised)
end

function w:enableTwen(inst: Instance, prop: string): Tween
    inst[prop] = u.boolToBit(self.enabled)
    local twen = s.TweenService:Create(
        inst,
        Config.Window.FadeAnimation,
        {[prop] = u.boolToBit(not self.enabled)}
    )
    twen:Play()
    return twen
end

function w:enable(enabled: boolean?)
    local enab = enabled ~= false
    if self.enabled == enab then
        return
    end
    if self.modaler then
        self.modaler.Modal = enab
    end
    self.enabled = enab
    self.ui.Visible = true
    w.modals[self] = enabled or nil
    self:enableTwen(self.ui, "GroupTransparency").Completed:Once(function()
        self.ui.Visible = enab
    end)
    self:enableTwen(self.stro, "Transparency")
    if enab then
        self:sendToLayer()
    end
end

function w:disable()
    self:enable(false)
end

function w:toggle()
    self:enable(not self.enabled)
end

function w:destroy()
    self.screen:Destroy()
    u.remove(w.windows, self)
end

g.camUpd(Config.Sizing.Topbar, function(num)
    w.topbarSize = num
    for _, win in w.windows do
        win:updTopbarSize(num)
    end
end)

---- version ----

v.currentVersionReadSuccess, v.currentVersion = u.httpGet(Config.General.CurrentVersionUrl)
v.versionHistoryReadSuccess, v.versionHistory = u.httpGet(Config.General.VersionHistoryUrl)
v.lastVersionReadSuccess, v.lastVersion = u.readFile(Config.General.LastVersionPath)
v.lastVersionWriteSuccess = false
if v.currentVersionReadSuccess then
   v.lastVersionWriteSuccess = u.writeFile(Config.General.LastVersionPath, v.currentVersion)
end

do
    local send = n.capSend()
    local img = if v.currentVersionReadSuccess then Config.Images.ExpressionlessEgg else Config.Images.HUHEgg
    function v.versionNotif()
        send(img, v.currentVersion, {"Ok"})
    end
end

do
    local fn
    if v.versionHistoryReadSuccess then
        local changelogs = w.newEzier(.4, .3, .6, "Changelogs")
        local scroll = o.scroll(changelogs.content, u.pos0, u.pos1)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.None
        local txt = o.make("TextLabel", {
            Text = v.versionHistory,
            Size = u.pos1,
            Position = u.pos0,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextScaled = false,
            TextWrapped = false,
            Parent = scroll,
        }, "Text")
        local params = o.make("GetTextBoundsParams", {
            Width = 0,
            RichText = false,
        })
        g.camUpd(Config.Sizing.ChangelogText, function(num)
            txt.TextSize = num
            params.Text = txt.Text
            params.Font = txt.FontFace
            params.Size = num
            scroll.CanvasSize = u.fromV2(s.TextService:GetTextBoundsAsync(params))
        end)
        fn = function()
            changelogs:toggle()
        end
    else
        local send = n.HUH()
        fn = function()
            send(v.versionHistory, {"Ok"})
        end
    end
    v.openChangelogs = fn
end


---- autofill ----

a.ui = o.thingy("CanvasGroup", g.ui)
a.scroll = o.scroll(a.ui, nil, u.pos1)
a.ui.ZIndex = 1
a.ui.Visible = false
o.strocorn(a.ui)
a.btns = {}
a.btnSize = 0

function a.place(box: TextBox)
    a.ui.Position = u.posOff(
        g.mouse.X,
        g.mouse.Y
    )
end

function a.clear()
    for idx, btn in a.btns do
        a.btns[idx] = nil
        btn:Destroy()
    end
end

function a.addBtn(txt: string, box: TextBox, idx: number)
    local btn = o.txt(a.scroll, u.posOff(0, a.btnSize * (idx - 1)), u.posWithOffset(1, 0, 0, a.btnSize), txt, 0, true, "Secondary")
    o.stro(btn)
    u.insert(a.btns, btn)
    btn:GetPropertyChangedSignal("GuiState"):Connect(function()
        if btn.GuiState ~= Enum.GuiState.Press then return end
        box.Text = txt
        box:ReleaseFocus()
    end)
end

a.notifKeys = {}
type suggestCheck = (string) -> string?
a.id = 0
function a.suggest(box: TextBox, suggestions: {string}, check: suggestCheck)
    local id = a.id
    box:GetPropertyChangedSignal("Text"):Connect(function()
        a.clear()
        local filter = u.filter(suggestions, box.Text)
        local filterAmount = #filter
        if box.Text == "" or filterAmount == 0 then
            a.ui.Visible = false
            return
        end
        a.ui.Size = u.posWithOffset(.15, 0, 0, a.btnSize * math.min(filterAmount, 3))
        a.ui.Visible = true
        a.place(box)
        for idx, str in filter do
            a.addBtn(str, box, idx)
        end
    end)
    box.FocusLost:Connect(function()
        s.RunService.RenderStepped:Wait()
        a.ui.Visible = false
        a.clear()
        if box.Text == "" then return end
        local err = check(box.Text)
        if not err then return end
        box.Text = ""
        if a.notifKeys[id] then return end
        a.notifKeys[id] = true
        n.send(Config.Images.HUHEgg, err, {"Ok"}, function()
            a.notifKeys[id] = nil
        end)
    end)
    a.id += 1
end

g.camUpd(Config.Sizing.SuggestionButton, function(num)
    a.btnSize = num
end)

---- highlight ----

h.__index = h
h.highlightAmount = 0
h.notified = false
h.err = n.sad()
type highlightData = {tag: string, off: boolean?, col: Color3?}

function h.new()
    return setmetatable({boxes = {}}, h)
end

function h:updCn()
    local boxes = self.boxes
    for _ in boxes do
        if self.cn then
            return
        end
        self.cn = j.add(s.RunService.RenderStepped:Connect(function()
            local ping = g.ping
            for model, data in boxes do
                if not model.Parent then
                    self:removeHighlight(model, data)
                    continue
                end
                local cf, size = model:GetBoundingBox()
                if data.off ~= nil then
                    cf += g.getVelocity(model) * u.unaryWithBool(ping, data.off)
                end
                data.part.CFrame = cf
                data.tag.StudsOffsetWorldSpace = Vector3.yAxis * size.Y / 2
                data.box.Size = size
            end
        end))
        return
    end
    j.remove(self.cn)
    self.cn = nil
end

function h:addHighlight(model: Model, data: highlightData)
    if h.highlightAmount >= Config.Highlight.MaxAmount and not h.notified then
        h.err("Max highlights reached", {"Ok"})
        h.notified = false
        return
    elseif h.highlightAmount < Config.Highlight.MaxAmount then
        h.notified = false
    end
    h.highlightAmount += 1
    local tag = data.tag
    local col = data.col or u.nameColour(tag)
    local part = o.part(workspace, nil, nil, true)
    local nameTag = j.add(o.make("BillboardGui", {
        AlwaysOnTop = true,
        Size = u.posWithOffset(5, 100, 1.25, 25),
        Adornee = part,
        Parent = workspace,
        ExtentsOffsetWorldSpace = Vector3.yAxis,
        ResetOnSpawn = false
    })) :: BillboardGui
    local txt = o.txt(nameTag, nil, u.pos1, tag, 1)
    txt.TextColor3 = col
    o.make("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Thickness = 0.05,
        Parent = txt
    })
    self.boxes[model] = {
        part = part,
        tag = nameTag,
        box = j.add(o.make("BoxHandleAdornment", {
            Adornee = part,
            Parent = workspace,
            Color3 = col,
            Transparency = Config.Highlight.Transparency,
            Shading = Enum.AdornShading.XRay
        })),
        off = data.off
    }
    self:updCn()
end

function h:removeHighlight(model: Model, data: any)
    data.part:Destroy()
    data.box:Destroy()
    data.tag:Destroy()
    self.boxes[model] = nil
    h.highlightAmount -= 1
    self:updCn()
end

function h:removeHighlightNice(model: Model)
    local data = self.boxes[model]
    if not data then
        return
    end
    self:removeHighlight(model, data)
end

function h:highlight(models: {[Model]: highlightData})
    for model, data in models do
        self:addHighlight(model, data)
    end
end

function h:unhighlight()
    for model, stuff in self.boxes do
        self:removeHighlight(model, stuff)
    end
end

---- main window ----

m.win = w.newEzier(0.5, 0.3, 0.7, "Eggsploits", false, false, true)

o.paddingEzy(m.win.content, .05, .05, .1, .1)

m.nav = o.make("Frame", {
    Position = u.pos(.9),
    Size = u.pos(.1, 1),
    Parent = m.win.content
}, "Secondary")
o.strocorn(m.nav)
o.list(m.nav, nil, nil, Enum.HorizontalAlignment.Center, Enum.UIFlexAlignment.SpaceEvenly, 0.05)

m.padding = 1.25
m.panel = o.make("Frame", {
    Parent = m.win.content,
    Position = u.pos0,
    Size = u.pos(.85, 1),
    BackgroundTransparency = 1,
    ClipsDescendants = true
})
m.sections = {}
m.currentSection = 0
m.listPadding = 0
m.frameSize = 0
m.frames = {}
m.pads = {}
m.lists = {}

function m.goToSection(idx: number)
    if m.currentSection == idx then
        return
    end
    for i, section in m.sections do
        local color = i == idx and Config.Section.ButtonActiveColor or Config.Section.ButtonInactiveColor
        local pos = u.pos((i - idx) * m.padding)
        if section[1].ImageColor3 ~= color then
            s.TweenService:Create(
                section[1],
                Config.Section.SwitchAnimation,
                {ImageColor3 = color}
            ):Play()
        end
        if section[2].Position ~= pos then
            s.TweenService:Create(
                section[2],
                Config.Section.SwitchAnimation,
                {Position = pos}
            ):Play()
        end
    end
end

function m.addSection(img: number, stuff: {{GuiObject}})
    local sectionAmount = #m.sections
    local btn:ImageButton = o.img(m.nav, nil, u.pos1, img, 1, true)
    btn.ImageColor3 = Config.Section.ButtonInactiveColor
    btn.SizeConstraint = Enum.SizeConstraint.RelativeXX
    o.flex(btn)
    btn.Activated:Connect(function()
        m.goToSection(sectionAmount + 1)
    end)
    local scroll = o.scroll(m.panel, u.pos(sectionAmount * m.padding), u.pos1)
    o.padding(scroll, 0, 0, 0.05, scroll.ScrollBarThickness)
    u.insert(m.lists, o.list(scroll, nil, nil, nil, nil, 0, m.listPadding))
    for _, thingos in stuff do
        local frame = o.make("Frame", {
            Parent = scroll,
            BackgroundTransparency = 1,
            Size = u.posWithOffset(1, 0, 0, m.frameSize)
        })
        o.stroPad(frame)
        o.list(frame, true, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center, Enum.UIFlexAlignment.SpaceEvenly, 0.1)
        for _, thing in thingos do
            thing.Parent = frame
            o.flex(thing)
            o.strocorn(thing)
        end
        u.insert(m.frames, frame)
    end
    u.insert(m.sections, {btn, scroll})
end

function m.btn(txt: string, call: btnCallback): TextButton
    local btn = o.txt(nil, nil, u.pos1, txt, 0, true, "Secondary")
    btn.Activated:Connect(call)
    return btn
end

function m.box(txt: string, suggestions: {string}, check: suggestCheck)
    local box = o.txtBox(nil, nil, u.pos1, txt, 0, "Secondary")
    a.suggest(box, suggestions, check)
    return box
end

m.env = {}
m.env.__index = m.env

function m.env.new(...: any)
    return setmetatable({
        vars = {...},
        stuff = {},
        varIdx = 0,
        err = n.HUH(),
    }, m.env)
end

type envFn = ({any}, InputObject, number) -> (string?)

function m.env:doErr(str: string?)
    if str then
        self.err(str, {"Ok"})
    end
end

function m.env:btn(txt: string, fn: envFn)
    u.insert(self.stuff, m.btn(txt, function(input: InputObject, clicks: number)
        self:doErr(fn(self.vars, input, clicks))
    end))
    return self
end

function m.env:getIdx(): number
    self.varIdx += 1
    return self.varIdx
end

function m.env:toggle(txt: string, unTxt: string, on: envFn?, off: envFn?)
    local idx = self:getIdx()
    local btn
    btn = m.btn(txt, function(input: InputObject, clicks: number)
        local flipped = not self.vars[idx]
        self.vars[idx] = flipped
        local fn
        if flipped then
            fn = on
            btn.Text = unTxt
        else
            fn = off
            btn.Text = txt
        end
        if fn then
            local err = fn(self.vars, input, clicks)
            if err then
                self.vars[idx] = false
                btn.Text = txt
            end
            self:doErr(err)
        end
    end)
    u.insert(self.stuff, btn)
    return self
end

function m.env:box(txt: string, suggestions: {string}, check: (string) -> (any, string?))
    local idx = self:getIdx()
    u.insert(self.stuff, m.box(txt, suggestions, function(str: string)
        local val, err = check(str)
        if not err then
            self.vars[idx] = val
        end
        return err
    end))
    return self
end

do
    local stickies = 0
    local send = n.HUH()
    function m.stickyNote(txt: string?)
        if stickies == 25 then
            send("Error: TOO MANY STICKY NOTES", {"Ok"})
            return
        end
        local note = w.newEzier(.2, .15, .25, "Sticky note", true)
        local box = o.txtBox(note.content, nil, u.pos1, "Type something")
        box:CaptureFocus()
        box.Text = txt or ""
        note:addTxtBtn("X", function()
            note:destroy()
            stickies -= 1
        end)
        note:enable()
        stickies += 1
    end
end

g.camUpd(Config.Sizing.Frame, function(num)
    m.frameSize = num
    for _, frm in m.frames do
        frm.Size = u.posWithOffset(1, 0, 0, num)
    end
end)

g.camUpd(Config.Sizing.StrokeThickness, function(num)
    o.stroThickness = num
    for _, stro in o.stros do
        stro.Thickness = num
    end
    local udim = UDim.new(0, num)
    for _, pad in o.stroPads do
        o.setPad(pad, udim)
    end
end)

g.camUpd(Config.Sizing.ListPadding, function(num)
    m.listPadding = num
    local udim = UDim.new(0, num)
    for _, list in m.lists do
        list.Padding = udim
    end
end)

do
    local plrNames = {}
    local plrNamesToPlr = {}
    local function plrAdded(plr: Player)
        plrNamesToPlr[plr.Name] = plr
        if plr == g.plr then return end
        u.insert(plrNames, plr.Name)
    end
    for _, plr in s.Players:GetPlayers() do
        plrAdded(plr)
    end
    j.add(s.Players.PlayerAdded:Connect(plrAdded))
    j.add(s.Players.PlayerRemoving:Connect(function(plr)
        u.remove(plrNames, plr.Name)
        plrNamesToPlr[plr.Name] = nil
    end))
    local function plrCheck(name: string)
        local plr = plrNamesToPlr[name]
        if plr then
            return plr
        elseif plr == g.plr then
            return nil, "That is u 🙏"
        end
        return nil, "Must be a player"
    end

    local function plrCheckAgain(plr: Player?): string?
        if not plr then
            return "Select a player"
        end
        if not plr.Parent then
            return `{plr.Name} is no longer in the game`
        end
        if not plr.Character then
            return `{plr.Name} has no character`
        end
        return
    end

    local closestPlr
    local closestChar
    local closestPlrPos
    local closestPlrDir
    j.add(s.RunService.PostSimulation:Connect(function()
        local closestMag
        local gpos = g.char:GetPivot().Position
        for _, plr in plrNamesToPlr do
            if plr == g.plr then return end
            local char = plr.Character
            if not char then continue end
            local pos = char:GetPivot().Position
            local dir = pos - gpos
            local mag = dir.Magnitude
            if not closestMag or mag < closestMag then
                closestPlr = plr
                closestChar = char
                closestPlrPos = pos
                closestPlrDir = dir
                closestMag = mag
            end
        end
    end))

    local function numberCheck(num: string)
        local to = tonumber(num)
        if not to then
            return nil, "Must be a number"
        end
        return to
    end

    local function positiveCheck(num: string)
        local to = tonumber(num)
        if not to then
            return nil, "Must be a number"
        end
        if to < 0 then
            return nil, "Must be over 0"
        end
        return to
    end

    local function numberRangeCheck(min: number, max: number)
        return function(str)
            local to = tonumber(str)
            if not to then
                return nil, "Must be a number"
            end
            if to < min or to > max then
                return nil, "Must be between {min} and {max}"
            end
            return to
        end
    end

    local function integerRangeCheck(min: number, max: number)
        return function(str)
            local to = tonumber(str)
            if not to then
                return nil, "Must be a number"
            end
            if to % 1 ~= 0 then
                return nil, "Must be an integer"
            end
            if to < min or to > max then
                return nil, "Must be between {min} and {max}"
            end
            return to
        end
    end

    local yesNo = {"yes", "no"}
    local function yesNoCheck(str: string)
        str = str:lower()
        if str == "yes" then
            return true
        elseif str == "no" then
            return false
        end
        return nil, "Must be yes or no"
    end

    local speeds = {"10", "50", "100", "500", "1000"}

    do -- You
        local stuff = {}
        do -- fly
            local cn
            local velocity
            local gyro
            u.insert(
                stuff,
                m.env.new(false, 100)
                :toggle(
                    "Fly",
                    "Unfly",
                    function(vars: {any})
                        velocity = o.make(
                            "LinearVelocity",
                            {
                                ForceLimitsEnabled = false,
                                Parent = workspace
                            }
                        )
                        gyro = o.make(
                            "AlignOrientation",
                            {
                                Mode = Enum.OrientationAlignmentMode.OneAttachment,
                                RigidityEnabled = true,
                                Parent = workspace
                            }
                        )
                        cn = j.add(s.RunService.RenderStepped:Connect(function()
                            local cameraCf = workspace.CurrentCamera.CFrame
                            local look = (cameraCf.LookVector * Vector3.new(1, 0, 1)).Unit
                            local move = g.hum.MoveDirection.Unit
                            velocity.VectorVelocity = (
                                cameraCf.LookVector * u.removeNan(look:Dot(move)) +
                                cameraCf.RightVector * u.removeNan(cameraCf.RightVector:Dot(move))
                            ) * vars[2]
                            gyro.CFrame = cameraCf
                            velocity.Attachment0 = g.att
                            gyro.Attachment0 = g.att
                            for _, track in g.anim:GetPlayingAnimationTracks() do
                                track:Stop()
                            end
                        end))
                    end,
                    function()
                        velocity:Destroy()
                        gyro:Destroy()
                        j.cleanUpSingle(cn)
                    end
                )
                :box(
                    "Speed",
                    speeds,
                    positiveCheck
                )
                .stuff
            )
        end

        do -- setwalk
            local last = 0
            local cn
            u.insert(
                stuff,
                m.env.new(false, 32)
                :toggle(
                    "Set walk",
                    "Unset walk",
                    function(vars)
                        last = g.hum.WalkSpeed
                        cn = j.add(s.RunService.RenderStepped:Connect(function(delta)
                            g.hum.WalkSpeed = vars[2]
                        end))
                    end,
                    function()
                        g.hum.WalkSpeed = last
                        j.cleanUpSingle(cn)
                    end
                )
                :box(
                    "Pace",
                    speeds,
                    positiveCheck
                )
                .stuff
            )
        end

        do -- setjump
            local last = 0
            local cn
            u.insert(
                stuff,
                m.env.new(false, 100)
                :toggle(
                    "Set jump",
                    "Unset jump",
                    function(vars)
                        last = g.hum.JumpHeight
                        cn = j.add(s.RunService.RenderStepped:Connect(function(delta)
                            g.hum.JumpHeight = vars[2]
                        end))
                    end,
                    function()
                        g.hum.JumpHeight = last
                        j.cleanUpSingle(cn)
                    end
                )
                :box(
                    "Power",
                    speeds,
                    positiveCheck
                )
                .stuff
            )
        end

        do -- infinite jump
            local cn
            u.insert(
                stuff,
                m.env.new(false, 32)
                :toggle(
                    "Infinite jump",
                    "Finite jump",
                    function()
                        cn = j.add(s.UserInputService.JumpRequest:Connect(function()
                            g.hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        end))
                    end,
                    function()
                        j.cleanUpSingle(cn)
                    end
                )
                .stuff
            )
        end

        u.insert( -- noclip
            stuff,
            m.env.new(false)
            :toggle(
                "Noclip",
                "Unnoclip",
                function(vars)
                    local cn
                    cn = j.add(s.RunService.PreSimulation:Connect(function()
                        local noclipping = vars[1]
                        for _, part in g.char:GetDescendants() do
                            if not part:IsA("BasePart") then
                                continue
                            end
                            part.CanCollide = not noclipping
                        end
                        if not noclipping then
                            j.cleanUpSingle(cn)
                        end
                    end))
                end
            )
            .stuff
        )

        do -- tp
            local suggestions = {"-1000", "-500", "-100", "-50", "50", "100", "500", "1000"}
            u.insert(
                stuff,
                m.env.new(false, 0, 0, 0)
                :btn(
                    "Tp",
                    function(vars)
                        g.tp(unpack(vars))
                    end
                )
                :box(
                    "X",
                    suggestions,
                    numberCheck
                )
                :box(
                    "Y",
                    suggestions,
                    numberCheck
                )
                :box(
                    "Z",
                    suggestions,
                    numberCheck
                )
                .stuff
            )
        end

        do -- coords
            local send = n.normal(3)
            u.insert(stuff, {
                m.btn("Coords", function()
                if not g.root then
                    return
                end
                local pos = g.root.Position:Floor()
                local txt = `{pos.X}, {pos.Y}, {pos.Z}`
                send(txt, {"Ok", "Print"}, function(idx)
                    if idx ~= 2 then
                        return
                    end
                    m.stickyNote(txt)
                end)
            end)
            })
        end

        do -- anchor
            local cn
            u.insert(
                stuff,
                m.env.new(false)
                :toggle(
                    "Anchor",
                    "Unanchor",
                    function(vars)
                        cn = j.add(s.RunService.RenderStepped:Connect(function()
                            local anchored = vars[1]
                            g.root.Anchored = anchored
                            if not anchored then
                                j.cleanUpSingle(cn)
                            end
                        end))
                    end
                )
                .stuff
            )
        end

        do -- wallheck yourself
            local high = h.new()
            local vars
            local function upd()
                high:unhighlight()
                if not vars[1] then return end
                high:addHighlight(g.char, {tag = "", col = u.nameColour(g.plr.Name), off = vars[2]})
            end
            j.add(g.plr.CharacterAdded:Connect(upd))
            local env = m.env.new(false)
                :toggle(
                    "Wallheck yourself",
                    "Unwallheck yourself",
                    upd,
                    upd
                )
                :box(
                    "Guess actual position",
                    yesNo,
                    function(str)
                        local yes, err = yesNoCheck(str)
                        if err then
                            return nil, err
                        end
                        local actual =
                            if yes
                            then false
                            else nil
                        for _, data in high.boxes do
                            data.off = actual
                        end
                        return actual
                    end
                )
            vars = env.vars
            u.insert(
                stuff,
                env.stuff
            )
        end

        m.addSection(Config.Images.YouIcon, stuff)
    end

    do -- Players
        local stuff = {}

        do -- fling
            local cn
            u.insert(
                stuff,
                m.env.new(false, 100)
                :toggle(
                    "Fling",
                    "Unfling",
                    function(vars)
                        cn = j.add(s.RunService.Heartbeat:Connect(function()
                            local root = g.root
                            local vel = root.AssemblyLinearVelocity
                            root.AssemblyLinearVelocity = (
                                vel +
                                if closestPlrDir
                                then closestPlrDir.Unit
                                else Config.General.Random:NextUnitVector()
                            ) * vars[2]
                            print(closestPlrDir)
                            s.RunService.RenderStepped:Wait()
                            root.AssemblyLinearVelocity = vel
                        end))
                    end,
                    function()
                        j.cleanUpSingle(cn)
                    end
                )
                :box(
                    "Speed",
                    speeds,
                    positiveCheck
                )
                .stuff
            )
        end

        u.insert( -- tp
            stuff,
            m.env.new(false, nil)
            :btn(
                "Tp",
                function(vars)
                    local plr = vars[1]
                    local err = plrCheckAgain(plr)
                    if err then
                        return err
                    end
                    local char = plr.Character
                    if not char then
                        return `{plr.Name} has no character`
                    end
                    g.tp(char)
                    return
                end
            )
            :box(
                "Player",
                plrNames,
                plrCheck
            )
            .stuff
        )

        do -- continuous tp
            local cn
            local last
            u.insert(
                stuff,
                m.env.new(false, nil)
                :toggle(
                    "Tp continuous",
                    "Stop tp continuous",
                    function(vars)
                        local err = plrCheckAgain(vars[2])
                        if err then
                            return err
                        end
                        last = g.char:GetPivot()
                        cn = j.add(s.RunService.RenderStepped:Connect(function()
                            local plr = vars[2]
                            local char = plr.Character
                            if not char then
                                return
                            end
                            g.tp(plr.Character)
                        end))
                        return
                    end,
                    function()
                        j.cleanUpSingle(cn)
                        g.tp(last)
                        g.stay()
                    end
                )
                :box(
                    "Player",
                    plrNames,
                    plrCheck
                )
                .stuff
            )
        end

        do -- wallheck players
            local high = h.new()
            local vars
            local cns = {}
            local chars = {}
            local function add(plr, char)
                local tag = plr.Name
                high:addHighlight(char, {
                    tag = tag,
                    col = u.nameColour(tag),
                    off = vars[2]
                })
            end
            local function upd()
                high:unhighlight()
                if not vars[1] then
                    return
                end
                for plr, char in chars do
                    add(plr, char)
                end
            end
            local function addPlr(plr: Player)
                if plr == g.plr then
                    return
                end
                cns[plr] = j.add(plr.CharacterAdded:Connect(function(char)
                    chars[plr] = char
                    if vars[1] then
                        add(plr, char)
                    end
                end))
                local char = plr.Character
                chars[plr] = char
                if vars[1] and char then
                    add(plr, char)
                end
            end
            local env = m.env.new(false)
                :toggle(
                    "Wallheck players",
                    "Unwallheck players",
                    upd,
                    upd
                )
                :box(
                    "Guess actual position",
                    yesNo,
                    function(str)
                        local yes, err = yesNoCheck(str)
                        if err then
                            return nil, err
                        end
                        local actual =
                            if yes
                            then false
                            else nil
                        for _, data in high.boxes do
                            data.off = actual
                        end
                        return actual
                    end
                )
            vars = env.vars
            for _, plr in plrNamesToPlr do
                addPlr(plr)
            end
            s.Players.PlayerAdded:Connect(addPlr)
            s.Players.PlayerRemoving:Connect(function(plr)
                if plr == g.plr then return end
                high:removeHighlightNice(chars[plr])
                j.cleanUpSingle(cns[plr])
                cns[plr] = nil
                chars[plr] = nil
            end)
            u.insert(
                stuff,
                env.stuff
            )
        end

        do -- wallheck npcs
            local high = h.new()
            local vars
            local chars = {}
            local function add(char)
                local tag = char.Name
                high:addHighlight(char, {
                    tag = tag,
                    col = u.nameColour(tag),
                    off = vars[2]
                })
            end
            local function addHum(hum)
                if not hum:IsA("Humanoid") and not hum:IsA("AnimationController") then return end
                local char = hum.Parent
                if char == workspace or s.Players:GetPlayerFromCharacter(char) then return end
                chars[char] = true
                if vars[1] then
                    add(char)
                end
            end
            local function upd()
                high:unhighlight()
                if not vars[1] then
                    return
                end
                for char in chars do
                    add(char)
                end
            end
            local env = m.env.new(false)
                :toggle(
                    "Wallheck NPCs",
                    "Unwallheck NPCs",
                    upd,
                    upd
                )
                :box(
                    "Guess actual position",
                    yesNo,
                    function(str)
                        local yes, err = yesNoCheck(str)
                        if err then
                            return nil, err
                        end
                        local actual =
                            if yes
                            then false
                            else nil
                        for _, data in high.boxes do
                            data.off = actual
                        end
                        return actual
                    end
                )
            vars = env.vars
            j.add(workspace.DescendantAdded:Connect(addHum))
            for _, desc in workspace:GetDescendants() do
                addHum(desc)
            end
            j.add(workspace.DescendantRemoving:Connect(function(desc)
                chars[desc] = nil
                high:removeHighlightNice(desc)
            end))
            u.insert(
                stuff,
                env.stuff
            )
        end

        m.addSection(Config.Images.PlayersIcon, stuff)
    end

    do -- Objects
        local stuff = {}

        local base = o.part(
            nil,
            Vector3.new(
                2048,
                1,
                2048
            ),
            3,
            true,
            true
        )
        base.Material = Enum.Material.SmoothPlastic

        local function getParams()
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = {g.char, base}
            return params
        end

        local mouseCastsDown = {}
        local mouseCastsUp = {}
        local function addMouseCast(down: (RaycastResult) -> (), up: () -> ())
            u.insert(mouseCastsDown, down)
            u.insert(mouseCastsUp, up)
        end

        j.add(g.mouse.Button1Down:Connect(function()
            local cast = workspace:Raycast(
                g.cam.CFrame.Position,
                g.mouse.Hit.LookVector * 99999,
                getParams()
            )
            if not cast then return end
            for _, fn in mouseCastsDown do
                fn(cast)
            end
            g.mouse.Button1Up:Once(function()
                for _, fn in mouseCastsUp do
                    fn()
                end
            end)
        end))

        do -- baseplate
            local cn
            u.insert(
                stuff,
                m.env.new(false)
                :toggle(
                    "Add baseplate",
                    "Remove baseplate",
                    function()
                        base.Parent = workspace
                        local cf, size = g.char:GetBoundingBox()
                        local y = cf.Y - (size.Y + base.Size.Y) / 2
                        cn = j.add(s.RunService.PreSimulation:Connect(function()
                            local pos = g.root.Position
                            base.Position = Vector3.new(
                                pos.X,
                                y,
                                pos.Z
                            )
                        end))
                    end,
                    function()
                        base.Parent = nil
                        j.cleanUpSingle(cn)
                    end
                )
                .stuff
            )
        end

        do -- grappler
            local rope = o.make("RopeConstraint", {
                WinchEnabled = true,
                WinchForce = math.huge,
                Visible = true,
                Color = BrickColor.Black(),
                Thickness = 0.5,
                WinchSpeed = 100,
                Restitution = 1,
            })
            local env = m.env.new(false)
            addMouseCast(
                function(cast)
                    if not env.vars[1] then return end
                    rope.Parent = workspace
                    rope.Attachment0 = g.att
                    rope.Length = (cast.Position - g.root.Position).Magnitude
                    local att = o.make("Attachment", {
                        Parent = cast.Instance,
                        WorldCFrame = CFrame.new(cast.Position)
                    })
                    rope.Attachment1 = att
                end,
                function()
                    if rope.Parent == nil then return end
                    rope.Attachment1:Destroy()
                    rope.Parent = nil
                end
            )
            env
                :toggle(
                    "Grapple",
                    "Ungrapple"
                )
                :box(
                    "Winch speed",
                    speeds,
                    function(num)
                        local err = positiveCheck(num)
                        if err then
                            return err
                        end
                        rope.WinchSpeed = tonumber(num)
                        return
                    end
                )
            u.insert(
                stuff,
                env.stuff
            )
        end

        m.addSection(Config.Images.ObjectsIcon, stuff)
    end

    do -- Lighting
        local stuff = {}

        u.insert( -- remove shadows
            stuff,
            m.env.new(false)
            :toggle(
                "Remove shadows",
                "Add shadows",
                function(vars)
                    local cn
                    cn = j.add(s.RunService.RenderStepped:Connect(function()
                        local set = not vars[1]
                        s.Lighting.GlobalShadows = set
                        if set then
                            j.cleanUpSingle(cn)
                        end
                    end))
                end
            )
            .stuff
        )

        do -- remove effects
            local effects = {}
            local cn
            u.insert(
                stuff,
                m.env.new(false)
                :toggle(
                    "Remove effects",
                    "Add effects",
                    function()
                        cn = j.add(s.RunService.RenderStepped:Connect(function()
                            for _, thing in s.Lighting:GetChildren() do
                                effects[thing] = true
                                thing.Parent = nil
                            end
                        end))
                    end,
                    function()
                        j.cleanUpSingle(cn)
                        for thing in effects do
                            effects[thing] = nil
                            thing.Parent = s.Lighting
                        end
                    end
                )
                .stuff
            )
        end

        do -- set clocktime
            local timy = 0
            local cn
            u.insert(
                stuff,
                m.env.new(false, 5)
                :toggle(
                    "Set clock",
                    "Unset clock",
                    function(vars)
                        timy = s.Lighting.ClockTime
                        cn = j.add(s.RunService.RenderStepped:Connect(function()
                            s.Lighting.ClockTime = vars[2]
                        end))
                    end,
                    function()
                        j.cleanUpSingle(cn)
                        s.Lighting.ClockTime = timy
                    end
                )
                :box(
                    "Time",
                    {"6", "12", "18", "24"},
                    numberRangeCheck(0, 24)
                )
                .stuff
            )
        end

        do -- set brightness
            local bright = 0
            local cn
            u.insert(
                stuff,
                m.env.new(false, 5)
                :toggle(
                    "Set brightness",
                    "Unset brightness",
                    function(vars)
                        bright = s.Lighting.Brightness
                        cn = j.add(s.RunService.RenderStepped:Connect(function()
                            s.Lighting.Brightness = vars[2]
                        end))
                    end,
                    function()
                        j.cleanUpSingle(cn)
                        s.Lighting.Brightness = bright
                    end
                )
                :box(
                    "Time",
                    {"0", "2.5", "5", "7.5", "10"},
                    numberRangeCheck(0, 10)
                )
                .stuff
            )
        end

        m.addSection(Config.Images.LightingIcon, stuff)
    end

    do -- Misc
        local stuff = {}

        u.insert(stuff, {m.btn("Sticky note", function() -- sticky note
            m.stickyNote()
        end)})

        u.insert(stuff, { -- current version, changelogs
            m.btn("Version", v.versionNotif),
            m.btn("Changelogs", v.openChangelogs)
        })

        do -- aim trainer
            local win = w.newEzier(.6, .7, 0.5, "Aim trainer", nil, nil, true)
            win:maximise()
            local txt = o.txt(win.content, nil, u.pos1)
            local btn = o.txt(win.content, nil, nil, "X", 0, true, "Secondary")
            local vars
            o.strocorn(btn)
            local notif = n.normal(3)
            local function start()
                win:toggle()
                if not win.enabled then return end
                btn.Visible = false
                local size = vars[1] / 100
                local maxPos = 1 - size
                btn.Size = u.pos(size, size)
                local time = vars[2]
                local amount = vars[3]
                local amountPassed = 0
                local amountGotten = 0
                local startup
                local startupClock = 3
                local thread = coroutine.running()
                startup = j.add(s.RunService.RenderStepped:Connect(function(delta)
                    startupClock -= delta
                    local ceil = math.ceil(startupClock)
                    txt.Text = `{ceil}`
                    if ceil == 0 then
                        startup:Disconnect()
                        task.spawn(thread)
                    end
                    if not win.enabled then
                        startup:Disconnect()
                        task.cancel(thread)
                        txt.Text = ""
                    end
                end))
                coroutine.yield()
                txt.Text = ""
                btn.Visible = true
                for _ = 1, amount do
                    btn.Position = u.pos(
                        Config.General.Random:NextNumber(0, maxPos),
                        Config.General.Random:NextNumber(0, maxPos)
                    )
                    local delay
                    local cn = btn.Activated:Once(function()
                        amountGotten += 1
                        task.spawn(thread)
                        delay:Disconnect()
                    end)
                    local start = tick()
                    delay = j.add(s.RunService.RenderStepped:Connect(function()
                        if tick() - start < time and win.enabled then return end
                        cn:Disconnect()
                        delay:Disconnect()
                        task.spawn(thread)
                    end))
                    coroutine.yield()
                    if not win.enabled then break end
                    amountPassed += 1
                end
                notif(`You got {amountGotten}/{amountPassed} targets`, {"Ok"})
                win:disable()
            end

            local env = m.env.new(false, 25, 2, 10)
                :btn(
                    "Aim trainer",
                    start
                )
                :box(
                    "Size",
                    {"1", "25", "50", "75", "100"},
                    numberRangeCheck(1, 100)
                )
                :box(
                    "Time",
                    {"0.5", "1", "2", "3"},
                    numberRangeCheck(0.1, 5)
                )
                :box(
                    "Amount",
                    {"5", "20", "100"},
                    integerRangeCheck(1, 100)
                )
            vars = env.vars

            u.insert(
                stuff,
                env.stuff
            )
        end

        m.addSection(Config.Images.MiscIcon, stuff)
    end
end

m.goToSection(1)

---- button ----

b.win = w.new(.15, .2, .1, .15, .2, .25, "Open", true, true)
b.win.ui.Position = u.pos(.825, .05)

b.cred = w.newEzier(.25, .2, .3, "Credits")
o.txt(b.cred.content, nil, u.pos1, "Eggsploits made by Cabldebelegg at the request of Killercrusher9023")

do
    local send = n.sad()
    b.win:addTxtBtn("X", function()
        send("Remove Eggsploits?", {"Yes", "No"}, function(num)
            if num ~= 1 then return end
            g.remove()
        end)
    end)
end
b.win:addTxtBtn("?", function()
    b.cred:toggle()
end)
b.btn = o.img(b.win.content, nil, u.pos1, Config.Images.ExpressionlessEgg, 0, true, "Primary")
do
    local corn = o.corn(b.btn)
    local udim = UDim.new()
    local function upd()
        corn.TopLeftRadius = udim
        corn.TopRightRadius = udim
    end
    upd()
    corn:GetPropertyChangedSignal("CornerRadius"):Connect(upd)
end
o.txt(b.btn, u.pos(0.039,0.618), u.pos(0.922,0.312), `Click {Config.General.Open.Name}`)
b.btn.Activated:Connect(function()
    m.win:toggle()
end)

do
    local img = o.make("ImageLabel") :: ImageLabel
    for _, id in Config.Images do
        img.Image = u.asset(id)
        s.ContentProvider:PreloadAsync({img})
    end
end

do
    local canvas = o.make("CanvasGroup", {
        Parent = g.ui,
        Position = u.pos0,
        Size = u.pos1,
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.5,
        GroupTransparency = 1,
    })
    local image = o.img(
        canvas,
        u.pos(
            .369,
            .268
        ),
        u.pos(
            .262,
            .463
        ),
        Config.Images.ExpressionlessEgg
    )
    local bar = o.make("UIGradient", {
        Parent = image,
        Rotation = -90
    })
    local sequence = ColorSequence.new
    local keypoint = ColorSequenceKeypoint.new
    local imageColourTop = Config.Loading.ImageColourTop
    local imageColourBottom = Config.Loading.ImageColourBottom
    local function setLoadedPercent(pos: number)
        bar.Color = sequence({
            keypoint(0, imageColourBottom),
            keypoint(math.max(pos, 0), imageColourBottom),
            keypoint(math.min(pos + 0.01, 1), imageColourTop),
            keypoint(1, imageColourTop)
        })
    end
    setLoadedPercent(0)
    local txt = o.make("TextLabel", {
        Parent = canvas,
        Position = u.pos(
            .312,
            .675
        ),
        Size = u.pos(
            .375,
            .114
        ),
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Text = "Loading Eggsploits..."
    }, "Text")
    o.make("UIStroke", {
        Parent = txt,
        Thickness = 0.1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    })
    local shimmer = o.make("UIGradient", {
        Parent = txt,
        Rotation = -180
    })
    local shimmerSize = Config.Loading.ShimmerSize / 2
    local txtColour = Config.Loading.TextColour
    local shimmerColour = Config.Loading.TextShimmerColour
    local function setShimmerPos(pos: number)
        shimmer.Color = sequence({
            keypoint(0, txtColour),
            keypoint(math.clamp(pos - shimmerSize, 0.001, 0.997), txtColour),
            keypoint(math.clamp(pos, 0.002, 0.998), shimmerColour),
            keypoint(math.clamp(pos + shimmerSize, 0.003, 0.999), txtColour),
            keypoint(1, txtColour)
        })
    end
    setShimmerPos(0)
    local percentPos = 0
    local currentPercentPos = 0
    local percentSpeed = Config.Loading.PercentFeedBackSpeed
    local percentExponent = Config.Loading.PercentExponent
    local shimmerPos = 0
    local shimmerSpeed = Config.Loading.ShimmerSpeed
    local shimmerTime = 0
    local shimmerDebounce = false
    local shimmerDebounceTime = Config.Loading.ShimmerDebounceTime
    local shimmerExponent = Config.Loading.ShimmerExponent
    local onePlusShimmerSize = 1 + shimmerSize
    local cn = j.add(s.RunService.RenderStepped:Connect(function(delta)
        currentPercentPos = math.lerp(currentPercentPos, percentPos, percentSpeed)
        setLoadedPercent(currentPercentPos ^ percentExponent)
        if shimmerDebounce then
            return
        end
        shimmerPos = math.lerp(0, onePlusShimmerSize, shimmerTime * shimmerSpeed)
        shimmerTime += delta
        if shimmerPos > onePlusShimmerSize then
            shimmer.Color = sequence(txtColour)
            shimmerDebounce = true
            task.wait(shimmerDebounceTime)
            shimmerDebounce = false
            shimmerTime = 0
        else
            setShimmerPos(shimmerPos ^ shimmerExponent)
        end
    end))
    local startTwen = s.TweenService:Create(
        canvas,
        Config.Loading.StartAnimation,
        {GroupTransparency = 0}
    )
    startTwen:Play()
    startTwen.Completed:Wait()
    local stuff = g.ui:GetDescendants()
    local amount = 1/#stuff
    for _, thing in stuff do
        s.ContentProvider:PreloadAsync({thing})
        percentPos += amount
    end
    local endTwen = s.TweenService:Create(
        canvas,
        Config.Loading.EndAnimation,
        {GroupTransparency = 1}
    )
    endTwen:Play()
    endTwen.Completed:Wait()
    canvas:Destroy()
    j.cleanUpSingle(cn)
    task.wait(Config.Loading.AfterWait)
end

b.win:enable()

j.add(s.UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Config.General.Open then
        m.win:toggle()
    end
end))

n.send(Config.Images.ExpressionlessEgg, "Eggsploits initialised", {"Ok"})

task.wait(Config.General.UpdateNotificationWait)

if v.currentVersionReadSuccess and v.lastVersionReadSuccess and v.currentVersion ~= v.lastVersion then
    n.send(Config.Images.ExpressionlessEgg, `Updated to {v.currentVersion}`, {"Changelogs"}, function(idx)
        if idx ~= 1 then return end
        v.openChangelogs()
    end)
end