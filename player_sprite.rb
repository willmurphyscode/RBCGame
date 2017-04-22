class PlayerSprite
  include Occupies
  include Gravity

  MAX_X = 675
  MIN_X = -35
  def initialize(window, game_state)
    @window = window
    @game_state = game_state
    setup_image
    setup_initial_state
  end

  def setup_image
    @width = @height = 160
    @idle = Gosu::Image.load_tiles @window,
                                   'player_160x160_idle.png',
                                   @width, @height, true
    @move = Gosu::Image.load_tiles @window,
                                   'player_160x160_move.png',
                                   @width, @height, true
  end

  def setup_initial_state
    @x = @window.width / 2 - @width / 2
    @y = 415
    @initial_y = @y
    @last_move = MoveDescriptor.initial_move(@x, @y)
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false
  end

  def x_min
    @x + 25
  end

  def y_min
    @y + 25
  end

  def x_max
    @x + @width - 25
  end

  def y_max
    @y + @height - 25
  end

  def update
    @frame += 1
    @moving = false
    @previous_move = @last_move
    @last_move = make_move @last_move
    fall
  end

  def make_move(move)
    move = PositionCalculator.get_new_coords(@window, @x, @y, @initial_y, @last_move, @game_state, self)
    @x = move.x
    @y = move.y
    @moving = move.moving
    @direction = move.direction
    move
  end

  def undo_last
    @last_move = make_move @previous_move
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
    debug_draw @window
  end
end
