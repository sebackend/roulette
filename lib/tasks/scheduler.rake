namespace :tasks do
  desc "Esta tarea se ejecuta al final de cada día para dar 10.000 a cada jugador"
  task :give_money_to_all => :environment do
    Player.all.each do |player|
      player.get_prize(10000)
    end
    puts "Terminado!"
  end

  desc "Comenzar una nueva ronda cada 10 minutos"
  task :start_new_round => :environment do
    Round.create
    puts "Terminado!"
  end
end