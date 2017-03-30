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
    @sprite_bottom = 125
  end

  def update
    @frame += 1
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
    end
    gravity_pull
  end

  def gravity_pull
    @y += 5 unless @y + @sprite_bottom == 550
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

class Floor
  def initialize(window)
    @window = window
    @sprite = Gosu::Image.load_tiles(@window, 'floor.png', 800, 20, false)[0]
    @x = 0
    @y = 550
  end

  def draw
    @sprite.draw(0, 550, 1)
  end
end

class RBCGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Book Club Game"
    @sprite = Sprite.new self
    @floor = Floor.new(self)
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
  end
end

RBCGame.new.show
