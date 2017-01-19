name = "Join Sequences"
-- Puzzle number
n = "C.2"

lines_on_terminal = 40
memory_slots = 40

-- Bot
bot = {'b', "WEST"}


local ans = {}
local function create_vec()
    local v = {}
    local szs = {3, 2, 5, 1, 13, 8}
    _G.table.insert(ans, 3 + 2 + 5 + 1 + 13 + 8)
    for _, sz in _G.ipairs(szs) do
        _G.table.insert(v, sz)
        for i = 1, sz do
            _G.table.insert(v, _G.love.math.random(-100, 100))
            _G.table.insert(ans, v[#v])
        end
    end
    _G.table.insert(v, 0)
    return v
end


-- name, draw background, image
o = {"obst", false, "wall_none"}
c = {"console", false, "console", "green", args = create_vec, dir = "east"}
d = {"console", false, "console", "blue", args = {}, dir = "east"}

-- console objects
local gr, bl


-- create ans vector
function on_start(room)
    -- finds consoles
    for i = 1, ROWS do
        for j = 1, COLS do
            local o = room.grid_obj[i][j]
            if o and o.tp == 'console' then
                if #o.out == 0 then
                    bl = o
                end
            end
        end
    end
end

-- Objective
objective_text = [[
Read sequences from the green console, join them, then write one big sequence to the blue console.]]
function objective_checker(room)
    if #bl.inp == 0 then return false end
    if #bl.inp > #ans then
        _G.StepManager.stop("Wrong output", "Too many numbers!", "Retry")
        return false
    end
    for i = 1, #bl.inp do
        if bl.inp[i] ~= ans[i] then
            _G.StepManager.stop("Wrong output", "Expected " .. ans[i] .. " got " .. bl.inp[i], "Retry")
            return false
        end
    end
    return #bl.inp == #ans
end


extra_info = [[
Each sequence is given by its size and then its elements.
- The last sequence will have size 0.
- Example: 2 1 2 1 3 0 is sequence (1,2) and  (3) and the output should be 3 1 2 3.
- The sum of sizes of all sequences will be at most 35.]]

grid_obj =  "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "oooo............ooooo"..
            "ooocb...........ooooo"..
            "oooo............ooooo"..
            "ooooooooooooo...ooooo"..
            "ooooooooooooo...ooooo"..
            "oooo............ooooo"..
            "oood............ooooo"..
            "oooo............ooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"..
            "ooooooooooooooooooooo"

-- Floor
w = "white_floor"
v = "black_floor"
r = "red_tile"

grid_floor = "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"..
             "vwvwvwvwvwvwvwvwvwvwv"..
             "wvwvwvwvwvwvwvwvwvwvw"


function first_completed()
    _G.PopManager.new("Well done",
        "You beat Vega :D\nAnd Franz just got here\n-- Liv",
        _G.Color.green(), {
            func = function()
                _G.ROOM:disconnect()
            end,
            text = " I'll help you ",
            clr = _G.Color.blue()
        })
end
