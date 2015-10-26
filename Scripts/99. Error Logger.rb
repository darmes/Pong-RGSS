#==============================================================================
# ** Exception
#------------------------------------------------------------------------------
#  This contains additions to class Exception to aid in debugging
#==============================================================================
class Exception
  
  def mobius_backtrace
    @mobius_backtrace = []
    for line in self.backtrace
      # Get name
      line.gsub!("Section", "")
      section_id = line.slice(0, 3)
      section_name = $RGSS_SCRIPTS[section_id.to_i][1]
      # Get line number
      line_number = line.match(/:\d+/)[0] 
      # Get method
      method_name = line.match(/`\w+'/)
      method_name &&= method_name[0] 
      new_line = section_name + " - Line" + line_number
      new_line << (" in method: " + method_name) if method_name
      @mobius_backtrace.push(new_line)      
    end
  end
  
  def mobius_print_backtrace
    @mobius_backtrace.join("\n")
  end
  
  def mobius_print_to_log
    self.mobius_backtrace
    time = Time.new.strftime("%Y-%m-%d_%H-%M-%S")
    file = File.new("Error Logs/" + time + " error log.txt", "w")
    file.write("Error Message:\n")
    file.write(self.message + "\n\n")
    file.write("Error Backtrace:\n")
    file.write(self.mobius_print_backtrace)
    file.write("\n\nOriginal Backtrace:\n")
    file.write(self.backtrace.join("\n"))
    file.close
  end
  
end

