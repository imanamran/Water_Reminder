require 'rubygems'
require 'gosu'
require_relative 'ruby/functions.rb'

# Search "#" to look at the comments

# Main Menu
class Menu < Gosu::Window
  def initialize
      super(800, 600, false)
      self.caption = "Water Tracker main page"

      # Background + image 
      @background_image = Gosu::Image.new("media/background.png")
      @logo_image = Gosu::Image.new("media/logo.png")

      # Buttons
      @boxarea = [[270,100,250,50], [270,100,250,50], [270,100,250,50],[270,100,250,50],[270,100,250,50],[270,100,250,50]]
      @lightg = Gosu::Color::argb(0xff_F5F5F5)
      @darkg = Gosu::Color::argb(0xff_D3D3D3)
      @boxcolor = [@lightg, @lightg, @lightg, @lightg, @lightg, @lightg]
      @border = [@darkg, @darkg, @darkg, @darkg, @darkg, @darkg]

      # Fonts
      @title_font = Gosu::Font.new(70)
      @button_font = Gosu::Font.new(40)
      @instruct_font = Gosu::Font.new(30)

      # Options 
      @options = ["Update", "Set Goal", "Analysis", "Test", "Reset", "Exit"]

      # Boolean statement 
      @locked = true
  end

  # Draw function
  # Draw function
  def draw
      @logo_image.draw(140, 10, ZOrder::TOP,0.15,0.15)
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      
      x = 2
      y = 4
      w = 0

      # Draw buttons with its outline
      for z in 0..@options.count.to_i-1
        @boxarea[z][1] = 100 + w
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        @button_font.draw_text(@options[z], @boxarea[z][0]+10, @boxarea[z][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=80
      end 

      # Title
      @title_font.draw_text("Water Tracker", 230, 20, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Does the hover effects based on the output from mouse_over_button? function
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

  # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if (0..@options.count-1).include? ans
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        # Update
        if ans == 0 
          Reminder.new.show

          # Set Goal
        elsif ans == 1
          SetGoal.new.show

          # Analysis
        elsif ans == 2
          Analysis.new.show

          # Test
        elsif ans == 3
          require_relative 'Testing_week_&_month.rb'
          Testing.new.show

          # Reset all files
        elsif ans == 4
          File.new("cache/Day.txt","w")
          File.new("cache/goal.txt","w")
          File.new("cache/Month.txt","w")
          File.new("cache/Water_tracker.txt","w")
          File.new("cache/Water_tracker1.txt","w")
          File.new("cache/Water_tracker2.txt","w")
          File.new("cache/Week.txt","w")
        elsif ans == 5
          exit
        else
        end 
      else
        @locked = true
      end
      @locked = true
    end
  end
end

# Update option
class Reminder < Gosu::Window

  def initialize
      super(800, 600, false)
      self.caption = "Reminder page"

      # Background
      @background_image = Gosu::Image.new("media/background.png")

      # Buttons
      @boxarea = [[300,90,150,50], [300,90,150,50], [300,90,150,50], [300,90,150,50], [300,90,150,50], [300,90,150,50], [300,520,150,50], [50,520,190,50], [510,520,190,50]]
      @lightg = Gosu::Color::argb(0xff_F5F5F5)
      @darkg = Gosu::Color::argb(0xff_D3D3D3)
      @boxcolor = [@lightg, @lightg, @lightg, @lightg, @lightg, @lightg, @lightg, @lightg, @lightg]
      @border = [@darkg, @darkg, @darkg, @darkg, @darkg, @darkg, @darkg, @darkg, @darkg]

      # Fonts
      @button_font = Gosu::Font.new(40)
      @title_font = Gosu::Font.new(70)

      # Options
      @options = ["10", "50", "100", "200", "500", "1000"]

      # Boolean statement 
      @locked = true
  end

  # Draw function
  def draw
      @background_image.draw(0, 0, ZOrder::BACKGROUND)

      x = 2
      y = 4
      w = 0

      # Box
      for z in 0..@options.count.to_i-1
        @boxarea[z][1] = 90 + w
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        @button_font.draw_text(@options[z]+"ml", @boxarea[z][0]+10, @boxarea[z][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=70
      end 

      for z in 6..8
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
      end

      @button_font.draw_text("Delete", @boxarea[6][0]+10, @boxarea[6][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Main Menu", @boxarea[7][0]+10, @boxarea[7][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Analysis", @boxarea[8][0]+10, @boxarea[8][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      @button_font.draw_text("How many ml did you drink just now?", 100, 30, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      # Title
  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Does the hover effects based on the output from mouse_over_button? function
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

   # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if (0..@options.count-1).include? ans
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        open('cache/Water_tracker.txt', 'w') do |f|
          f.puts time.yday
          f.puts time.year
          f.puts time.month
          f.puts time.wday
          f.puts @options[ans]
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

        for z in 0..@boxcolor.count.to_i-1
          if z == ans
          else
            @boxcolor[z] = Gosu::Color::argb(0xff_F5F5F5)
          end
        end

      elsif ans == 6
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)
       for x in 0..4
          text=""
          File.open("cache/Water_tracker.txt","r"){|f|f.gets;text=f.read}
          File.open("cache/Water_tracker.txt","w+"){|f| f.write(text)}
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

        for z in 0..@boxcolor.count.to_i-1
          if z == ans
          else
            @boxcolor[z] = Gosu::Color::argb(0xff_F5F5F5)
          end
        end

      elsif ans == 7
        Menu.new.show
      elsif ans == 8
        Analysis.new.show
      else
        @locked = true
      end
      @locked = true
    end
  end
end

class SetGoal < Gosu::Window

  def initialize
      super(800, 600, false)
      self.caption = "Set Goal page"

      #Background
      @background_image = Gosu::Image.new("media/background.png")

      #Box
      @boxarea = [[300,90,150,50], [300,90,150,50], [300,90,150,50], [300,90,150,50], [300,90,150,50], [300,90,150,50], [300,520,150,50], [50,520,190,50], [510,520,190,50]]
      @lightg = Gosu::Color::argb(0xff_F5F5F5)
      @darkg = Gosu::Color::argb(0xff_D3D3D3)

      #Color
      @boxcolor = [@lightg, @lightg, @lightg, @lightg, @lightg, @lightg, @lightg, @lightg, @lightg]
      @border = [@darkg, @darkg, @darkg, @darkg, @darkg, @darkg, @darkg, @darkg, @darkg]

      #Font
      @button_font = Gosu::Font.new(40)
      @instruct_font = Gosu::Font.new(30)
      @title_font = Gosu::Font.new(70)

      @options = ["1500", "2000", "2500", "3000", "3500", "4000"]
      #Boolean statement 
      @locked = true
  end

  # Draw function
  def draw
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      # Options
      x = 2
      y = 4
      w = 0

      # Box
      for z in 0..@options.count.to_i-1
        @boxarea[z][1] = 90 + w
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        @button_font.draw_text(@options[z]+"ml", @boxarea[z][0]+10, @boxarea[z][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=70
      end 

      for z in 6..8
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], @boxcolor[z], ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
      end

      @button_font.draw_text("Delete", @boxarea[6][0]+10, @boxarea[6][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Main Menu", @boxarea[7][0]+10, @boxarea[7][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Update", @boxarea[8][0]+10, @boxarea[8][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      @button_font.draw_text("Daily Intake Goals", 225, 30, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @instruct_font.draw_text("Suggested by\nhealth experts:\n\nWoman,\n1500ml - 3000ml\n\nMan,\n3000ml - 4000ml", 20, 90, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      # Title
  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Where is mouse_x and mouse_y defined

  # Does the hover effects based on the output from mouse_over_button? function
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

   # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if (0..@options.count-1).include? ans
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        open('cache/goal.txt', 'w') do |f|
          f.puts @options[ans]
        end

        for z in 0..@border.count.to_i-1
          if z == ans
          else 
            @boxcolor[z] = Gosu::Color::argb(0xff_F5F5F5)
          end
        end

      elsif ans == 6
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        for z in 0..@border.count.to_i-1
          if z == ans
          else 
            @boxcolor[z] = Gosu::Color::argb(0xff_F5F5F5)
          end
        end

        open('cache/goal.txt', 'w') do |f|
        end
      elsif ans == 7
        Menu.new.show
      elsif ans == 8
        Reminder.new.show
      else
        @locked = true
      end
      @locked = true
    end
  end
end

class Analysis < Gosu::Window

  def initialize
      super(800, 600, false)
      self.caption = "Analysis page"

      #Background
      @background_image = Gosu::Image.new("media/background.png")

      #Box
      @boxarea = [[250,90,250,50], [250,90,250,50], [250,90,250,50], [250,90,250,50]]
      @lightg = Gosu::Color::argb(0xff_F5F5F5)
      @darkg = Gosu::Color::argb(0xff_D3D3D3)

      #Color
      @boxcolor = [@lightg, @lightg, @lightg, @lightg]
      @border = [@darkg, @darkg, @darkg, @darkg]

      #Font
      @button_font = Gosu::Font.new(40)
      @instruct_font = Gosu::Font.new(30)
      @title_font = Gosu::Font.new(70)

      @options = ["Day", "Week", "Month", "Main Menu"]

      #Boolean statement 
      @locked = true
  end

  # Draw function
  def draw
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
        w+=100
      end 

      @title_font.draw_text("Water Tracker", 180, 0, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Where is mouse_x and mouse_y defined

  # Does the hover effects based on the output from mouse_over_button? function
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

   # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft

      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if (0..@options.count-1).include? ans
        @locked = false
        @border[ans] = Gosu::Color::BLACK
        @boxcolor[ans] = Gosu::Color::argb(0xff_89CFF0)

        if ans == 0

          watert_file = File.new("cache/Water_tracker.txt", "r")
          time = Time.new
          day_read = true
          ml = 0

          toyear = time.year.to_i
          tomonth = time.month.to_i
          today = time.yday.to_i

          while day_read == true

            day = watert_file.gets.to_i
            year = watert_file.gets.to_i
            month = watert_file.gets.to_i
            specific_day = watert_file.gets.to_i

            if year == toyear && month == tomonth && day == today
              newml = watert_file.gets.to_i
              ml = ml + newml
              day_read = true

            else
              ml+= 0
              day_read = false
            end

          end

          open("cache/Day.txt", "w") do |f|
            f.puts ml
          end

          Daydisplay.new.show

        elsif ans == 1
          File.new("cache/Week.txt", "w")
          watert_file = File.new("cache/Water_tracker.txt", "r")
          time = Time.new
          week_reada = true
          ml = 0

          toyear = time.year.to_i
          tomonth = time.month.to_i
          today = time.yday.to_i
          stoday = time.wday.to_i

          compile = [[], [], [], [], [], [], [], []]

            for x in 0..6

              begin
                day = watert_file.gets.to_i

                if day == today - x 
                  year = watert_file.gets.to_i
                  month = watert_file.gets.to_i
                  specific_day = watert_file.gets.to_i
                  if year == toyear && month == tomonth
                    ml = watert_file.gets.to_i
                    compile[x] << ml
                  else
                  end
                else
                  year = watert_file.gets.to_i
                  month = watert_file.gets.to_i
                  specific_day = watert_file.gets.to_i 
                  if year == toyear && month == tomonth
                    ml = watert_file.gets.to_i
                    compile[x+1] << ml
                  else
                  end
                end 
                
              end while day == today - x

              open("cache/Week.txt", "a") do |f|
                sum = 0
                compile[x].each { |a| sum+=a }
                f.puts sum
              end

            end 

          Weekdisplay.new.show

        elsif ans == 2

          File.new("cache/Month.txt", "w")
          watert_file = File.new("cache/Water_tracker.txt", "r")
          time = Time.new
          ml = 0

          toyear = time.year.to_i
          tomonth = time.month.to_i
          today = time.yday.to_i
          stoday = time.wday.to_i

          compile = [[], [], [], [], [], [], [], [], [], [], [], [], []]

          day = watert_file.gets.to_i
          year = watert_file.gets.to_i
          month = watert_file.gets.to_i


          watert_file = File.new("cache/Water_tracker.txt", "r")

          if month == 12
            for x in 0..month-1

              begin
                day = watert_file.gets.to_i
                year = watert_file.gets.to_i
                month = watert_file.gets.to_i

                if year == toyear
                  specific_day = watert_file.gets.to_i
                  ml = watert_file.gets.to_i
                  compile[x] << ml
                end

                if (month - x) <= 0
                  tomonth = tomonth + x
                else
                end
                
              end while month == tomonth

              open("cache/Month.txt", "a") do |f|
                sum = 0
                compile[x].each { |a| sum+=a }
                f.puts sum
              end
            end

          else
            for x in 0..month-1

              begin
                day = watert_file.gets.to_i
                year = watert_file.gets.to_i
                month = watert_file.gets.to_i

                if year == toyear
                  specific_day = watert_file.gets.to_i
                  ml = watert_file.gets.to_i
                  compile[x] << ml
                end

                if (month - x) <= 0
                  tomonth = tomonth + x
                else
                end
                
              end while month == tomonth - x

              open("cache/Month.txt", "a") do |f|
                sum = 0
                compile[x].each { |a| sum+=a }
                f.puts sum
              end
            end
          end

          Monthdisplay.new.show
        else
          Menu.new.show
        end

      else
        @locked = true
      end
      @locked = true
    end
  end
end

class Daydisplay < Gosu::Window

  def initialize
    super(800, 600, false)
    self.caption = "Analysis-Day page"

    #Background
    @background_image = Gosu::Image.new("media/background.png")
    @title_font = Gosu::Font.new(70)
    @button_font = Gosu::Font.new(40)
    @instruct_font = Gosu::Font.new(30)

    @boxarea = [[50,500,190,50], [510,500,190,50]]
    @border = [Gosu::Color::argb(0xff_D3D3D3), Gosu::Color::argb(0xff_D3D3D3)]
    
    #Boolean statement 
      @locked = true
  end

  # Analyze the day
  def analysis
    watert_file = File.new("cache/Day.txt", "r")
    totalml = watert_file.gets.to_i + 0.0

    goal_file = File.new("cache/goal.txt", "r")
    goal = goal_file.gets.to_i + 0.0

    todayml = (totalml/goal.to_i) * (800-100)

    if todayml > (800-100)
      todayml = (800-100)
    else
    end

    return todayml
  end

  def status
    watert_file = File.new("cache/Day.txt", "r")
    totalml = watert_file.gets.to_i + 0.0

    goal_file = File.new("cache/goal.txt", "r")
    goal = goal_file.gets.to_i + 0.0

    if goal == 0 || goal.nil?
      water_status = "            Please set a goal first"

    else 
      if totalml == goal
        water_status = "Congratulations! You have reached your goal"

      elsif totalml != 0 && totalml < goal 
        left = goal - totalml
        water_status = "       " + left.to_s + "ml to reach your goal"

      elsif totalml > goal
        max = totalml - goal
        water_status = "You have exceeded your goal with " + max.to_s + "ml"

      else
        water_status = "           You did not drink today"
      end
    end

    return water_status
  end 

  # Draw function
  def draw
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      @title_font.draw_text("Today analysis", 180, 0, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      Gosu.draw_rect(50, 200, analysis, 100, Gosu::Color::argb(0xff_89CFF0), ZOrder::TOP, mode=:default)
      Gosu.draw_rect(50, 200, 800-100, 100, Gosu::Color::argb(0xff_BFE3B4), ZOrder::MIDDLE, mode=:default)

      Gosu.draw_rect(150, 100, 50, 50, Gosu::Color::argb(0xff_89CFF0), ZOrder::TOP, mode=:default)
      @button_font.draw_text("Drink recorded", 210,105, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      Gosu.draw_rect(500, 100, 50, 50, Gosu::Color::argb(0xff_BFE3B4), ZOrder::TOP, mode=:default)
      @button_font.draw_text("Goal", 560,105, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      x = 2
      y = 4

      @instruct_font.draw_text(status.to_s, 180, 370, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

       for z in 0..1
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], Gosu::Color::argb(0xff_F5F5F5), ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        end

      @button_font.draw_text("Back", @boxarea[0][0]+10, @boxarea[0][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Week", @boxarea[1][0]+10, @boxarea[1][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Where is mouse_x and mouse_y defined

  # Does the hover effects based on the output from mouse_over_button? function
  def update
    @locs = [mouse_x, mouse_y]
    selected = mouse_over_button?(mouse_x, mouse_y)
    if (0..@border.count-1).include? selected
      @border[selected] = Gosu::Color::BLACK
    else
      if @locked == true
        for z in 0..@boxarea.count.to_i-1
            @border[z] = Gosu::Color::argb(0xff_D3D3D3)
        end
      end
   end
  end

   # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if ans == 0
        Analysis.new.show
      elsif ans == 1
        File.new("cache/Week.txt", "w")
          watert_file = File.new("cache/Water_tracker.txt", "r")
          time = Time.new
          week_reada = true
          ml = 0

          toyear = time.year.to_i
          tomonth = time.month.to_i
          today = time.yday.to_i
          stoday = time.wday.to_i

          compile = [[], [], [], [], [], [], [], []]

            for x in 0..6

              begin
                day = watert_file.gets.to_i

                if day == today - x 
                  year = watert_file.gets.to_i
                  month = watert_file.gets.to_i
                  specific_day = watert_file.gets.to_i
                  if year == toyear && month == tomonth
                    ml = watert_file.gets.to_i
                    compile[x] << ml
                  else
                  end
                else
                  year = watert_file.gets.to_i
                  month = watert_file.gets.to_i
                  specific_day = watert_file.gets.to_i 
                  if year == toyear && month == tomonth
                    ml = watert_file.gets.to_i
                    compile[x+1] << ml
                  else
                  end
                end 
                
              end while day == today - x

              open("cache/Week.txt", "a") do |f|
                sum = 0
                compile[x].each { |a| sum+=a }
                f.puts sum
              end

            end 

          Weekdisplay.new.show
      else
        @locked = true
      end
      @locked = true
    end
  end
end

class Weekdisplay < Gosu::Window

  def initialize
    super(800, 600, false)
    self.caption = "Analysis-Week page"

    #Background
    @background_image = Gosu::Image.new("media/background.png")
    @title_font = Gosu::Font.new(70)
    @button_font = Gosu::Font.new(40)
    @instruct_font = Gosu::Font.new(30)
    @small_font = Gosu::Font.new(20)

    @boxarea = [[50,500,190,50], [510,500,190,50]]
    @border = [Gosu::Color::argb(0xff_D3D3D3), Gosu::Color::argb(0xff_D3D3D3)]

    @day = [7,7,7,7,7,7,7]
    @days =["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    #Boolean statement 
      @locked = true      
  end

  # Analyze the week
  def analysis
    total_array = Array.new()
    total_file = File.new("cache/Week.txt", "r")

    for y in 0..6
      ml = total_file.gets.to_i
      total_array << ml 
    end

    total = total_array.max { |a, b| a<=>b} 

    watert_file = File.new("cache/Week.txt", "r")
    goal_file = File.new("cache/goal.txt", "r")
    goal = goal_file.gets.to_i
    week_overall = Array.new()

    for z in 0..6
      week_overall << (((watert_file.gets.to_i + 0.0)/total)*(280))
    end

    return week_overall
  end

  def each_week
    watert_file = File.new("cache/Week.txt", "r")
    each_day = Array.new()

    for z in 0..6
      each_day << (watert_file.gets.to_i)
    end

    return each_day
  end

  def day
    time = Time.new

      ans = time.wday
        for z in 0..6
            cday = ans - z
            
            if cday < 0
                cday = 7 + ans - z
            else 
            end
            
            @day[z] = cday
        end
        @day = @day.reverse()
      return @day
  end 

  # Draw function
  def draw
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      @title_font.draw_text("Week analysis", 180, 0, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      @instruct_font.draw_text("Last 7 days", 320, 80, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)


      w = 0
      z = 6 
      while z >= 0 
        gap = 50 + w
        location = 400 - analysis[z]
        Gosu.draw_rect(gap, location, 70, analysis[z], Gosu::Color::argb(0xff_89CFF0), ZOrder::TOP, mode=:default)
        @small_font.draw_text(each_week[z].to_s + "ml",gap+5 , location+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=100
        z-=1
      end

      day_array = day

      w = 0
      for z in 0..6
        gap = 50 + w
        @instruct_font.draw_text(@days[day_array[z]].to_s,gap+5 , 430, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=100
      end

      x = 2
      y = 4

       for z in 0..1
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], Gosu::Color::argb(0xff_F5F5F5), ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
        end

      @button_font.draw_text("Back", @boxarea[0][0]+10, @boxarea[0][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Month", @boxarea[1][0]+10, @boxarea[1][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Where is mouse_x and mouse_y defined

  # Does the hover effects based on the output from mouse_over_button? function
  def update
    @locs = [mouse_x, mouse_y]
    selected = mouse_over_button?(mouse_x, mouse_y)
    if (0..@border.count-1).include? selected
      @border[selected] = Gosu::Color::BLACK
    else
      if @locked == true
        for z in 0..@boxarea.count.to_i-1
            @border[z] = Gosu::Color::argb(0xff_D3D3D3)
        end
      end
   end
  end

   # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if ans == 0
        watert_file = File.new("cache/Water_tracker.txt", "r")
          time = Time.new
          day_read = true
          ml = 0

          toyear = time.year.to_i
          tomonth = time.month.to_i
          today = time.yday.to_i

          while day_read == true

            day = watert_file.gets.to_i
            year = watert_file.gets.to_i
            month = watert_file.gets.to_i
            specific_day = watert_file.gets.to_i

            if year == toyear && month == tomonth && day == today
              newml = watert_file.gets.to_i
              ml = ml + newml
              day_read = true

            else
              ml+= 0
              day_read = false
            end

          end

          open("cache/Day.txt", "w") do |f|
            f.puts ml
          end
        Daydisplay.new.show
      elsif ans == 1
         File.new("cache/Month.txt", "w")
          watert_file = File.new("cache/Water_tracker.txt", "r")
          time = Time.new
          ml = 0

          toyear = time.year.to_i
          tomonth = time.month.to_i
          today = time.yday.to_i
          stoday = time.wday.to_i

          compile = [[], [], [], [], [], [], [], [], [], [], [], [], []]

          day = watert_file.gets.to_i
          year = watert_file.gets.to_i
          month = watert_file.gets.to_i


          watert_file = File.new("cache/Water_tracker.txt", "r")

            for x in 0..month-1

              begin
                day = watert_file.gets.to_i
                year = watert_file.gets.to_i
                month = watert_file.gets.to_i

                if year == toyear
                  specific_day = watert_file.gets.to_i
                  ml = watert_file.gets.to_i
                  compile[x] << ml
                end

                if (tomonth - x) < 0
                  tomonth = tomonth + x
                else
                end
                
              end while month == (tomonth - x)

              open("cache/Month.txt", "a") do |f|
                sum = 0
                compile[x].each { |a| sum+=a }
                f.puts sum
              end
            end

          Monthdisplay.new.show
      else
        @locked = true
      end
      @locked = true
    end
  end
end

class Monthdisplay < Gosu::Window

  def initialize
    super(800, 600, false)
    self.caption = "Analysis-Month page"

    #Background
    @background_image = Gosu::Image.new("media/background.png")
    @title_font = Gosu::Font.new(70)
    @button_font = Gosu::Font.new(40)
    @instruct_font = Gosu::Font.new(30)
    @small_font = Gosu::Font.new(20)
    @locked = true

    @boxarea = [[50,500,245,50], [510,500,190,50]]
    @border = [Gosu::Color::argb(0xff_D3D3D3), Gosu::Color::argb(0xff_D3D3D3)]

    @months =["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    #Boolean statement 
      @locked = true     
  end

  # Analyze the month
  def analysis

    total_array = Array.new()
    total_file = File.new("cache/Month.txt", "r")

    for y in 0..11
      ml = total_file.gets.to_i
      total_array << ml 
    end

    total = total_array.max { |a, b| a<=>b}

    month_overall = Array.new()
    month_analysis = File.new("cache/Month.txt", "r")

    watert_file = File.new("cache/Water_tracker.txt", "r")
    day = watert_file.gets.to_i
    year = watert_file.gets.to_i
    month = watert_file.gets.to_i

    for z in 0..(month-1)
      month_overall << (((month_analysis.gets.to_i + 0.0)/total)*(280))
    end

    return month_overall
  end

  def each_month
    month_overall = Array.new()
    month_analysis = File.new("cache/Month.txt", "r")

    watert_file = File.new("cache/Water_tracker.txt", "r")
    day = watert_file.gets.to_i
    year = watert_file.gets.to_i
    month = watert_file.gets.to_i

    for z in 0..(month-1)
      month_overall << month_analysis.gets.to_i
    end

    return month_overall
  end

  # Draw function
  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
      time = Time.new
      @title_font.draw_text("Month analysis", 180, 0, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

      @instruct_font.draw_text("Year " + time.year.to_s, 320, 80, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)


      w = 0
      z = analysis.length()-1
      while z >= 0
        gap = 20 + w
        location = 400 - analysis[z]
        Gosu.draw_rect(gap, location, 40, analysis[z], Gosu::Color::argb(0xff_89CFF0), ZOrder::MIDDLE, mode=:default)
        @small_font.draw_text(each_month[z].to_s + "ml",gap+5 , location+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=65
        z-=1
      end

      w = 0
      for z in 0..11
        gap = 20 + w
        @small_font.draw_text(@months[z], gap+5 , 430, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        w+=65
      end

      x = 2
      y = 4

       for z in 0..1
        Gosu.draw_rect(@boxarea[z][0], @boxarea[z][1], @boxarea[z][2], @boxarea[z][3], Gosu::Color::argb(0xff_F5F5F5), ZOrder::TOP, mode=:default)
        Gosu.draw_rect(@boxarea[z][0]-x, @boxarea[z][1]-x, @boxarea[z][2]+y, @boxarea[z][3]+y, @border[z], ZOrder::MIDDLE, mode=:default)
      end

      @button_font.draw_text("Analysis menu", @boxarea[0][0]+10, @boxarea[0][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
      @button_font.draw_text("Main menu", @boxarea[1][0]+10, @boxarea[1][1]+5, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Update the current cursor location
  def mouse_over_button?(mouse_x, mouse_y)
    for z in 0..@border.count.to_i-1
      if ((mouse_x > @boxarea[z][0] and mouse_x < @boxarea[z][0] + @boxarea[z][2]) and (mouse_y > @boxarea[z][1] and mouse_y < @boxarea[z][1] + @boxarea[z][3]))
        return z
      else
        false
      end
    end 
  end

  # Where is mouse_x and mouse_y defined

  # Does the hover effects based on the output from mouse_over_button? function
  def update
    @locs = [mouse_x, mouse_y]
    selected = mouse_over_button?(mouse_x, mouse_y)
    if (0..@border.count-1).include? selected
      @border[selected] = Gosu::Color::BLACK
    else
      if @locked == true
        for z in 0..@boxarea.count.to_i-1
            @border[z] = Gosu::Color::argb(0xff_D3D3D3)
        end
      end
   end
  end

   # Choose an option
  def button_down(id)
    case id
    when Gosu::MsLeft
      time = Time.new
      ans = mouse_over_button?(mouse_x, mouse_y)

      if ans == 0

        Analysis.new.show

      elsif ans == 1
        Menu.new.show
      else
        @locked = true
      end
      @locked = true
    end
  end
end

Menu.new.show

