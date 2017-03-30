require 'gosu'

class Sprite
  def initialize window
    @window = window
    # image
    @width = @height = 160
    @ground_level = 200
    @idle = Gosu::Image.load_tiles @window,
                                   "player_160x160_idle.png",
                                   @width, @height, true
    @move = Gosu::Image.load_tiles @window,
                                   "player_160x160_move.png",
                                   @width, @height, true
    # center image
    # @x = @window.width/2  - @width/2
    # @y = @window.height/2 - @height/2

    # set sprite lower on screen, almost bottom
    @x = @window.width/2  - @width/2
    @y = @window.height - @ground_level

    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false
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
    @background_image = Gosu::Image.new("1920x1080.png", :tileable => true);
    self.caption = "Book Club Game"
    @sprite = Sprite.new self
    @x1 = 0
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @x1 -= 5
    @sprite.update
  end

  def draw
    # scale large image down to window size
    fx = self.width.to_f/@background_image.width
    fy = self.height.to_f/@background_image.height

    local_x = @x1 % - self.width

    @background_image.draw(local_x, 0, 0, fx, fy)
    @background_image.draw(self.width + local_x, 0, 0, fx, fy) if local_x < 0
    @sprite.draw
  end
end

RBCGame.new.show
