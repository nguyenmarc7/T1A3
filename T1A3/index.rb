require "tty-prompt"
require "terminal-table"
require "date"
require "colorize"
require_relative "clear"
require_relative "add"
prompt = TTY::Prompt.new

tasks = []
::Screen::clear
puts 'Sotodo'.colorize(:light_green ).colorize( :background => :light_black)

user = "User"
user = ARGV[0] if ARGV[0]

puts "Hey #{user}! Welcome to Sotodo, a task sorting terminal application built on ruby.".colorize(:light_green ).colorize( :background => :light_black)

loop

    if tasks.empty? || tasks == nil

        answer = prompt.select('Begin by pressing \'Enter\' to creating a new task:'.colorize(:light_green ).colorize( :background => :light_black), %w(Add_task))
        ::Screen::clear
        
        ::Add::add(tasks)

    else

        answer = prompt.select('Select an option below to continue:'.colorize(:light_green ).colorize( :background => :light_black), %w(Add_task Delete_task Sort_n_Print))
        ::Screen::clear

        case answer
        when 'Add_task'
            ::Add::add(tasks)

        when 'Delete_task'
            taskid = []
            tasks.each_with_index do |task, index|
                taskid << {id: "#{index + 1}"}.merge(task)
            end

            values = []
            taskid.each {|task| values << task.values}
            
            table = Terminal::Table.new :headings => ['Id', 'Task Name', 'Date Due', 'Details'], :rows => values
            puts table

            id = [*1..tasks.length]
            choice = prompt.select('Select a task to delete:'.colorize(:light_green ).colorize( :background => :light_black), id)

            ::Screen::clear
            tasks.delete_at((tasks.find {|task| task[:id] == choice}).to_i-1)

        
        when 'Sort_n_Print'
            ::Screen::clear
            sorted = tasks.sort_by { |h| h[:date].split('/').reverse }
            values = []
            sorted.each {|task| values << task.values}
            table = Terminal::Table.new :headings => ['Task Name'.colorize(:light_green ).colorize( :background => :light_black),'Date Due'.colorize(:light_green ).colorize( :background => :light_black), 'Details'.colorize(:light_green ).colorize( :background => :light_black)], :rows => values
            puts table
    end

end until answer == "Sort_n_Print"
