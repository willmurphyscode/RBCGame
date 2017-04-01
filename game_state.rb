class GameState
  attr_reader :window

  def initialize window
    @window = window
  end

  def set_up_sprites
    @sprite = PlayerSprite.new @window
    @floor = FloorSprite.new @window
    wall1 = WallSprite.new @window, { height: 200, width: 85, x: 200, y:400 }
    @walls = [wall1]
  end

  def tick
    @sprite.update
    player_rectangle = @sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    puts wall_rectangle.collides? player_rectangle
  end

  def draw
    @sprite.draw
    @floor.draw
    @walls.each {|w| w.draw}
  end



end