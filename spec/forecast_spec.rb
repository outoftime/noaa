require "spec_helper"

describe NOAA do
  describe NOAA::Forecast do
    let(:xml_doc) { LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', '4-day.xml')) }
    let(:forecast) { NOAA::Forecast.from_xml(xml_doc) }

    describe "#length" do
      it "returns the number of days" do
        expect(forecast.length).to eq 4
      end
    end

    describe "[i]#starts_at" do
      it "return correct start time for each day" do
        ['2008-12-23', '2008-12-24',
         '2008-12-25', '2008-12-26'].each_with_index do |date, i|
          expect(forecast[i].starts_at)
          .to eq Time.parse("#{date} 06:00:00 -05:00")
        end
      end
    end

    describe "[i]#ends_at" do
      it "return correct end time for each day" do
        ['2008-12-24', '2008-12-25',
         '2008-12-26', '2008-12-27'].each_with_index do |date, i|
          expect(forecast[i].ends_at)
          .to eq Time.parse("#{date} 06:00:00 -05:00")
        end
      end
    end

    describe "[i]#high" do
      it "return correct high for each day" do
        [32, 49, 43, 41].each_with_index do |temp, i|
          expect(forecast[i].high).to eq temp
        end
      end
    end

    describe "a specification" do
      it "returns the correct low for each day" do
        [31, 41, 33, 39].each_with_index do |temp, i|
          expect(forecast[i].low).to eq temp
        end
      end
    end

    describe "#weather_summary" do
      it "returns the correct weather summary for each day" do
        ['Rain', 'Rain', 'Slight Chance Rain', 'Chance Rain'].each_with_index do |summary, i|
          expect(forecast[i].weather_summary).to eq summary
        end
      end
    end

    describe "#weather_type_code" do
      it "returns the correct weather type code for each day" do
        4.times do |i|
          expect(forecast[i].weather_type_code).to eq :ra
        end
      end
    end

    describe "a specification" do
      it "returns the correct image URL for each day" do
        [80, 90, 20, 50].each_with_index do |probability, i|
          expect(forecast[i].image_url).to eq "http://www.nws.noaa.gov/weather/images/fcicons/ra#{probability}.jpg"
        end
      end
    end

    describe "a specification" do
      it "returns the correct daytime probability of precipitation for each day" do
        [5, 94, 22, 50].each_with_index do |probability, i|
          expect(forecast[i].daytime_precipitation_probability).to eq probability
        end
      end
    end

    describe "a specification" do
      it "returns the correct evening probability of precipitation for each day" do
        [77, 84, 19, 50].each_with_index do |probability, i|
          expect(forecast[i].evening_precipitation_probability).to eq probability
        end
      end
    end
  end
end
