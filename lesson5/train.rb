class Train
  attr_reader :carriages, :number, :route, :stat_index, :speed
  include Manifacturer
  include InstanceCounter
  include Validate
  @@trains = {}

  CONST_NUMBER = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @stat_index = 0
    @carriages = []
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def up_speed
    @speed += 10
  end

  def stop
    @speed = 0
    puts "Поезд остановлен"
  end

  def route_reception(route)
    @route = route
    @route.stations.first.add_train(self)#поезд добавляется на первую станцию
  end

  def go_next_station
    if current_station == @route.stations.last
      puts 'Вы на крайней станции, дальше нельзя поехать!!!'
    else
      current_station.send_train(self)
      @stat_index += 1
      current_station.add_train(self)
    end
  end

  def go_back_station
    if current_station == @route.stations.first
      puts 'Вы на первой станции, назад нельзя поехать!!!'
    else
      current_station.send_train(self)
      @stat_index -= 1
      current_station.add_train(self)
    end
  end

  def add_carriage(carriage)
    @carriages << carriage
  end

  def current_station
    @route.stations[@stat_index]#текущая станция
  end

  def next_station
    @route.stations[@stat_index + 1]
  end

  def previous_station
    @route.stations[@stat_index - 1]
  end

  private

  def validate!
    raise 'Количество букв и цифр может быть только 5 или 6' if @number.length > 6
    raise 'Неправильный формат номера.Пример: XXXXX ,XXX-XX' if @number !~ CONST_NUMBER
  end
end
