#!/usr/bin/env ruby 
#what: a ruby script to keep an eye on the rumble
#author: Nathan verni - blendebox
#contact: nverni@blenerbox.com
#usage:  command line:  ruby rumble-monit.rub "Compost"
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'date'

def find_place(watched_entry)
  entries = []

  ["","?page=2","?page=3","?page=4","?page=4"].each do |param|
    doc = Hpricot(open('http://railsrumble.com/entries' + param))  
    (doc/".entry .entry_name a").each do |name|
      entries << name.inner_html
    end
  end

  entries.each_with_index do |ent,i|
    if ent == watched_entry
      puts "#{DateTime.now}: #{ent} - #{i}"
      break
    end  
  end
  
end

def start
  watched_entry = ARGV.first
  find_place watched_entry
  sleep 60
  start
end


start