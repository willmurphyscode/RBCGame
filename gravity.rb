module Gravity
  def fall
    @y += 1 unless @game_state.blocked_down? self
  end
end
