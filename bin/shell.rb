require File.dirname(__FILE__) + '/../lib/rush'
require 'readline'

def print_result(res)
	if res.kind_of? String
		puts res
	elsif res.kind_of? Array
		res.each do |item|
			puts item
		end
	else
		puts "=> #{res.inspect}"
	end
end

root = Rush::Dir.new('/')
home = Rush::Dir.new(ENV['HOME'])
pwd = Rush::Dir.new(ENV['PWD'])

pure_binding = Proc.new { }
$last_res = nil

loop do
	cmd = Readline.readline('rush> ')

	if cmd.nil?
		puts
		exit
	end

	next if cmd == ""

	Readline::HISTORY.push(cmd)

	begin
		res = eval(cmd, pure_binding)
		$last_res = res
		eval("_ = $last_res", pure_binding)
		print_result res
	rescue Exception => e
		puts e
	end
end
