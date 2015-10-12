# Loads all *.rb files in the Scripts folder
Dir.chdir(Dir.getwd + "/Scripts") do |path| # path is full path
	Dir.foreach(path) do |filename|
		regex = /(\.rb)$/
		if filename =~ regex
			require(path + "/" + filename)
		end
	end	
end