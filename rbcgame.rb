require 'gosu'

class Sprite
  attr_accessor :x, :y, :animation

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
    if @window.button_down?(Gosu::KbLeft) && @x > 0
      @direction = :left
      @moving = true
      @x += -5
    elsif @window.button_down?(Gosu::KbRight) && @x < @window.width - @width
      @direction = :right
      @moving = true
      @x += 5
    elsif @window.button_down?(Gosu::KB_A)
      @animation = Jump.new(@window, self) unless !@animation.nil?
    end

    @animation.update unless @animation.nil?
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
