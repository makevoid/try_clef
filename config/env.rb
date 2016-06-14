require 'bundler'
Bundler.require

path = File.expand_path "../../", __FILE__
PATH = path

clef_configs = JSON.load File.open "#{path}/config/clef.json"
CLEF_APP_ID     = clef_configs["CLEF_APP_ID"]
CLEF_APP_SECRET = clef_configs["CLEF_APP_SECRET"]

require_relative '../lib/clef'
require_relative '../lib/user'
require_relative '../lib/user_api'
require_relative '../lib/string_utils'
