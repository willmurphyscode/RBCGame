require 'gosu'
require 'pry'
require_relative './rectangle.rb'
require_relative './position_calculator.rb'
require_relative './move_descriptor.rb'
require_relative './player_sprite.rb'
require_relative './floor_sprite.rb'
require_relative './wall_sprite.rb'
require_relative './game_state.rb'

DEBUG_DRAW = false

class RBCGame < Gosu::Window
  @walls = []
  attr_reader :game_state
  def initialize(width = 800, height = 600, fullscreen = false)
    super
    self.caption = 'Book Club Game'
    @game_state = GameState.new self
    game_state.set_up_sprites
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def update
    game_state.tick
  end

  def draw
    game_state.draw
  end
end

RBCGame.new.show
