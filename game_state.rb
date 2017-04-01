class GameState
  attr_reader :window

  def initialize window
    @window = window
  end

  def set_up_sprites
    @player_sprite = PlayerSprite.new @window
    @floor = FloorSprite.new @window
    wall1 = WallSprite.new @window, { height: 200, width: 85, x: 200, y:400 }
    @walls = [wall1]
  end

  def tick
    @player_sprite.update
    player_rectangle = @player_sprite.rectangle
    wall_rectangle = @walls[0].rectangle
    wall_rectangle.collides? player_rectangle
  end

  def draw
    @player_sprite.draw
    @floor.draw
    @walls.each {|w| w.draw}
  end



end