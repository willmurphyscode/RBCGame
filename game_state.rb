class GameState
  attr_reader :window

  def initialize(window)
    @window = window
  end

  def set_up_sprites
    @player_sprite = PlayerSprite.new @window, self
    @floor = FloorSprite.new @window
    wall1 = WallSprite.new @window, height: 200, width: 85, x: 200, y: 400
    @walls = [wall1]
  end

  def tick
    @player_sprite.update
    player_rectangle = @player_sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    @player_sprite.undo_last if wall_rectangle.collides? player_rectangle
  end

  def blocked_left?(sprite)
    player_rectangle = @player_sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    player_rectangle.blocked_left? wall_rectangle
  end

  def blocked_right?(sprite)
    player_rectangle = @player_sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    player_rectangle.blocked_right? wall_rectangle
  end

  def draw
    @player_sprite.draw
    @floor.draw
    @walls.each(&:draw)
  end
end
