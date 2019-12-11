require 'fileutils'

# Jekyll Hook - runs ruby script to generate _posts from
# list of collections specified in the _config.yml
Jekyll::Hooks.register :site, :after_reset do |site|
  posts_dir = '_posts'
  FileUtils.mkdir_p(posts_dir)
  for collection in site.collections do
  	label = collection[0]
  	object = collection[1]
  	for documents in object.docs do
  	  FileUtils.cp(documents.relative_path, posts_dir)
  	end
  end
end