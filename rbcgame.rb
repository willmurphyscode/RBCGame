require 'gosu'
require_relative './position_calculator.rb'
require_relative './move_descriptor.rb'
require_relative './player_sprite.rb'



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
