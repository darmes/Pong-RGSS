module Kernel

	def rgss_require_relative(filename)
		full_path = Dir.getwd + '/' + filename
		require(full_path)
	end

end