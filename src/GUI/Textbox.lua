

Textbox = Class{}

function Textbox:init(x, y, width, height, text, font)
    self.panel = Panel(x, y, width, height, GREY)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = text
    self.font = font or gFonts['small']
    --[[ getWrap takes the text and returns each line of wrapped text to
        the textChunks.  _ is a throwaway variable for the returned width 
        of the wrapped text]]
    _, self.textChunks = self.font:getWrap(self.text, self.width -12)

    -- keep track as we iterate through the text chuncks
    self.chunkCounter = 1
    -- the maximum number of chunks to display per page, subtract 1 since the counter starts at 1
    self.maxChunks = math.max(1, math.modf((self.height - LINE_WIDTH * 8) / TILE_SIZE)) - 1
    self.endOfText = false
    self.closed = false

    self:next()

    --print(#self.textChunks)
    --print(self.maxChunks)
end

function Textbox:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self:next()
    end
end

function Textbox:render()
    self.panel:render()

    love.graphics.setFont(self.font)
    love.graphics.setColor(255, 255, 255, 255)
    for i = 1, #self.displayingChunks do
        love.graphics.print(self.displayingChunks[i], self.x + LINE_WIDTH * 4, 
            self.y + LINE_WIDTH * 4 + (i - 1) * TILE_SIZE)
    end
end

function Textbox:nextChunks()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + self.maxChunks do
        table.insert(chunks, self.textChunks[i])

        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    -- if maxChunks is 0 (only one line is displayed per page) then still increment by 1
    self.chunkCounter = self.chunkCounter + math.max(1, self.maxChunks)
    --print(self.chunkCounter)

    return chunks
end

function Textbox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.panel:toggle()
        self.closed = true
    else
        self.displayingChunks = self:nextChunks()
    end
end

function Textbox:isClosed()
    return self.closed
end