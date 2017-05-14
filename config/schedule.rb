#Para hacer pruebas en developtment, para production se usará Heroku-Scheduler

every 3.minutes do
  runner "tasks:start_new_round", :environment => "development"
end

every 1.day, :at => '23:59 pm' do
  rake "tasks:give_money_to_all", :environment => "development"
end