require 'fileutils'

posts_dir = '_posts'

# Jekyll Hook - runs ruby script to generate _posts from list of
# collections specified in the _config.yml before site generation
Jekyll::Hooks.register :site, :after_init do |site|
	FileUtils.rm_r(posts_dir)
	FileUtils.mkdir_p(posts_dir)
	for collection in site.config['collections'].keys do
		dir_name = '_' + collection
		if collection != 'posts' and Dir.exist?(dir_name)
			collection_posts = Dir.entries(dir_name).reject{|entry| entry == '.' || entry == '..'}
			copy_collection_into_posts_dir(dir_name, collection_posts, posts_dir)
		end
	end
end

def copy_collection_into_posts_dir(collection_dir, collection_posts, posts_dir)
	for file in collection_posts do
		FileUtils.cp(collection_dir + '/' + file, posts_dir)
	end
end
