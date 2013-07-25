#!/usr/bin/ruby
#
# cylesoft git-update-all script
#
# go through directories, find .git folders, run git commands,
# check local git status, check if there's anything to pull from remotes

# if the short status equals this, it means the repo is clean and no action is required
repo_is_clean_check = "## master\n"

# set this to where git is installed
git_program_path = "/usr/bin/git"

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end
  
  def lightred
	colorize("1;31")
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end
end

use_path = "./"

if ARGF.argv.length > 0 and File.exists?(ARGF.argv[0]) and File.directory?(ARGF.argv[0])
	use_path = ARGF.argv[0];
	puts "Updating (local and remote) and showing statuses of repositories below #{use_path.yellow}"
else
	puts "Updating (local and remote) and showing statuses of repositories below " + "this directory".yellow
end

puts ""

use_path = File.expand_path(use_path) + "/"

Dir.foreach(use_path) do |entry|
	full_path = use_path + entry
	#puts "Found: #{entry}"
	#puts "File: #{entry}" if File.file?(full_path)
	#puts "Dir: #{entry}" if File.directory?(full_path)
	unless entry.eql?(".") or entry.eql?("..") or File.file?(full_path)
		if File.exists?(full_path + "/.git/") and File.directory?(full_path + "/.git/")
			#working_path = File.expand_path(entry);
			working_path = full_path
			git_path = working_path + "/.git/";
			# update remote(s)
			git_remote_update_result = `#{git_program_path} --git-dir="#{git_path}" --work-tree="#{working_path}" fetch --all --quiet`
			# get and show status
			git_status_result = `#{git_program_path} --git-dir="#{git_path}" --work-tree="#{working_path}" status -sb`
			puts "status for #{entry}" if use_path.eql?("./")
			puts "status for #{working_path}" unless use_path.eql?("./")
			#puts git_status_result
			puts "clean, no worries".green if git_status_result.eql?(repo_is_clean_check)
			puts git_status_result.lightred unless git_status_result.eql?(repo_is_clean_check)
			puts "" if git_status_result.eql?(repo_is_clean_check)
		end
	end
end
