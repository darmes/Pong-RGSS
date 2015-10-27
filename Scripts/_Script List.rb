# Array of the folders/sub-folders that need to be loaded
paths = [
		'Scripts',
		'Scripts/Utility Scripts',
		'Scripts/Game Scripts',
		'Scripts/Sprite Scripts',
		'Scripts/Spriteset Scripts',
		'Scripts/Scene Scripts',
]
# Loads all *.rb files in all the folders listed above
paths.each do |relative_path|
	path = Dir.getwd + '/' + relative_path
		Dir.foreach(path) do |filename|
			regex = /(\.rb)$/
			if filename =~ regex
				require(path + "/" + filename)
			end
		end
end