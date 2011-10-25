# Put hierarchy at beginning of search path
$:.unshift File.join(File.dirname(__FILE__))

# Module containing equivalent subversion commands for use
# in ruby scripts. Note that the structure of, and any associated
# smart ideas within, this module were unceremoniously cribbed
# from the fileutils module.

module Svn_Util
  require 'rexml/document'
  
  class Svn
  
    # Hash tables to hold command options.
    OPT_TABLE = {}   #:nodoc:


    attr_accessor :noop
    
    def initialize(noop = false)
      @noop = noop
      @history = []
    end
  
    

    # -------------------------------------------------------
    # Methods implementing the various subversion subcommands
    # -------------------------------------------------------
    
    #
    # add: Add files, directories, or symbolic links.
    #
    # Calling sequence: add(list,options={})
    #
    # Options: auto_props
    #          depth ARG
    #          force
    #          no_auto_props
    #          no_ignore
    #          parents
    #          quiet
    #          targets FILENAME
    #
    def add(list,options={})
      svn_check_options(options, OPT_TABLE['add'])
      option_list = svn_process_options(options)
      cmd = "svn add #{option_list} #{list}"
      svn_run_command(cmd)
    end
  
    OPT_TABLE['add'] = [:auto_props, :depth, :force, :no_auto_props, :no_ignore,
                        :parents, :quiet, :targets]


    #
    # checkout: Check out a working copy from a repository
    #
    # Calling sequence: checkout(url,path,options={})
    #
    # Aliases: co
    #
    # Options: depth ARG
    #          force
    #          ignore_externals
    #          quiet
    #          revision REV
    #
    def checkout(url,path,options={})
      svn_check_options(options, OPT_TABLE['checkout'])
      option_list = svn_process_options(options)
      cmd = "svn checkout #{option_list} #{url} #{path}"
      svn_run_command(cmd)
    end
  
    alias co checkout
  
    OPT_TABLE['checkout'] =
    OPT_TABLE['co']       = [:depth, :force, :ignore_externals, :quiet, :revision]


    #
    # commit: Send changes from your working copy to the repository
    #
    # Calling sequence: commit(path,options={})
    #
    # Aliases: ci
    #
    # Options: depth ARG
    #          editor_cmd CMD
    #          encoding ENC
    #          file FILENAME
    #          force_log
    #          keep_changelists
    #          message MESSAGE
    #          no_unlock
    #          quiet
    #          targets FILENAME
    #          with_revprop ARG
    #
    def commit(path,options={})
      svn_check_options(options, OPT_TABLE['commit'])
      option_list = svn_process_options(options)
      cmd = "svn commit #{option_list} #{path}"
      svn_run_command(cmd)
    end
  
    alias ci commit
  
    OPT_TABLE['commit'] = 
    OPT_TABLE['ci']     = [:depth, :editor_cmd, :encoding, :file, :force_log,
                           :keep_changelists, :message, :no_unlock, :quiet,
                           :targets, :with_revprop]


    #
    # copy: Copy a file or directory in a working copy or in the repository.
    #
    # Calling sequence: copy(source,destination,options={})
    #
    # Aliases: cp
    #
    # Options: editor_cmd CMD
    #          encoding ENC
    #          file FILENAME
    #          force_log
    #          ignore_externals
    #          message MESSAGE
    #          parents
    #          quiet
    #          revision REV
    #          with_revprop ARG
    #
    def copy(source,destination,options={})
      svn_check_options(options, OPT_TABLE['copy'])
      option_list = svn_process_options(options)
      cmd = "svn copy #{option_list} #{source} #{destination}"
      svn_run_command(cmd)
    end
  
    alias cp copy
  
    OPT_TABLE['copy'] = 
    OPT_TABLE['cp']   = [:editor_cmd, :encoding, :file, :force_log, :ignore_externals,
                         :message, :parents, :quiet, :revision, :with_revprop]


    #
    # delete: Delete an item from a working copy or the repository.
    #
    # Calling sequence: delete(list,options={})
    #
    # Aliases: del, remove, rm
    #
    # Options: editor_cmd CMD
    #          encoding ENC
    #          file FILENAME
    #          force
    #          force_log
    #          keep_local
    #          message MESSAGE
    #          quiet
    #          targets FILENAME
    #          with_revprop ARG
    #
    def delete(list,options={})
      svn_check_options(options, OPT_TABLE['delete'])
      option_list = svn_process_options(options)
      cmd = "svn delete #{option_list} #{list}"
      svn_run_command(cmd)
    end
  
    alias del    delete
    alias remove delete
    alias rm     delete
  
    OPT_TABLE['delete'] = 
    OPT_TABLE['del']    = 
    OPT_TABLE['remove'] = 
    OPT_TABLE['rm']     = [:editor_cmd, :encoding, :file, :force, :force_log, :keep_local,
                           :message, :quiet, :targets, :with_revprop]


    #
    # info: Display information about a local or remote item.
    #
    # Calling sequence: info(list,options={})
    #
    # Options: changelist ARG
    #          depth ARG
    #          incremental
    #          recursive
    #          revision REV
    #          targets FILENAME
    #          xml
    #
    def info(list,options={})
      svn_check_options(options, OPT_TABLE['info'])
      option_list = svn_process_options(options)
      cmd = "svn info #{option_list} #{list}"
      svn_run_command(cmd)
    end
  
    OPT_TABLE['info'] = [:changelist, :depth, :incremental, :recusrsive, :revision, 
                         :targets, :xml]


    #
    # log: Display commit log messages.
    #
    # Calling sequence: log(path,options={})
    #
    # Options: change ARG
    #          incremental
    #          limit NUM
    #          quiet
    #          revision REV
    #          stop_on_copy
    #          targets FILENAME
    #          use_merge_history
    #          verbose
    #          with_all_revprops
    #          with_no_revprops
    #          with_revprop ARG
    #          xml
    #
    def log(path,options={})
      svn_check_options(options, OPT_TABLE['log'])
      option_list = svn_process_options(options)
      cmd = "svn log #{option_list} #{path}"
      svn_run_command(cmd)
    end
  
    OPT_TABLE['log'] = [:change, :incremental, :limit, :quiet, :revision,
                        :stop_on_copy, :targets, :use_merge_history, :verbose,
                        :with_all_revprops, :with_no_revprops, :with_revprop, :xml]


    #
    # revert: Undo all local edits.
    #
    # Calling sequence: revert(path,options={})
    #
    # Options: changelist ARG
    #          depth ARG
    #          quiet
    #          recursive
    #          targets FILENAME
    #
    def revert(path,options={})
      svn_check_options(options, OPT_TABLE['revert'])
      option_list = svn_process_options(options)
      cmd = "svn revert #{option_list} #{path}"
      svn_run_command(cmd)
    end
  
    OPT_TABLE['revert'] = [:changelist, :depth, :quiet, :recursive, :targets]


    #
    # mkdir: Create a new directory under version control.
    #
    # Calling sequence: mkdir(new,options={})
    #
    # Options: editor_cmd CMD
    #          encoding ENC
    #          file FILENAME
    #          force_log
    #          message MESSAGE
    #          parents
    #          quiet
    #          with_revprop ARG
    #
    def mkdir(new,options={})
      svn_check_options(options, OPT_TABLE['mkdir'])
      option_list = svn_process_options(options)
      cmd = "svn mkdir #{option_list} #{new}"
      svn_run_command(cmd)
    end
  
    OPT_TABLE['mkdir'] = [:editor_cmd, :encoding, :file, :force_log, :message,
                          :parents, :quiet, :with_revprop]


    #
    # status: Print the status of working copy files and directories.
    #
    # Calling sequence: status(path,options={})
    #
    # Aliases: stat, st
    #
    # Options: changelist ARG
    #          depth ARG
    #          ignore_externals
    #          incremental
    #          no_ignore
    #          quiet
    #          show_updates
    #          verbose
    #          xml
    #
    def status(path,options={})
      svn_check_options(options, OPT_TABLE['status'])
      option_list = svn_process_options(options)
      cmd = "svn status #{option_list} #{path}"
      svn_run_command(cmd)
    end
  
    alias st   status
    alias stat status

    OPT_TABLE['status'] = 
    OPT_TABLE['st']     =
    OPT_TABLE['stat']   = [:changelist, :depth, :ignore_externals, :incremental, :no_ignore,
                           :quiet, :show_updates, :verbose, :xml]
  

    # -------------
    # Other methods
    # -------------
    
    #
    # history: Print the history of subversion subcommands.
    #
    # Calling sequence: history(full = false)
    #
    def history(full = false)
      @history.each_with_index do |h, i|
        puts("#{i} command: #{h[:command]}")
        puts("  + output:\n#{h[:output]}") if full
        puts("  + result: #{h[:result]}")
      end
    end


    #
    # versioned?: Determine if a path is versioned.
    #
    # Calling sequence: versioned?(path)
    #
    def versioned?(path)
      return false if @noop
      return false unless File.exist?(path)
      status(path, :verbose => true, :xml => true)
      
      # XML-ise the status info
      xml = REXML::Document.new((@history.pop)[:output])

      # Target and entry path should be the same
      # Only one entity at a time is tested
      target_path = xml.elements["*/target"].attributes["path"]
      entry_path  = xml.elements["*/target/entry"].attributes["path"]
      return false unless target_path==entry_path
      
      # Check working copy status
      xml.elements["*/target/entry/wc-status"].attributes["item"] != "unversioned"
    end
    
  
  private

  
    def svn_run_command(command)  #:nodoc:
      if @noop
        puts(command)
        result = 0
      else
        output = `#{command}`
        result = $?
        @history.push({:command=>command, :output=>output, :result=>result})
        puts(output)
      end
      result == 0
    end
  
  
    def svn_check_options(options, optdecl)   #:nodoc:
      h = options.dup
      optdecl.each do |opt|
        h.delete opt
      end
      raise ArgumentError, "no such option: #{h.keys.join(' ')}" unless h.empty?
    end
  
  
    def svn_process_options(options)   #:nodoc:
      option_list = ""
      options.each do |opt, value|
        opt_name = opt.to_s
        case opt
          # Options with a value
          when :auto_props, :change, :changelist, :depth, :editor_cmd, :encoding, :file, 
               :limit, :no_auto_props, :revision, :targets, :with_revprop
            option_list << "--#{opt_name} #{value} "
          # Boolean options
          when :force, :force_log, :keep_changelists, :keep_local, :ignore_externals, :incremental,
               :no_ignore, :no_unlock, :parents, :quiet, :recursive, :show_updates, :stop_on_copy,
               :use_merge_history, :verbose, :with_all_revprops, :with_no_revprops, :xml
            option_list << "--#{opt_name} " if value
          # Special treatment
          when :message
            option_list << "--#{opt_name} \"#{value}\" "
          else
            raise ArgumentError, "argument #{opt_name} invalid or not defined yet!!"
        end
      end
      option_list.rstrip
    end

  end  # Class Svn
  
end  # Module Svu_Util
