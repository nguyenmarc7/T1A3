require "tty-prompt"
require "date"
require "colorize"
require_relative "clear"

module Add

    def add(tasks)

        task = {}

        prompt = TTY::Prompt.new

        name = prompt.ask('Assign a task name:'.colorize(:light_green ).colorize( :background => :light_black)) do |q| q.required true end
        ::Screen::clear

        while name.split("").length > 40
            detail = prompt.ask('Too many characters. Please provide a shorter name:'.colorize(:light_green ).colorize( :background => :light_black)) do |q| q.required true end
        end

        task[:name] = name

        date = prompt.ask('Assign a due date ("dd/mm/yyyy"):'.colorize(:light_green ).colorize( :background => :light_black)) do |q| q.required true end
        ::Screen::clear

        while ((1..31).include?(date.split("/")[0].to_i) && (01..12).include?(date.split("/")[1].to_i) && (date.split("/")[2].to_i) > 2019 && ("/").include?(date.split("")[2]) && ("/").include?(date.split("")[5]) && date.split('/').reverse.join.to_i >= Time.now.strftime("%d/%m/%Y").split('/').reverse.join.to_i) == false
            date = prompt.ask('Invalid date or formatting. Please re-enter a due date:'.colorize(:light_green ).colorize( :background => :light_black)) do |q| q.required true end
            ::Screen::clear
        end 
        
        task[:date] = date

        detail = prompt.ask('Please provide a short description:'.colorize(:light_green ).colorize( :background => :light_black)) do |q| q.required true end
        ::Screen::clear

        while detail.split("").length > 100
        detail = prompt.ask('Too many characters. Please provide a shorter description:'.colorize(:light_green ).colorize( :background => :light_black)) do |q| q.required true end
        ::Screen::clear
        end
        
        task[:detail] = detail

        tasks << task
    end

    module_function :add

end
