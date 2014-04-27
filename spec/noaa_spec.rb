describe NOAA do
  it { should respond_to :forecast }
  it { should respond_to :current_conditions }
  it { should respond_to :current_conditions_at_station }
end
