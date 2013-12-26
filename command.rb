require 'rally_api'
require 'csv'

require './Story_CRUD.rb'

# Default workspace is set to "Workspace 1" and project is set to "Rohan-test"
def start
  puts "Enter Workspace: 1. Workspace 1 \t2. USD"
  choice = gets.chomp

  case choice
  when "1" #Choose workspace 1
      
      @workspace = "Workspace 1"
      
      puts "Enter Project:"      
      @project = gets.chomp
      
      puts "Enter your file name:#csv"      
      file_name = gets.chomp
     # puts "Enter command : 1. Update\t2. Read"
     # command = gets.chomp
      puts "Enter command : 1. Create\t2. Update\t3. Read \t4. delete"
      command = gets.chomp

      case command
      when "1" #create
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          result = story_crud.find_userstory_by_id(@rows[@iCount])
          if (result.length != 0)
            puts "Can't create , the same userstory exists!"
            puts "\n"
          else
            story_crud.create_userstory(@rows[@iCount])
          end

          @iCount += 1
        end

      when "2" #update
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.update_userstory(@rows[@iCount])
          puts "\n"
          @iCount += 1
        end
        
      when "3" #read
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        puts "Find 1.By Name\t2.By FormattedID "
        request = gets.chomp
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        case request
        when "1"
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.find_userstory_by_name(@rows[@iCount])
          @iCount += 1
          puts "\n"
        end
        when "2"
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.find_userstory_by_id(@rows[@iCount])
          @iCount += 1
          puts "\n"
        end
        end
      when "4" #delete
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.delete_userstory(@rows[@iCount])
          @iCount += 1
          puts "\n"
        end
      end
              
   when "2"
     @workspace = "USD"
      
      puts "Enter Project:"      
      @project = gets.chomp
      
      puts "Enter your file name:#csv"      
      file_name = gets.chomp
     # puts "Enter command : 1. Update\t2. Read"
     # command = gets.chomp
      puts "Enter command : 1. Create\t2. Update\t3. Read \t4. delete"
      command = gets.chomp

      case command
      when "1" #create
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.create_userstory(@rows[@iCount])
          @iCount += 1
        end

      when "2" #update
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.update_userstory(@rows[@iCount])
          puts "\n"
          @iCount += 1
        end
        
       when "3" #read
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        puts "Find 1.By Name\t2.By FormattedID "
        request = gets.chomp
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        case request
        when "1"
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.find_userstory_by_name(@rows[@iCount])
          @iCount += 1
          puts "\n"
        end
        when "2"
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.find_userstory_by_id(@rows[@iCount])
          @iCount += 1
          puts "\n"
        end
        end
        
      when "4" #delete
        read_file(file_name)
        puts @rows
        
        puts "Workspace #{@workspace}"
        puts "Project #{@project}"
        puts "\n"
        
        story_crud = Story_CRUD.new(@workspace, @project)
        
        @iCount = 0 #@iCount = 0 or rows.length-1
     #   puts @rows[@iCount]
      #  puts @rows.length
        while @iCount < @rows.length
          story_crud.delete_userstory(@rows[@iCount])
          @iCount += 1
          puts "\n"
        end
      end
     
   end
end


def read_file(file_name)
  input = CSV.read(file_name)
  header = input.first
  #puts header
  @rows = []
  (1...input.size).each { |i| @rows << CSV::Row.new(header, input[i]) }
end

start