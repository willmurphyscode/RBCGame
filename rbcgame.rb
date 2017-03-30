require 'gosu'
require_relative './position_calculator.rb'
require_relative './move_descriptor.rb'


class Sprite
  MAX_X = 675
  MIN_X = -35
  def initialize window
    @window = window
    # image
    @width = @height = 160
    @idle = Gosu::Image.load_tiles @window,
                                   "player_160x160_idle.png",
                                   @width, @height, true
    @move = Gosu::Image.load_tiles @window,
                                   "player_160x160_move.png",
                                   @width, @height, true
    # center image
    @x = @window.width/2  - @width/2
    @y = @window.height/2 - @height/2
    @initial_y = @window.height/2 - @height/2
    @last_move = MoveDescriptor.initial_move(@x, @y)
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false

    #animations
    @animation = nil
  end

  def update
    @frame += 1
    @moving = false
    @last_move = PositionCalculator.get_new_coords(@window, @x, @y, @initial_y, @last_move)
    @x = @last_move.x 
    @y = @last_move.y
    @moving = @last_move.moving 
    @direction = @last_move.direction
    return 

    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5 unless @x <= MIN_X
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5 unless @x >= MAX_X
    elsif @window.button_down? Gosu::KbSpace
      @moving = true
      @jumping = true 
      @jump_count = 7
    elsif @jumping
      @jump_count -= 1
      puts get_y_from_jump(@jump_count)
      @jumping = false if @jump_count <= 0
      @y = @initial_y - (get_y_from_jump(@jump_count) * 10)   
    end

    @animation.update unless @animation.nil?
  end

  def get_y_from_jump(jump_count)
    case jump_count
      when 6
        1
      when 5
        3
      when 4
        4
      when 3
        4
      when 2
        3
      when 1
        1
      else
        0
    end
  end 

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    f = @frame % @idle.size
    image = @moving ? @move[f] : @idle[f]
    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + @width, @y, 1, -1, 1
    end
  end

end

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
    @sprite = Sprite.new self
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
