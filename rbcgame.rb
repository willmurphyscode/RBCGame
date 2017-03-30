require 'gosu'

class Sprite
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
