class GameState
  attr_reader :window

  def initialize(window)
    @window = window
  end

  def set_up_sprites
    @player_sprite = PlayerSprite.new @window, self
    @floor = FloorSprite.new @window
    wall1 = WallSprite.new @window, height: 200, width: 85, x: 200, y: 400
    wall2 = WallSprite.new @window, height: 12, width: 85, x: 500, y: 500

    @walls = [wall1, wall2]
  end

  def tick
    @player_sprite.update
    player_rectangle = @player_sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    @player_sprite.undo_last if wall_rectangle.collides? player_rectangle
  end

  def blocked_left?(_sprite)
    return @walls.any? { |wall| wall.blocks_left?(@player_sprite.rectangle) }
  end

  def blocked_right?(_sprite)
    return @walls.any? { |wall| wall.blocks_right?(@player_sprite.rectangle) }
  end

  def draw
    @player_sprite.draw
    @floor.draw
    @walls.each(&:draw)
  end
end
