require "spec_helper"

describe NOAA do
  describe NOAA::HttpService do
    let(:http_service) { NOAA::HttpService.new(HTTP) }

    describe "#get_current_conditions" do
      it 'sends a properly-formed URL for current conditions' do
        pending
      end

      it 'returns a XML document for current conditions' do
        pending
      end
    end

    describe "#get_forecast" do
      it 'sends a properly-formed URL for forecast' do
        pending
      end

      it 'returns a XML document for forecast' do
        pending
      end
    end

    describe "#get_station_list" do
      it 'sends a properly-formed URL for station list' do
        pending
      end

      it 'returns a XML document for station list' do
        pending
      end
    end
  end
end
