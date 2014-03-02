require "spec_helper"

describe NOAA do
  describe NOAA::CurrentConditions do
    let(:xml_doc) { LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'KVAY.xml')) }
    let(:current_conditions) { NOAA::CurrentConditions.from_xml(xml_doc) }

    describe "#observed_at" do
      it "returns observation time" do
        expect(current_conditions.observed_at)
        .to eq Time.parse('2008-12-23 10:54:00 -0500')
      end
    end

    describe "#weather_description" do
      it "returns the weather description" do
        expect(current_conditions.weather_description).to eq 'Fair'
      end
    end

    describe "#weather_summary" do
      it "returns the weather description" do
        expect(current_conditions.weather_summary).to eq 'Fair'
      end
    end

    describe "#weather_type_code" do
      it "returns the weather type code" do
        expect(current_conditions.weather_type_code).to eq :skc
      end
    end

    describe "#temperature" do
      context "when the unit is not specified" do
        it "returns the temperature in farenheit" do
          expect(current_conditions.temperature).to eq 24
        end
      end

      context "when farenheit is specified" do
        it "returns the temperature in farenheit" do
          expect(current_conditions.temperature(:f)).to eq 24
        end
      end

      context "when celsius is specified" do
        it "returns the temperature in celsius" do
          expect(current_conditions.temperature(:c)).to eq -4
        end
      end

      context "when an unknown unit is specified" do
        it "raises an Argument error" do
          expect { current_conditions.temperature(:kelvin) }
          .to raise_error ArgumentError
        end
      end
    end

    describe "#image_url" do
      it "returns the image URL" do
        expect(current_conditions.image_url)
        .to eq 'http://weather.gov/weather/images/fcicons/skc.jpg'
      end
    end

    describe "#relative_humidity" do
      it "returns the relative humidity" do
        expect(current_conditions.relative_humidity)
        .to eq 52
      end
    end

    describe "#wind_direction" do
      it 'returns the wind direction' do
        expect(current_conditions.wind_direction).to eq 'Northwest'
      end
    end

    describe "#wind_degrees" do
      it 'returns the wind degrees' do
        expect(current_conditions.wind_degrees).to eq 330
      end
    end

    describe "#wind_speed" do
      it 'returns the wind speed in MPH' do
        expect(current_conditions.wind_speed).to eq 3.45
      end
    end

    describe "#wind_gust" do
      it 'returns the wind gust in MPH' do
        expect(current_conditions.wind_gust).to eq 10.25
      end
    end

    describe "#pressure" do
      context "when the unit is not specified" do
        it 'returns the pressure in inches' do
          expect(current_conditions.pressure).to eq 30.7
        end
      end

      context "when the provided unit is 'in'" do
        it 'returns the pressure in inches' do
          expect(current_conditions.pressure(:in)).to eq 30.7
        end
      end

      context "when the provided unit is 'mb'" do
        it 'returns the pressure in millibars' do
          expect(current_conditions.pressure(:mb)).to eq 1039.5
        end
      end

      context "when the provided unit is not recognized" do
        it 'raises an ArgumentError' do
          expect { current_conditions.pressure(:psi) }.to raise_error(ArgumentError)
        end
      end
    end


    describe "#dew_point" do
      context "when the unit is not specified" do
        it 'returns the dew point in fahrenheit' do
          expect(current_conditions.dew_point).to eq 9
        end
      end

      context "when the provided unit is farenheit" do
        it 'returns the dew point in fahrenheit' do
          expect(current_conditions.dew_point(:f)).to eq 9
        end
      end

      context "when the provided unit is celsius" do
        it 'returns the dew point in celsius' do
          expect(current_conditions.dew_point(:c)).to eq -13
        end
      end

      context "when the provided unit is not recognized" do
        it 'raises an ArgumentError' do
         expect { current_conditions.dew_point(:kelvin) }
         .to raise_error(ArgumentError)
        end
      end
    end

    describe "#heat_index" do
      it 'returns the heat index in fahrenheit by default' do
        expect(current_conditions.heat_index).to eq 105
      end

      context "when the provided unit is farenheit" do
        it 'returns the heat index in fahrenheit' do
          expect(current_conditions.heat_index(:f)).to eq 105
        end
      end

      context "when the provided unit is celsius" do
        it 'returns the heat index in celsius' do
          expect(current_conditions.heat_index(:c)).to eq 41
        end
      end

      context "when the provided unit is unrecognized" do
        it 'raises an ArgumentError' do
         expect { current_conditions.heat_index(:kelvin) }
         .to raise_error(ArgumentError)
        end
      end

      context "when the heat index is NA"
    end

    describe "#wind_chill" do
      it 'returns the wind chill in fahrenheit by default' do
        expect(current_conditions.wind_chill).to eq 19
      end

      context "when the provided unit is farenheit" do
        it 'returns the wind chill in fahrenheit' do
          expect(current_conditions.wind_chill(:f)).to eq 19
        end
      end

      context "when the provided unit is celsius" do
        it 'returns the wind chill in celsius' do
          expect(current_conditions.wind_chill(:c)).to eq -7
        end
      end

      context "when the provided unit is unrecognized" do
        it 'raises an ArgumentError' do
         expect { current_conditions.wind_chill(:kelvin) }.to raise_error(ArgumentError)
        end
      end

      context "when the heat index is NA"
    end


    describe "#visibility" do
      it 'returns the visibility in miles' do
        expect(current_conditions.visibility).to eq 10.0
      end
    end
  end
end
