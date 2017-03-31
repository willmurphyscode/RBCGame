require 'gosu'
require_relative './position_calculator.rb'
require_relative './move_descriptor.rb'
require_relative './player_sprite.rb'



class Jump
  MAX_JUMP = 100

  def initialize(window, player)
    @window = window
    @player = player
    @jump_y = 0
    @direction = :up
    @done = false
  end

  def update
    if @jump_y >= MAX_JUMP && @direction == :up
      @player.y += 5
      @jump_y -= 5
      @direction = :down
    elsif @jump_y < MAX_JUMP && @jump_y > 0 && @direction == :down
      @player.y += 5
      @jump_y -= 5
    elsif @jump_y == 0 && @direction == :down
      @player.animation = nil
    else
      @player.y -= 5
      @jump_y += 5
    end
  end
end

class RBCGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Book Club Game"
    @sprite = PlayerSprite.new self
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @sprite.update
  end

  def draw
    @sprite.draw
  end
end

RBCGame.new.show
