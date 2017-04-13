module Gravity
  def fall
    @y = @y - 10 unless @game_state.blocked_down? self
  end
end
