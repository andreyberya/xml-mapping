#!/usr/bin/env rake
require 'rubygems'
require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'
require 'build_lib/my_rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
#require 'rake/contrib/rubyforgepublisher'
require 'rake/contrib/sshpublisher'


desc "Default Task"
task :default => [ :test ]

Rake::TestTask.new(:test) { |t|
  t.test_files = ["test/all_tests.rb"]
  t.verbose = true
#  t.loader = :testrb
}

# runs tests only if sources have changed since last succesful run of
# tests
file "test_run" => FileList.new('lib/**/*.rb','test/**/*.rb') do
  Task[:test].invoke
  touch "test_run"
end

rule '.intout' => ['.intin.rb'] do |task|
  this_file_re = Regexp.compile(Regexp.quote(__FILE__))
  b = binding
  visible=true; visible_retval=true; handle_exceptions=false
  old_stdout = $stdout
  old_wd = Dir.pwd
  begin
    File.open(task.name,"w") do |fout|
      $stdout = fout
      File.open(task.source,"r") do |fin|
        Dir.chdir File.dirname(task.name)
        fin.read.split("#<=\n").each do |snippet|

          snippet.scan(/^#:(.*?):$/) do |(switch)|
            case switch
            when "visible"
              visible=true
            when "invisible"
              visible=false
            when "visible_retval"
              visible_retval=true
            when "invisible_retval"
              visible_retval=false
            when "handle_exceptions"
              handle_exceptions=true
            when "no_exceptions"
              handle_exceptions=false
            end
          end
          snippet.gsub!(/^#:.*?:(?:\n|\z)/,'')

          print "#{snippet}\n" if visible
          exc_handled = false
          value = begin
                    eval(snippet,b)
                  rescue Exception
                    raise unless handle_exceptions
                    exc_handled = true
                    if visible
                      print "#{$!.class}: #{$!}\n"
                      for m in $@
                        break if m=~this_file_re
                        print "\tfrom #{m}\n"
                      end
                    end
                  end
          if visible and visible_retval and not exc_handled
            print "=> #{value.inspect}\n"
          end
        end
      end
    end
  rescue Exception
    $stdout = old_stdout
    Dir.chdir old_wd
    File.delete task.name
    raise
  ensure
    $stdout = old_stdout
    Dir.chdir old_wd
  end
end

file 'examples/company_usage.intout' => ['examples/company.xml']
file 'examples/documents_folders_usage.intout' => ['examples/documents_folders.xml']
file 'examples/order_signature_enhanced_usage.intout' => ['examples/order_signature_enhanced.xml']
file 'examples/order_usage.intout' => ['examples/order.xml']
file 'examples/stringarray_usage.intout' => ['examples/stringarray.xml']
