class PassengerTrain < Train
  def add_carriage(carriage)
    super(carriage) if carriage.class == CarriagePass
  end
end
