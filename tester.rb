require 'yaml'
require 'processpilot/processpilot'
require 'fileutils'
ROOT = File.absolute_path(File.dirname __FILE__)
puts ROOT
puts "type 'all' to run all tests, 'exit' to exit, 'cd dir' for FS navigation or 'program123' to run tests on program123"
while true
  print "> "
  ans = gets.chomp
  exit if ans == "exit"
  run_all = (ans == "all")
  p ans[0,3]
  if ans[0,3] == "cd "
    FileUtils.chdir ans[3,100]
    puts "Now at #{FileUtils.pwd}"
    next
  end

  progs = YAML.load_file "test.yaml"
  progs.each do |prog|
    pn = prog["program"]
    # TODO: make compiler run configurable
    `#{ROOT + "/FPC2.6.4/bin/i386-win32/fpc.exe"} #{pn.sub ".exe", ".pas"}`
    next if !run_all && pn != ans
    puts "running #{prog}..."
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
end
