require_relative 'move_descriptor'

class PositionCalculator
  MAX_X = 675
  MIN_X = -35
  def self.get_new_coords(window, current_x, current_y, initial_y, last_move)
    x = current_x
    y = current_y
    jump_count = last_move.jump_count
    jumping = last_move.jumping 

    if window.button_down? Gosu::KbLeft
      direction = :left
      moving = true
      x += -5 unless x <= MIN_X
    end
    if window.button_down? Gosu::KbRight
      direction = :right
      moving = true
      x += 5 unless x >= MAX_X
    end
    if window.button_down? Gosu::KbSpace
      moving = true
      jump_count = 7 unless jumping       
      jumping = true 
    end
    if jumping
      jump_count -= 1
      jumping = false if jump_count <= 0
      y = initial_y - (get_y_from_jump(jump_count) * 10)   
    end
    MoveDescriptor.new ([x, y, moving, direction, jumping, jump_count])
  end

  def self.get_y_from_jump(jump_count)
    case jump_count
      when 6
        1
      when 5
        3
      when 4
        4
      when 3
        4
      when 2
        3
      when 1
        1
      else
        0
    end
  end

end