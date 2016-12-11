local Color = require "classes.color.color"

-- OPENED EMAIL CLASS--

local opened_email_funcs = {}

OpenedEmail = Class{
    __includes = {RECT},

    init = function(self, _title, _text, _author, _time)
        local time
        local box_width, box_height = 2*W/5, 3*H/5

        RECT.init(self, W/2 - box_width/2,  H/2 - box_height/2, box_width, box_height, Color.new(150, 0, 240))

        self.title = _title -- Title of the email
        self.text = _text -- Body of email
        self.author = _author -- Who sent the email
        self.time = _time -- Time the email was sent

        self.line_color = Color.new(150,180,60) -- Color for line outlining the email box
        self.background_color = Color.new(0,0,40,140) -- Black effect for background
        self.title_color = Color.new(150,180,80) -- Color for title
        self.content_color = Color.new(150,0,60) -- Color for rest of email content


        self.tp = "opened_email"
    end

}

-- Draws opened email --
function OpenedEmail:draw()
    local e

    e = self

    -- Draws black effect
    Color.set(e.background_color)
    love.graphics.rectangle("fill", 0, 0, W, H)

    -- Draws email box
    Color.set(e.color)
    love.graphics.rectangle("fill", e.pos.x, e.pos.y, e.w, e.h)
    love.graphics.setLineWidth(2)
    Color.set(e.line_color)
    love.graphics.rectangle("line", e.pos.x, e.pos.y, e.w, e.h)

    -- Draw email content


end

function OpenedEmail:destroy(t) --Destroy this element from all tables (quicker if you send his drawable table, if he has one)

    self:setSubTp(nil) --Removes from Subtype table, if its in one
    self:setId(nil) --Removes from Id table, if its in one

    --Iterate all handles related to MAIN_TIMER
    if self.handles then
        for _,h in pairs(self.handles) do
            MAIN_TIMER:cancel(h) --Stops any timers this object has
        end
    end
    if t then
        t[self] = nil --If you provide the  drawable table, removes from it quicker
    else
        for _,tb in pairs(DRAW_TABLE) do--Iterates in all drawable tables and removes element
            if tb[self] then
                TABS_LOCK = false -- Enable clicking on tabs
                Util.findId("email_tab").email_opened = nil
                tb[self] = nil
                return
            end
        end
    end

    TABS_LOCK = false -- Enable clicking on tabs
    Util.findId("email_tab").email_opened = nil

end

-- UTILITY FUNCTIONS

function opened_email_funcs.mousePressed(x, y, but)
    local e

    e = Util.findId("opened_email")
    if not e or e.death then return end

    if x  < e.pos.x or
       x > e.pos.x + e.w or
       y  > e.pos.y + e.h or
       y < e.pos.y then
           --Clicked outside box
           e.death = true
     else
         --Clicked inside
     end
end

function opened_email_funcs.create(title, text, author, time)
    local e

    e = OpenedEmail(title, text, author, time)
    e:addElement(DRAW_TABLE.L2, nil, "opened_email")

    return e
end

return opened_email_funcs
