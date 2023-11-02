require 'rubygems'
require 'gosu'
require_relative 'ruby/functions.rb'

class Testing < Gosu::Window

  def initialize
      super(800, 600, false)
      self.caption = "Test week page"

      #Background
      @background = Gosu::Color::WHITE
      @locked = true
      @background_image = Gosu::Image.new("media/background.png")

      #Box
      @boxarea = [[220,230,350,50], [220,230,350,50], [220,230,350,50], [220,230,350,50]]
      @lightg = Gosu::Color::argb(0xff_F5F5F5)
      @darkg = Gosu::Color::argb(0xff_D3D3D3) 

      #Color
      @boxcolor = [@lightg, @lightg, @lightg, @lightg]
      @border = [@darkg, @darkg, @darkg, @darkg]

      #Font
      @button_font = Gosu::Font.new(35)
      @title_font = Gosu::Font.new(50)

      @options = ["Generate a new week", "Generate new months", "Open Water Tracker", "Exit"]
  end

  def draw
      Gosu.draw_rect(0, 0, 800, 600, @background, ZOrder::BACKGROUND, mode=:default)
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      # Options
      x = 2
      y = 4
      w = 0

      # Box
      for z in 0..@options.count.to_i-1
        @boxarea[z][1] = 120 + w
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        @button_font.draw_text(@options[z], @boxarea[z][0]+10, @boxarea[z][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=120
      end 

      @title_font.draw_text("Testing for week and month options", 40, 20, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def update
    @locs = [mouse_x, mouse_y]
    selected = mouse_over_button?(mouse_x, mouse_y)
    if (0..@border.count-1).include? selected
      @border[selected] = Gosu::Color::BLACK
    else
      if @locked == true
        for z in 0..@border.count.to_i-1
            @border[z] = Gosu::Color::argb(0xff_D3D3D3)
        end
      end
   end
  end


  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if (0..@options.count-1).include? ans
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        for z in 0..@boxcolor.count.to_i-1
          if z == ans
          else
            @boxcolor[z] = Gosu::Color::argb(0xff_F5F5F5)
          end
        end

        testing_choices(ans) 
      else
        @locked = true
      end
      @locked = true
    end
  end

end

class Testing_month < Gosu::Window

  def initialize
      super(800, 600, false)
      self.caption = "Test week page"

      #Background
      @background = Gosu::Color::WHITE
      @locked = true
      @background_image = Gosu::Image.new("media/background.png")

      #Box
      @boxarea = [[220,230,350,50], [220,230,350,50], [220,230,350,50], [220,230,350,50]]
      @lightg = Gosu::Color::argb(0xff_F5F5F5)
      @darkg = Gosu::Color::argb(0xff_D3D3D3) 

      #Color
      @boxcolor = [@lightg, @lightg, @lightg, @lightg]
      @border = [@darkg, @darkg, @darkg, @darkg]

      #Font
      @button_font = Gosu::Font.new(35)
      @title_font = Gosu::Font.new(50)

      @options = ["4 months", "8 months", "12 months", "Back"]
  end

  def draw
      Gosu.draw_rect(0, 0, 800, 600, @background, ZOrder::BACKGROUND, mode=:default)
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      # Options
      x = 2
      y = 4
      w = 0

      # Box
      for z in 0..@options.count.to_i-1
        @boxarea[z][1] = 120 + w
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        @button_font.draw_text(@options[z], @boxarea[z][0]+10, @boxarea[z][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=90
      end 

      @title_font.draw_text("Testing for week and month options", 40, 20, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def update
    @locs = [mouse_x, mouse_y]
    selected = mouse_over_button?(mouse_x, mouse_y)
    if (0..@border.count-1).include? selected
      @border[selected] = Gosu::Color::BLACK
    else
      if @locked == true
        for z in 0..@border.count.to_i-1
            @border[z] = Gosu::Color::argb(0xff_D3D3D3)
        end
      end
   end
  end


  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if (0..@options.count-1).include? ans
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        for z in 0..@boxcolor.count.to_i-1
          if z == ans
          else
            @boxcolor[z] = Gosu::Color::argb(0xff_F5F5F5)
          end
        end

        if ans == 0 || ans == 1 || ans == 2

          if ans == 0
            ans = 4
          elsif ans == 1
            ans = 8
          elsif ans == 2
            ans = 12
          else 
          end

          time = Time.new
          a = File.new("cache/Water_tracker.txt", "w")
          b = File.new("cache/Water_tracker1.txt", "w")
          c = File.new("cache/Water_tracker2.txt", "w")

          a.close()
          b.close()
          c.close()

          x = ans
          while x > 0
            open('cache/Water_tracker.txt', 'a') do |f|
              f.puts time.yday
              f.puts time.year
              f.puts x
              f.puts time.wday
              f.puts rand(0-30000)
            end
            x-=1
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

        elsif ans == 3
          Testing.new.show
        end
      else
        @locked = true
      end
      @locked = true
    end
  end

end

Testing.new.show