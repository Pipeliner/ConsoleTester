require 'yaml'
require 'processpilot/processpilot'
progs = YAML.load_file "test.yaml"
progs.each do |prog|
  puts "running #{prog}..."
  pn = prog["program"]
  tc = 0
  prog["tests"].each do |i, o|
    tc += 1
    puts "Test #{tc}:\n" #{i}\n=>\n#{o}\n--\n"
    ProcessPilot::pilot(pn) do |cin, cout, cerr, cp|
      
      cin.write i
      cin.flush
      
      a = cout.read(:time_out_secs => 5)
      if a != o
        puts "ERROR: wrong output on test #{tc}"
        puts "Input: #{i.inspect}"
        puts "Expected: #{o.inspect}"
        puts "Actual:   #{a.inspect}"
        puts
      else
        puts "ok"
      end

    end

  end
end
