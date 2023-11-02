module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

def needs_cursor?
      true
  end

  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

def testing_choices ans
  if ans == 0
          @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)
          time = Time.new
          a = File.new("cache/Water_tracker.txt", "w")
          b = File.new("cache/Water_tracker1.txt", "w")
          c = File.new("cache/Water_tracker2.txt", "w")

          a.close()
          b.close()
          c.close()

          for x in 0..6
            open('cache/Water_tracker.txt', 'a') do |f|
              f.puts time.yday-x
              f.puts time.year
              f.puts time.month
              ans = time.wday
              cday = ans - x
              if cday < 0
                  cday = 7 + ans - x
              else 
              end
              f.puts cday
              f.puts rand(0-4000)
            end
          end
          # 1 Write
                IO.copy_stream('cache/Water_tracker.txt', 'cache/Water_tracker1.txt')

          # 2 Append
          to_append = File.read("cache/Water_tracker2.txt")
          File.open("cache/Water_tracker1.txt", "a") do |handle|
          handle.puts to_append
          end

          # 3 Write
          IO.copy_stream('cache/Water_tracker1.txt', 'cache/Water_tracker2.txt')

          # 4 Write
          IO.copy_stream('cache/Water_tracker2.txt', 'cache/Water_tracker.txt')
          @locked = true

  elsif ans == 1
    Testing_month.new.show

  elsif ans == 2

    require_relative "../Water_Tracker.rb"
    Menu.new.show
    @locked = true
    
  elsif ans == 3
    exit
  else
  end
end 

