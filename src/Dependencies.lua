--[[
    GD50
    Match-3 Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]

--
-- libraries
--
Class = require 'lib/class'

push = require 'lib/push'

-- used for timers and tweening
Timer = require 'lib/knife.timer'

pprint = require 'lib/pprint'
json = require 'lib/json'
--
-- our own code
--

-- utility
require 'src/StateMachine'
require 'src/Util'

-- game pieces
require 'src/Board'
require 'src/Tile'
require 'src/Tiles'
-- game states
require 'src/states/BaseState'
require 'src/states/BeginGameState'
require 'src/states/GameOverState'
require 'src/states/PlayState'
require 'src/states/StartState'

gSounds = {
    ['music'] = love.audio.newSource('sounds/music3.mp3', 'stream'),
    ['select'] = love.audio.newSource('sounds/select.wav', 'stream'),
    ['error'] = love.audio.newSource('sounds/error.wav', 'stream'),
    ['match'] = love.audio.newSource('sounds/match.wav', 'stream'),
    ['clock'] = love.audio.newSource('sounds/clock.wav', 'stream'),
    ['game-over'] = love.audio.newSource('sounds/game-over.wav', 'stream'),
    ['next-level'] = love.audio.newSource('sounds/next-level.wav', 'stream')
}

gTextures = {
    ['main'] = love.graphics.newImage('graphics/match3.png'),
    ['background'] = love.graphics.newImage('graphics/background.png')
}

gFrames = {
    -- divided into sets for each tile type in this game, instead of one large
    -- table of Quads
    ['tiles'] = GenerateTileQuads(gTextures['main'])
}

-- this time, we're keeping our fonts in a global table for readability
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}