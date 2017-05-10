--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:bff72a22b3f7757f9ef3fcdc330cf46d:198f6859a0c533793271db49c56bc979:ab53c0937f41bb2487347d8c04ab9d24$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- asteroid1
            x=48,
            y=285,
            width=26,
            height=30,

        },
        {
            -- asteroid01
            x=1,
            y=285,
            width=45,
            height=46,

        },
        {
            -- laser
            x=76,
            y=285,
            width=10,
            height=50,

        },
        {
            -- ship
            x=1,
            y=1,
            width=190,
            height=282,

            sourceX = 65,
            sourceY = 13,
            sourceWidth = 320,
            sourceHeight = 320
        },
    },
    
    sheetContentWidth = 192,
    sheetContentHeight = 336
}

SheetInfo.frameIndex =
{

    ["asteroid1"] = 1,
    ["asteroid01"] = 2,
    ["laser"] = 3,
    ["ship"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
