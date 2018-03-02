require 'rubygems'
require 'bundler/setup'
require 'mechanize'

main_page = 'https://opac.biblio.iteso.mx/vufind/MyResearch/Home'
user = ENV['USERNAME']
password = ENV['PASSWORD']

if user.nil? || password.nil?
  print 'missing user, password'
  exit(0)
end

agent = Mechanize.new
page = agent.get(main_page)
pp page

form = page.form('loginForm')
form.username = user
form.password = password
pp "--- / --- / --- / ---"
pp form

page = agent.submit(form, form.buttons.first)
pp "--- / --- / --- / ---"
pp page

form = page.form('renewals')
button = form.button_with(:name => /renewAll/)
page = agent.submit(form, button)
pp "--- / --- / --- / ---"
pp page
pp "--- / --- / --- / ---"
pp page.body
