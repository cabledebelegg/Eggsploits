local Config = {
    General = {
        Open = Enum.KeyCode.Minus,
        PingUpdateTime = 3,
        InitTable = shared,
        InitKey = "EggsploitsInitialised i swear if this key is already part of init table im done XD",
        ChangeLogsFile = "https://raw.githubusercontent.com/cabledebelegg/Eggsploits/refs/heads/main/Changes.log"
    },
    Highlight = {
        Transparency = 1/4,
        MaxAmount = 100,
    },
    Notification = {
        Time = 7.5,
        Animation = TweenInfo.new(
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
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
        ChangeLogLine = 1/20,
    },
    Style = {
        Text = {
            TextScaled = true,
            FontFace = Font.fromEnum(Enum.Font.FredokaOne),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(0, 0, 0)
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
        },
        Secondary = {
            BackgroundColor3 = Color3.fromRGB(232, 185, 17),
        },
        Tertiary = {
            BackgroundColor3 = Color3.fromRGB(131, 107, 23)
        },
        Stroke = {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        },
        Scroll = {
            BorderSizePixel = 0,
            ScrollBarImageColor3 = Color3.new(),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(0,0)
        }
    },
    EggImages = {
        Normal = 95063492825713,
        HUH = 118621106143064,
        Sad = 75952115388174,
        XD = 126710606924682
    },
    SectionImages = {
        You = 7992557358,
        Players = 124929180840291,
        Objects = 12988752403,
        Lighting = 74888619733969,
        Misc = 9405921255,
    }
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end
if Config.General.InitTable[Config.General.InitKey] then
    Config.General.InitTable[Config.General.InitKey]("Already initialised silly!", {"Ok"})
    return
end

---- utils, object, global, notification, window, suggestions, highlight, main, button ----
local u = {}
local o = {}
local g = {}
local n = {}
local w = {}
local s = {}
local h = {}
local m = {}
local b = {}

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

function u.dcn(tb: {RBXScriptConnection}, cn: RBXScriptConnection)
    u.remove(tb, cn)
    if cn.Connected then
        cn:Disconnect()
    end
end

function u.dcnAll(tb: {RBXScriptConnection})
    for idx, cn in tb do
        cn:Disconnect()
        tb[idx] = nil
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

function u.rmNan(num: number): number
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

---- object ----

function o.mould(inst: Instance, props: {[string]: any}?, ...: string)
    for _, tag in {...} do
        local tprops = Config.Style[tag]
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

function o.make(class: string, props: {[string]: any}?, ...: string)
    local inst = Instance.new(class)
    o.mould(
        inst,
        props,
        ...
    )
    return inst
end

function o.clone(inst: Instance, props: {[string]: any}, ...: string)
    o.mould(
        inst:Clone(),
        props,
        ...
    )
end

o.stros = {}
o.stroThickness = 0

function o.stro(parent: Instance?)
    u.insert(o.stros, o.make("UIStroke", {
        Parent = parent,
        Thickness = o.stroThickness,
    }, "Stroke"))
end

o.corns = {}
o.cornRadius = UDim.new()

function o.corn(parent: Instance?)
    u.insert(o.corns, o.make("UICorner", {
        Parent = parent,
        CornerRadius = o.cornRadius
    }))
end

function o.strocorn(parent: Instance?)
    o.stro(parent)
    o.corn(parent)
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
    local img = o.thingy(`Image{u.buttonOrLabel(btn)}`, parent, pos, size, bgTransparency, ...)
    img.Image = u.asset(id)
    img.ScaleType = Enum.ScaleType.Fit
    return img
end

function o.txt(parent: Instance?, pos: UDim2?, size: UDim2?, txt: string?, bgTransparency: number?, btn: boolean?, ...: string): any
    local kllgvj = o.thingy(`Text{u.buttonOrLabel(btn)}`, parent, pos, size, bgTransparency, "Text", ...)
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

function o.flex(parent: Instance?, mode: Enum.UIFlexMode?)
    o.make("UIFlexItem", {
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

---- global ----

g.run = game:GetService("RunService")
g.twen = game:GetService("TweenService")
g.uis = game:GetService("UserInputService")
g.light = game:GetService("Lighting")
g.plrs = game:GetService("Players")
g.plr = g.plrs.LocalPlayer
g.mouse = g.plr:GetMouse()
g.cns = {}
g.toDestroy = {}

function g.addToDestroy<T>(inst: T): T
    u.insert(g.toDestroy, inst)
    return inst
end

function g.cn(cn: RBXScriptConnection): RBXScriptConnection
    u.insert(g.cns, cn)
    return cn
end

function g.dcn(cn: RBXScriptConnection)
    u.dcn(g.cns, cn)
end

g.ui = g.addToDestroy(o.make("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    DisplayOrder = math.huge,
    ResetOnSpawn = false,
    Parent = game:GetService("CoreGui"),
}))
g.pad = o.padding(g.ui)

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
            g.dcn(currentUpd)
        end
        currentUpd = newCam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            updStuff(newCam)
        end)
        g.cn(currentUpd)
    end

    onCharAdded(g.plr.Character or g.plr.CharacterAdded:Wait())
    g.cn(g.plr.CharacterAdded:Connect(onCharAdded))

    onCamAdded(workspace.CurrentCamera)
    g.cn(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCamAdded))

    function g.camUpd(ratio: number, fn: (number) -> ())
        u.insert(upds, {ratio, fn})
        updOne(g.cam, ratio, fn)
    end
end

g.rng = Random.new()

g.ping = 0
task.spawn(function()
    while task.wait(Config.General.PingUpdateTime) do
        g.ping = g.plr:GetNetworkPing()
    end
end)

g.camUpd(Config.Sizing.CornerRadius, function(num)
    local rad = UDim.new(0, num)
    o.cornRadius = rad
    for _, corn in o.corns do
        corn.CornerRadius = rad
    end
end)

---- notification ----

n.frame = o.make("Frame", {
    BackgroundTransparency = 1,
    Position = u.pos(0.3, 0.03),
    Size = u.pos(0.4, 0.1),
    Parent = g.ui,
    ZIndex = 2
})
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
        g.twen:Create(
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
    local twen = g.twen:Create(
        o.make("Frame", {
            Parent = ui,
            Position = u.pos(0, .93),
            Size = u.pos(1, 0.07),
            BorderSizePixel = 0,
        }, "Tertiary"),
        n.normInfo,
        {Size = u.pos(0, .07)}
    )
    twen:Play()
    twen.Completed:Once(function()
        n.call(ui, callback)
    end)
    table.insert(n.notifs, 1, ui)
    g.run.RenderStepped:Once(n.upd)
end

function n.capSendImgStuffToo(img: number?, max: number?)
    local send = n.capSend(max)
    return function(txt: string, options: {string}?, callback: notifCallback?)
        return send(img, txt, options, callback)
    end
end

function n.normal(max: number?)
    return n.capSendImgStuffToo(Config.EggImages.Normal, max)
end

function n.HUH(max: number?)
    return n.capSendImgStuffToo(Config.EggImages.HUH, max)
end

function n.sad(max: number?)
    return n.capSendImgStuffToo(Config.EggImages.Sad, max)
end

function n.XD(max: number?)
    return n.capSendImgStuffToo(Config.EggImages.XD, max)
end

---- window ----

w.__index = w
w.windows = {}
w.topbarSize = 0
type btnCallback = (InputObject, number) -> ()

function w.new(
    sizeX: number,
    sizeY: number,
    minSizeX: number,
    minSizeY: number,
    maxSizeX: number,
    maxSizeY: number, title: string?,
    noCloseButton: boolean?,
    nonModal: boolean?
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

    self.ui = o.make("Frame", {
        Parent = g.ui,
        Position = u.centre(.5,.5,size),
        Size = size,
        Visible = false,
    }, "Primary")
    o.strocorn(self.ui)
    self.content = o.make("Frame", {
        Parent = self.ui,
        BackgroundTransparency = 1,
    })
    self.topbar = o.make("Frame", {
        Parent = self.ui
    }, "Secondary")
    o.paddingEzy(self.topbar, .01, .01)
    o.list(self.topbar, true, nil, Enum.HorizontalAlignment.Right)
    o.strocorn(self.topbar)
    self.drag = o.dragDetect(self.topbar)
    self.title = o.txt(self.topbar, nil, u.pos1, title)
    self.title.TextXAlignment = Enum.TextXAlignment.Left
    self.title.LayoutOrder = -math.huge
    o.flex(self.title)
    for x = -1, 1 do
        self.bars[x] = {}
        for y = -1, 1 do
            if x == 0 and y == 0 then
                continue
            end
            self.bars[x][y] = self:makeBar(x, y)
        end
    end
    if not noCloseButton then
        self:addTxtBtn("X", function()
            self:disable()
        end)
    end
    if not nonModal then
        self.modaler = o.txt(self.ui, nil, nil, nil, 1, true)
    end
    u.insert(w.windows, self)
    return self
end

function w.newEzier(
    size: number,
    minSize: number,
    maxSize: number,
    title: string?,
    noCloseButton: boolean?,
    nonModal: boolean?
)
    return w.new(size, size, minSize, minSize, maxSize, maxSize, title, noCloseButton, nonModal)
end

function w.dragggggg(ui: GuiObject, drag: UIDragDetector): RBXScriptConnection
    local x = ui.Position.X.Scale
    local y = ui.Position.Y.Scale
    local sx = 1 - ui.Size.X.Scale
    local sy = 1 - ui.Size.Y.Scale
    return g.run.RenderStepped:Connect(function()
        local du = drag.DragUDim2
        ui.Position = u.pos(
            math.clamp(x + du.X.Offset / g.cam.ViewportSize.X, 0, sx),
            math.clamp(y + du.Y.Offset / g.cam.ViewportSize.Y, 0, sy)
        )
    end)
end

function w:addBtn(btn: GuiButton, callback: btnCallback)
    self.buttonAmount += 1
    btn.Parent = self.topbar
    btn.Size = u.pos1
    btn.SizeConstraint = Enum.SizeConstraint.RelativeYY
    btn.LayoutOrder = -self.buttonAmount
    self.topButtons[btn] = callback
    if self.enabled then
        self:cn(btn.Activated:Connect(callback))
    end
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

function w:addContent(content: Instance)
    content.Parent = self.content
end

function w:updTopbarSize(n: number)
    self.topbar.Size = u.posWithOffset(1, 0, 0, n)
    self.content.Size = u.posWithOffset(1, 0, 1, -n)
    self.content.Position = u.posWithOffset(0, 0, 0, n)
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

function w:dcn(cn: RBXScriptConnection)
    u.dcn(self.cns, cn)
end

function w:cn(cn: RBXScriptConnection)
    u.insert(self.cns, cn)
end

function w:sendToLayer(layer: number?)
    local amount = #self.windows
    layer = layer or amount
    if self.ui.ZIndex == layer then return end
    u.remove(w.windows, self)
    table.insert(w.windows, layer :: number, self)
    for z, win in w.windows do
        win.ui.ZIndex = -(amount - z)
    end
end

function w:enable(enabled: boolean?)
    local e = enabled ~= false
    if self.enabled == e then
        return
    end
    if self.modaler then
        self.modaler.Modal = e
    end
    local ui = self.ui
    self.enabled = e
    ui.Visible = e
    if e then
        self:updTopbarSize(w.topbarSize)
        self:sendToLayer()
        do
            local dragging
            local drag = self.drag
            self:cn(drag.DragStart:Connect(function()
                self:sendToLayer()
                dragging = w.dragggggg(ui, drag)
                self:cn(dragging)
            end))
            self:cn(self.drag.DragEnd:Connect(function()
                dragging:Disconnect()
            end))
        end
        for x, ys in self.bars do
            for y, drag in ys do
                local dragging
                self:cn(drag.DragStart:Connect(function()
                    local oX = ui.Position.X.Scale
                    local oY = ui.Position.Y.Scale
                    local oSX = ui.Size.X.Scale
                    local oSY = ui.Size.Y.Scale
                    dragging = g.run.RenderStepped:Connect(function()
                        local du = drag.DragUDim2
                        local posX, sizeX = w.resizeAmount(x, oX, oSX, du.X.Offset / g.cam.ViewportSize.X, self.minSizeX, self.maxSizeX)
                        local posY, sizeY = w.resizeAmount(y, oY, oSY, du.Y.Offset / g.cam.ViewportSize.Y, self.minSizeY, self.maxSizeY)
                        ui.Position = u.pos(posX, posY)
                        ui.Size = u.pos(sizeX, sizeY)
                    end)
                    self:cn(dragging)
                end))

                self:cn(drag.DragEnd:Connect(function()
                    self:dcn(dragging)
                end))
            end
        end
        for btn, callback in self.topButtons do
            self:cn(btn.Activated:Connect(callback))
        end
    else
        u.dcnAll(self.cns)
    end
end

function w:disable()
    self:enable(false)
end

function w:toggle()
    self:enable(not self.enabled)
end

function w:destroy()
    self:disable()
    self.ui:Destroy()
    u.remove(w.windows, self)
end

g.camUpd(Config.Sizing.Topbar, function(num)
    w.topbarSize = num
    for _, win in w.windows do
        win:updTopbarSize(num)
    end
end)

---- suggestions ----

s.ui = o.thingy("CanvasGroup", g.ui)
s.scroll = o.scroll(s.ui, nil, u.pos1)
s.ui.ZIndex = 1
s.ui.Visible = false
o.strocorn(s.ui)
s.btns = {}
s.btnSize = 0

function s.place(box: TextBox)
    s.ui.Position = u.posOff(
        g.mouse.X,
        g.mouse.Y
    )
end

function s.clear()
    for idx, btn in s.btns do
        s.btns[idx] = nil
        btn:Destroy()
    end
end

function s.addBtn(txt: string, box: TextBox, idx: number)
    local btn = o.txt(s.scroll, u.posOff(0, s.btnSize * (idx - 1)), u.posWithOffset(1, 0, 0, s.btnSize), txt, 0, true, "Secondary")
    o.stro(btn)
    u.insert(s.btns, btn)
    btn:GetPropertyChangedSignal("GuiState"):Connect(function()
        if btn.GuiState ~= Enum.GuiState.Press then return end
        box.Text = txt
        box:ReleaseFocus()
    end)
end

s.notifKeys = {}
s.send = n.capSend(3)
type suggestCheck = (string) -> ({msg: string?, img: number?, options: {string}, callback: notifCallback}?)
function s.suggest(box: TextBox, suggestions: {string}, check: suggestCheck)
    box:GetPropertyChangedSignal("Text"):Connect(function()
        s.clear()
        local filter = u.filter(suggestions, box.Text)
        local filterAmount = #filter
        if box.Text == "" or filterAmount == 0 then
            s.ui.Visible = false
            return
        end
        s.ui.Size = u.posWithOffset(.15, 0, 0, s.btnSize * math.min(filterAmount, 3))
        s.ui.Visible = true
        s.place(box)
        for idx, str in filter do
            s.addBtn(str, box, idx)
        end
    end)
    box.FocusLost:Connect(function()
        g.run.RenderStepped:Wait()
        s.ui.Visible = false
        s.clear()
        if box.Text == "" then return end
        local err = check(box.Text)
        if not err then return end
        box.Text = ""
        if s.notifKeys[err] then return end
        s.notifKeys[err] = true
        s.send(err.img or Config.EggImages.HUH, err.msg or "Error!", err.options or {"Ok"}, function(idx)
            s.notifKeys[err] = nil
            if err.callback then
                err.callback(idx)
            end
        end)
    end)
end

g.camUpd(Config.Sizing.SuggestionButton, function(num)
    s.btnSize = num
end)

---- highlight ----

h.__index = h
h.highlightAmount = 0
h.err = n.sad(3)
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
        self.cn = g.cn(g.run.RenderStepped:Connect(function()
            local ping = g.ping
            for model, data in boxes do
                if not model.Parent then
                    self:removeHighlight(model, data)
                    continue
                end
                local cf, size = model:GetBoundingBox()
                if data.off ~= nil then
                    local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
                    if part then
                        cf += part.AssemblyLinearVelocity * u.unaryWithBool(ping, data.off)
                    end
                end
                data.part.CFrame = cf
                data.tag.StudsOffsetWorldSpace = Vector3.yAxis * size.Y / 2
                data.box.Size = size
            end
        end))
        return
    end
    g.dcn(self.cn)
    self.cn = nil
end

function h:addHighlight(model: Model, data: highlightData)
    if h.highlightAmount == Config.Highlight.MaxAmount then
        h.err("Max highlights reached", {"Ok"})
        return
    end
    h.highlightAmount += 1
    local tag = data.tag
    local col = data.col or u.nameColour(tag)
    local part = o.part(workspace, nil, nil, true)
    local nameTag = g.addToDestroy(o.make("BillboardGui", {
        AlwaysOnTop = true,
        Size = u.pos(10, 2.5),
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
        box = g.addToDestroy(o.make("BoxHandleAdornment", {
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

m.w = w.newEzier(0.5, 0.3, 0.7, "Eggsploits")

o.paddingEzy(m.w.content, .05, .05, .1, .1)

m.nav = o.make("Frame", {
    Position = u.pos(.9),
    Size = u.pos(.1, 1),
    Parent = m.w.content
}, "Secondary")
o.strocorn(m.nav)
o.list(m.nav, nil, nil, Enum.HorizontalAlignment.Center, Enum.UIFlexAlignment.SpaceEvenly, 0.05)

m.padding = 1.25
m.panel = o.make("Frame", {
    Parent = m.w.content,
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
            g.twen:Create(
                section[1],
                Config.Section.SwitchAnimation,
                {ImageColor3 = color}
            ):Play()
        end
        if section[2].Position ~= pos then
            g.twen:Create(
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
    local udim = UDim.new(0, o.stroThickness)
    for _, thingos in stuff do
        local frame = o.make("Frame", {
            Parent = scroll,
            BackgroundTransparency = 1,
            Size = u.posWithOffset(1, 0, 0, m.frameSize)
        })
        local pad = o.padding(frame)
        o.setPad(pad, udim)
        u.insert(m.pads, pad)
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
    s.suggest(box, suggestions, check)
    return box
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
    o.setPad(g.pad, udim)
    for _, pad in m.pads do
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
    local errSend
    do
        local send = n.HUH(3)
        errSend = function(msg: string)
            send(msg, {"Ok"})
        end
    end

    local plrNames = {}
    local plrNamesToPlr = {}
    local function plrAdded(plr: Player)
        plrNamesToPlr[plr.Name] = plr
        if plr == g.plr then return end
        u.insert(plrNames, plr.Name)
    end
    for _, plr in g.plrs:GetPlayers() do
        plrAdded(plr)
    end
    g.cn(g.plrs.PlayerAdded:Connect(plrAdded))
    g.cn(g.plrs.PlayerRemoving:Connect(function(plr)
        u.remove(plrNames, plr.Name)
        plrNamesToPlr[plr.Name] = nil
    end))
    local function plrCheck(name: string)
        local plr = plrNamesToPlr[name]
        if plr == g.plr then
            return {msg = "That's you, silly!", img = Config.EggImages.XD}
        end
        if plr then
            return
        end
        return {msg = `{name} is not a player`}
    end
    local function getPlayer(name: string): Player?
        local plr = plrNamesToPlr[name]
        if plr then
            return plr
        end
        errSend(`{name} is not in the game`)
        return
    end

    local function numberCheck(num: string)
        if not tonumber(num) then
            return {msg = `{num} is not a number`}
        end
        return
    end

    local function positiveCheck(num: string)
        local to = tonumber(num)
        if not to then
            return {msg = `{num} is not a number`}
        end
        if to < 0 then
            return {msg = `{num} must be over 0`}
        end
        return
    end

    local function numberRangeCheck(num: string, min: number, max: number)
        local number = tonumber(num)
        if not number then
            return {msg = `{num} is not a number`}
        end
        if number < min or number > max then
            return {msg = `Must be between {min} and {max}`}
        end
        return
    end

    local yesNo = {"yes", "no"}
    local function yesNoBool(str: string): boolean?
        str = str:lower()
        return
            if str == "yes"
            then true
            elseif str == "no"
            then false
            else nil
    end
    local function yesNoCheck(str: string)
        if yesNoBool(str) == nil then
            return {msg = `Must be yes or no`}
        end
        return
    end

    do -- You
        local stuff = {}
        do -- fly
            local flying = false
            local speed = 100
            local btn
            btn = m.btn("Fly", function()
                flying = not flying
                btn.Text = flying and "Unfly" or "Fly"
                if not flying or not g.root or not g.hum then return end

                local velocity = o.make(
                    "LinearVelocity",
                    {
                        ForceLimitsEnabled = false,
                        Parent = workspace
                    }
                )
                local gyro = o.make(
                    "AlignOrientation",
                    {
                        Mode = Enum.OrientationAlignmentMode.OneAttachment,
                        RigidityEnabled = true,
                        Parent = workspace
                    }
                )

                local cn
                cn = g.cn(g.run.RenderStepped:Connect(function(delta)
                    if not flying or not g.root or not g.hum then
                        velocity:Destroy()
                        gyro:Destroy()
                        g.dcn(cn)
                        return
                    end
                    local cameraCf = workspace.CurrentCamera.CFrame
                    local look = (cameraCf.LookVector * Vector3.new(1, 0, 1)).Unit
                    local move = g.hum.MoveDirection.Unit

                    velocity.VectorVelocity = (
                        cameraCf.LookVector * u.rmNan(look:Dot(move)) +
                        cameraCf.RightVector * u.rmNan(cameraCf.RightVector:Dot(move))
                    ) * speed
                    gyro.CFrame = cameraCf

                    velocity.Attachment0 = g.att
                    gyro.Attachment0 = g.att

                    for _, track in g.anim:GetPlayingAnimationTracks() do
                        track:Stop()
                    end
                end))
            end)
            local box = m.box("Speed", {"10", "100", "1000"}, function(num)
                local err = numberCheck(num)
                if err then
                    return err
                end
                speed = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, box})
        end

        do -- setwalk
            local set = false
            local speed = 0
            local newSpeed = 0
            local btn
            btn = m.btn("Set Walk", function()
                if not g.hum then
                    return
                end
                set = not set
                btn.Text = set and "Unset Walk" or "Set Walk"
                if not set then

                    return
                end
                speed = g.hum.WalkSpeed
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    g.hum.WalkSpeed = newSpeed
                    if not set then
                        cn:Disconnect()
                        g.hum.WalkSpeed = speed
                    end
                end)
            end)
            local box = m.box("Pace", {"10", "20", "100"}, function(num)
                local err = positiveCheck(num)
                if err then
                    return err
                end
                newSpeed = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, box})
        end

        do -- setjump
            local set = false
            local jump = 0
            local newJump = 0
            local btn
            btn = m.btn("Set Jump", function()
                if not g.hum then
                    return
                end
                set = not set
                btn.Text = set and "Unset Jump" or "Set Jump"
                if not set then

                    return
                end
                jump = g.hum.JumpHeight
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    g.hum.JumpHeight = newJump
                    if not set then
                        cn:Disconnect()
                        g.hum.JumpHeight = jump
                    end
                end)
            end)
            local box = m.box("Height", {"10", "25", "50"}, function(num)
                local err = positiveCheck(num)
                if err then
                    return err
                end
                newJump = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, box})
        end

        do -- infinite jump
            local inf = false
            g.cn(g.uis.JumpRequest:Connect(function()
                if not inf then return end
                g.hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end))
            local btn
            btn = m.btn("Infinite jump", function()
                inf = not inf
                btn.Text = inf and "Uninfinite jump" or "Infinite jump"
            end)
            u.insert(stuff, {btn})
        end

        do -- noclip
            local noclipping = false
            local btn
            btn = m.btn("Noclip", function()
                noclipping = not noclipping
                btn.Text = noclipping and "Unnoclip" or "Noclip"
                if not noclipping then
                    return
                end
                local cn
                cn = g.cn(g.run.Heartbeat:Connect(function()
                    if not g.char then
                        return
                    end
                    for _, part in g.char:GetDescendants() do
                        if not part:IsA("BasePart") then
                            continue
                        end
                        part.CanCollide = not noclipping
                    end
                    if not noclipping then
                        g.dcn(cn)
                    end
                end))
            end)
            u.insert(stuff, {btn})
        end

        do -- tp
            local suggestions = {"-100", "-50", "50", "100"}
            local x = 0
            local y = 0
            local z = 0
            local btn = m.btn("Tp", function()
                if not g.root then
                    return
                end
                g.root:PivotTo(CFrame.new(x, y, z))
            end)
            local boxX = m.box("X", suggestions, function(num)
                local err = numberCheck(num)
                if err then
                    return err
                end
                x = tonumber(num)
                return
            end)
            local boxY = m.box("Y", suggestions, function(num)
                local err = numberCheck(num)
                if err then
                    return err
                end
                y = tonumber(num)
                return
            end)
            local boxZ = m.box("Z", suggestions, function(num)
                local err = numberCheck(num)
                if err then
                    return err
                end
                z = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, boxX, boxY, boxZ})
        end

        do -- coords
            local send = n.normal(3)
            local btn = m.btn("Coords", function()
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
            u.insert(stuff, {btn})
        end

        do -- anchor
            local achored = false
            local btn
            btn = m.btn("Anchor", function()
                achored = not achored
                btn.Text = achored and "Unanchor" or "Anchor"
                if not achored then
                    return
                end
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    g.root.Anchored = achored
                    if not achored then
                        cn:Disconnect()
                    end
                end)
            end)
            u.insert(stuff, {btn})
        end

        do -- wallheck yourself
        local high = h.new()
        local wallhecking = false
        local actual = nil
        local function upd()
            high:unhighlight()
            if not wallhecking or not g.char then return end
            high:addHighlight(g.char, {tag = "", col = u.nameColour(g.plr.Name), off = actual})
        end
        g.cn(g.plr.CharacterAdded:Connect(upd))
        upd()
        local btn
        btn = m.btn("Wallheck yourself", function()
            wallhecking = not wallhecking
            upd()
            btn.Text = wallhecking and "Unwallheck yourself" or "Wallheck yourself"
        end)
        local box = m.box("Guess actual position", yesNo, function(str)
            local err = yesNoCheck(str)
            if err then
                return err
            end
            actual = if yesNoBool(str) then false else nil
            for _, data in high.boxes do
                data.off = actual
            end
            return
        end)
        u.insert(stuff, {btn, box})
    end

        m.addSection(Config.SectionImages.You, stuff)
    end

    do -- Players
        local stuff = {}

        do -- tp
            local plrName = ""
            local btn = m.btn("Tp", function()
                local plr = getPlayer(plrName)
                if not g.char or not plr or not plr.Character then
                    return
                end
                g.char:PivotTo(plr.Character:GetPivot())
            end)
            local box = m.box("Player", plrNames, function(name)
                local err = plrCheck(name)
                if err then
                    return err
                end
                plrName = name
                return
            end)
            u.insert(stuff, {btn, box})
        end

        do
            local plr
            local speed = 100
            local flinging = false
            local btn
            btn = m.btn("Fling", function()
                flinging = not flinging
                btn.Text = flinging and "Unfling" or "Fling"
                if not flinging or not g.char or not plr or not plr.Character then
                    return
                end
                local origin = g.root.CFrame
                local connect
                connect = g.run.Heartbeat:Connect(function()
                    local root = g.root
                    if not flinging or plr.Parent ~= g.plrs then
                        connect:Disconnect()
                        root:PivotTo(origin)
                        root.Anchored = true
                        while root.AssemblyAngularVelocity ~= Vector3.zero or root.AssemblyLinearVelocity ~= Vector3.zero do
                            root.AssemblyLinearVelocity = Vector3.zero
                            root.AssemblyAngularVelocity = Vector3.zero
                            task.wait()
                        end
                        root.Anchored = false
                        return
                    end
                    local char = plr.Character
                    if not char then
                        return
                    end
                    local vec = g.rng:NextUnitVector() * speed
                    local part = char.PrimaryPart or char:FindFirstChildWhichIsA("BasePart", true)
                    local piv = char:GetPivot()
                    if part then
                        piv += part.AssemblyLinearVelocity * g.ping
                    end
                    g.char:PivotTo(piv)
                    root.AssemblyAngularVelocity = vec
                    root.AssemblyLinearVelocity = vec
                end)
            end)
            local plrBox = m.box("Player", plrNames, function(name)
                local err = plrCheck(name)
                if err then
                    return err
                end
                plr = getPlayer(name)
                return
            end)
            local speedBox = m.box("Speed", plrNames, function(num)
                local err = positiveCheck(num)
                if err then
                    return err
                end
                speed = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, plrBox, speedBox})
        end

        do -- wallheck
            local high = h.new()
            local wallhecking = false
            local actual = nil
            local btn
            local cns = {}
            local chars = {}
            local function add(plr, char)
                local tag = plr.Name
                high:addHighlight(char, {
                    tag = tag,
                    col = u.nameColour(tag),
                    off = actual
                })
            end
            local function upd()
                high:unhighlight()
                if not wallhecking then
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
                cns[plr] = g.cn(plr.CharacterAdded:Connect(function(char)
                    chars[plr] = char
                    if wallhecking then
                        add(plr, char)
                    end
                end))
                local char = plr.Character
                chars[plr] = char
                if wallhecking and char then
                    add(plr, char)
                end
            end
            for _, plr in plrNamesToPlr do
                addPlr(plr)
            end
            g.plrs.PlayerAdded:Connect(addPlr)
            g.plrs.PlayerRemoving:Connect(function(plr)
                if plr == g.plr then return end
                high:removeHighlightNice(chars[plr])
                g.dcn(cns[plr])
                cns[plr] = nil
                chars[plr] = nil
            end)
            btn = m.btn("Wallheck", function()
                wallhecking = not wallhecking
                btn.Text = wallhecking and "Unwallheck" or "Wallheck"
                upd()
            end)
            local box = m.box("Guess Server Position", yesNo, function(str)
                local err = yesNoCheck(str)
                if err then
                    return err
                end
                actual = yesNoBool(str) or nil
                for _, data in high.boxes do
                    data.off = actual
                end
                return
            end)
            u.insert(stuff, {btn, box})
        end

        do -- wallheck npcs
            local high = h.new()
            local wallhecking = false
            local actual = nil
            local btn
            local chars = {}
            local function add(char)
                local tag = char.Name
                high:addHighlight(char, {
                    tag = tag,
                    col = u.nameColour(tag),
                    off = actual
                })
            end
            local function addHum(hum)
                if not hum:IsA("Humanoid") or not hum:IsA("AnimationController") then return end
                local char = hum.Parent
                if char == workspace or g.plrs:GetPlayerFromCharacter(char) then return end
                chars[char] = true
                if wallhecking then
                    add(char)
                end
            end
            local function upd()
                high:unhighlight()
                if not wallhecking then
                    return
                end
                for char in chars do
                    add(char)
                end
            end
            g.cn(workspace.DescendantAdded:Connect(addHum))
            for _, desc in workspace:GetDescendants() do
                addHum(desc)
            end
            g.cn(workspace.DescendantRemoving:Connect(function(desc)
                chars[desc] = nil
                high:removeHighlightNice(desc)
            end))
            btn = m.btn("Wallheck NPCs", function()
                wallhecking = not wallhecking
                btn.Text = wallhecking and "Unwallheck NPCs" or "Wallheck NPCs"
                upd()
            end)
            local box = m.box("Guess Server Position", yesNo, function(str)
                local err = yesNoCheck(str)
                if err then
                    return err
                end
                actual = yesNoBool(str) or nil
                for _, data in high.boxes do
                    data.off = actual
                end
                return
            end)
            u.insert(stuff, {btn, box})
        end

        m.addSection(Config.SectionImages.Players, stuff)
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
            0.5,
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

        g.cn(g.mouse.Button1Down:Connect(function()
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
            local cn = nil
            local btn
            btn = m.btn("Baseplate", function()
                if cn then
                    base.Parent = nil
                    g.dcn(cn)
                    cn = nil
                    btn.Text = "Baseplate"
                else
                    base.Parent = workspace
                    local cf, size = g.char:GetBoundingBox()
                    local y = cf.Y - size.Y / 2 - 0.5
                    cn = g.cn(g.run.RenderStepped:Connect(function()
                        local pos = g.root.Position
                        base.Position = Vector3.new(
                            pos.X,
                            y,
                            pos.Z
                        )
                    end))
                    btn.Text = "Destroy Baseplate"
                end
            end)
            u.insert(stuff, {btn})
        end

        do-- grapple
            local grapple = false
            local rope = o.make("RopeConstraint", {
                WinchEnabled = true,
                WinchForce = math.huge,
                Visible = true,
                Color = BrickColor.Black(),
                Thickness = 0.5,
                WinchSpeed = 100,
                Restitution = 1,
            })
            addMouseCast(
                function(cast)
                    if not grapple then return end
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
            local btn
            btn = m.btn("Grapple", function()
                grapple = not grapple
                btn.Text = grapple and "Ungrapple" or "Grapple"
            end)
            local box = m.box("Winch speed", {"2", "5", "10", "100"}, function(num)
                local err = positiveCheck(num)
                if err then
                    return err
                end
                rope.WinchSpeed = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, box})
        end

        -- do -- moverer
        --     local handle = o.make("Handles", {
        --         Parent = g.ui,
        --         Color3 = Color3.fromRGB(0, 103, 172),
        --         Style = Enum.HandlesStyle.Movement,
        --     })
        --     -- local select = o.make("SelectionBox")
        -- end

        m.addSection(Config.SectionImages.Objects, stuff)
    end

    do -- Lighting
        local stuff = {}

        do -- shadows
            local set = true
            local btn
            btn = m.btn("Remove Shadows", function()
                set = not set
                btn.Text = set and "Remove Shadows" or "Add Shadows"
                if set then
                    return
                end
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    g.light.GlobalShadows = set
                    if set then
                        cn:Disconnect()
                    end
                end)
            end)
            u.insert(stuff, {btn})
        end

        do -- effects
            local set = true
            local effects = {}
            local btn
            btn = m.btn("Remove Effects", function()
                set = not set
                btn.Text = set and "Remove Effects" or "Add Effects"
                if set then
                    return
                end
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    for _, thing in g.light:GetChildren() do
                        effects[thing] = true
                        thing.Parent = nil
                    end
                    if set then
                        for thing in effects do
                            effects[thing] = nil
                            thing.Parent = g.light
                        end
                        cn:Disconnect()
                    end
                end)
            end)
            u.insert(stuff, {btn})
        end

        do -- set brightness
            local set = false
            local timy = 0
            local newTimmy = 0
            local btn
            btn = m.btn("Set Clock", function()
                if not g.hum then
                    return
                end
                set = not set
                btn.Text = set and "Unset Clock" or "Set Clock"
                if not set then
                    return
                end
                timy = g.light.ClockTime
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    g.light.ClockTime = newTimmy
                    if not set then
                        cn:Disconnect()
                        g.light.ClockTime = timy
                    end
                end)
            end)
            local box = m.box("Time", {"6", "10", "14", "24"}, function(num)
                local err = numberRangeCheck(num, 0, 24)
                if err then
                    return err
                end
                newTimmy = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, box})
        end

        do -- set brightness
            local set = false
            local bright = 0
            local newBright = 0
            local btn
            btn = m.btn("Set Brightness", function()
                if not g.hum then
                    return
                end
                set = not set
                btn.Text = set and "Unset Brightness" or "Set Brightness"
                if not set then
                    return
                end
                bright = g.light.Brightness
                local cn
                cn = g.run.RenderStepped:Connect(function()
                    g.light.Brightness = newBright
                    if not set then
                        cn:Disconnect()
                        g.light.Brightness = bright
                    end
                end)
            end)
            local box = m.box("Luminosity", {"0", "5", "10"}, function(num)
                local err = numberRangeCheck(num, 0, 10)
                if err then
                    return err
                end
                newBright = tonumber(num)
                return
            end)
            u.insert(stuff, {btn, box})
        end

        m.addSection(Config.SectionImages.Lighting, stuff)
    end

    do -- Misc
        local stuff = {}
        u.insert(stuff, {m.btn("Sticky note", function()
            m.stickyNote()
        end)})

        do -- changelogs
            local success, txt = pcall(function()
                return (game :: any):HttpGet(Config.General.ChangeLogsFile)
            end)
            local fn
            if success then
                local win = w.newEzier(0.4, 0.3, 0.5, "Changelogs")
                local scroll = o.scroll(win.content, u.pos(0.05, 0.05), u.pos(0.9, 0.9))
                o.list(scroll, false, Enum.VerticalAlignment.Top, Enum.HorizontalAlignment.Left)
                local things = {}
                for _, line in txt:split("\n") do
                    local fdsf = o.txt(scroll, nil, u.pos(1), line)
                    fdsf.TextXAlignment = Enum.TextXAlignment.Left
                    u.insert(things, fdsf)
                end
                g.camUpd(Config.Sizing.ChangeLogLine, function(num)
                    for _, thin in things do
                        thin.Size = u.posWithOffset(1, 0, 0, num)
                    end
                end)
                fn = function()
                    win:toggle()
                end
            else
                fn = function()
                    errSend(`Could not open changelogs: {txt}`)
                end
            end
            u.insert(stuff, {m.btn("Changelogs", fn)})
        end

        m.addSection(Config.SectionImages.Misc, stuff)
    end
end

m.goToSection(1)

---- button ----

b.w = w.new(.15, .2, .1, .15, .2, .25, "Eggsploits", true, true)
b.w.ui.Position = u.pos(.825, .05)

b.cred = w.newEzier(.25, .2, .3, "Credits")
o.txt(b.cred.content, nil, u.pos1, "Eggsploits made by Cabldebelegg at the request of Killercrusher9023")

do
    local send = n.sad()
    b.w:addTxtBtn("X", function()
        send("Remove Eggsploits?", {"Yes", "No"}, function(num)
            if num == 1 then
                u.dcnAll(g.cns)
                for _, win in w.windows do
                    win:destroy()
                end
                for _, inst in g.toDestroy do
                    inst:Destroy()
                end
                Config.General.InitTable[Config.General.InitKey] = nil
            end
        end)
    end)
end
b.w:addTxtBtn("?", function()
    b.cred:toggle()
end)
b.btn = o.img(b.w.content, nil, u.pos1, Config.EggImages.Normal, 0, true, "Primary")
o.corn(b.btn)
o.txt(b.btn, u.pos(0.039,0.618), u.pos(0.922,0.312), `Click {Config.General.Open.Name}`)
b.btn.Activated:Connect(function()
    m.w:toggle()
end)
g.cn(g.uis.InputEnded:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Config.General.Open then
        m.w:toggle()
    end
end))
b.w:enable()

n.send(Config.EggImages.Normal, "Eggsploits initialised", {"Ok"})

Config.General.InitTable[Config.General.InitKey] = n.XD()