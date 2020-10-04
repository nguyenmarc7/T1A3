module Screen
    def clear
        print "\e[2J\e[f"
    end
    module_function :clear
end
