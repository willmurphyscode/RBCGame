require 'gosu'
require_relative './position_calculator.rb'
require_relative './move_descriptor.rb'
require_relative './player_sprite.rb'
require_relative './floor_sprite.rb'
require_relative './wall_sprite.rb'


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
  @walls = []
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Book Club Game"
    @sprite = PlayerSprite.new self
    @floor = FloorSprite.new self
    wall1 = WallSprite.new self, { height: 200, width: 85, x: 200, y:400 }
    @walls = [wall1]
    # puts "#{self.width} x #{self.height}" # 800 x 600
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @sprite.update
  end

  def draw
    @sprite.draw
    @floor.draw
    @walls.each {|w| w.draw}
  end
end

RBCGame.new.show
