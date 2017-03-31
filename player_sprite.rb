class PlayerSprite
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
    @y = 400
    @initial_y = @y
    @last_move = MoveDescriptor.initial_move(@x, @y)
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false
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