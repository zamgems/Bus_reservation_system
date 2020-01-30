require 'rails_helper'

RSpec.describe Owner::BusesController, type: :controller do
  describe "GET index" do
    it "assigns @buses" do
      bus = Bus.create
      get :index
      expect(assigns(:buses)).to eq([bus])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

end
