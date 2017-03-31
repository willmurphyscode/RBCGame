require 'gosu'
require 'pry'
require_relative './rectangle.rb'
require_relative './position_calculator.rb'
require_relative './move_descriptor.rb'
require_relative './player_sprite.rb'
require_relative './floor_sprite.rb'
require_relative './wall_sprite.rb'

class RBCGame < Gosu::Window
  @walls = []
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Book Club Game"
    @sprite = PlayerSprite.new self
    @floor = FloorSprite.new self
    wall1 = WallSprite.new self, { height: 200, width: 85, x: 200, y:400 }
    @walls = [wall1]
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @sprite.update
    player_rectangle = @sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    puts wall_rectangle.collides? player_rectangle
  end

  def draw
    @sprite.draw
    @floor.draw
    @walls.each {|w| w.draw}
  end
end

RBCGame.new.show
