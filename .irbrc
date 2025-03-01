# frozen_string_literal: true

libdir = File.expand_path(File.dirname(__FILE__) + "/lib")
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require "rubygems"
require "bundler/setup"
