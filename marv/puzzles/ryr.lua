name = "PLACEHOLDER"
-- Puzzle number
n = "RYR"

lines_on_terminal = 20
memory_slots = 0

-- Bot
bot = {'b', "EAST"}

-- name, draw background, image
_G.getfenv()['A'] = {"obst", false, "building_corner", dir = "west"}
_G.getfenv()['B'] = {"obst", false, "building_corner", dir = "east"}
_G.getfenv()['C'] = {"obst", false, "building_corner", dir = "south"}
_G.getfenv()['D'] = {"obst", false, "building_corner", dir = "north"}
_G.getfenv()['>'] = {"obst", false, "building_wall", dir = "west"}
_G.getfenv()['<'] = {"obst", false, "building_wall", dir = "east"}
_G.getfenv()['^'] = {"obst", false, "building_wall", dir = "south"}
_G.getfenv()['v'] = {"obst", false, "building_wall", dir = "north"}
_G.getfenv()['o'] = {"obst", false, "building_outside"}
_G.getfenv()['x'] = {"obst", false, "wall_none"}

f = {'bucket', true, 'papers', args = {content = 'empty', content_color = _G.Color.transp()}}
l = {"dead_switch", false, "lava", 0.2, "white", "solid_lava", args = {bucketable = true}}
t = {'bucket', true, 'table', args = {content = 'empty', pickable = false, w = _G.ROOM_CW * 3, h = _G.ROOM_CH * 2}}
c = {'computer', true, 'bucket', args = {}}
h = {'computer', true, 'bucket', args = {}}

local papers
function on_start(room)
    -- finds consoles
    for i = 1, ROWS do
        for j = 1, COLS do
            local o = room.grid_obj[j][i]
            if o and o.tp == 'bucket' and o.img == _G.OBJS_IMG.papers then
                papers = o
            end
        end
    end
end

-- Objective
objective_text = [[
Do the right thing. Burn the files.]]
function objective_checker(room)
    if room.bot.inv then return false end
    for i = 1, ROWS do
        for j = 1, COLS do
            local o = room.grid_obj[j][i]
            if o and o.tp == 'bucket' and o.img == _G.OBJS_IMG.papers then
                return false
            end
        end
    end
    if papers.dropped_on_computer then
        print "FEDS"
    else
        print "MARVINC"
    end
    return true
end

inv_wall =  "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooAvvvvvvvvvvvvvvvBoo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>111............<oo"..
            "oo>111............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "oo>...............<oo"..
            "ooC^^^^^^^^^^^^^^^Doo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"

grid_obj =  "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "vvvvvvvvvvvvDoooooooo"..
            "x..t...ch...<oooooooo"..
            "x...f.......<oooooooo"..
            "x...........<oooooooo"..
            "x...........<oooooooo"..
            "x..b.....l..<oooooooo"..
            "x...........<oooooooo"..
            "x...........<oooooooo"..
            "x...........<oooooooo"..
            "^^^^^^^^^^^^Boooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"

-- Floor
w = "white_floor"
_G.getfenv()[','] = "black_floor"
r = "red_tile"

grid_floor = "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"..
             "wwwwwwwwwwwwwwwwwwwww"

function first_completed()
    _G.PopManager.new(" placeholder",
        " placeholder ",
        _G.Color.green(), {
            func = function()
                _G.ROOM:disconnect()
            end,
            text = " placeholder ",
            clr = _G.Color.blue()
        })
end
