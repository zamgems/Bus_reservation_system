require 'rails_helper'

RSpec.describe Owner::BusesController, type: :controller do
  describe "GET index" do

    let(:user) { User.create(email: "admin@gmail.com", password: '123456', role: "owner", status: "approved", name:"demo") }
    let!(:owner) { Owner.create(user: user) }
    let (:bus) { owner.buses.create(name: 'demo bus')}

    before(:each) do
      sign_in user
    end

    it "assigns @buses" do
      bus
      get :index
      expect(assigns(:buses)).to eq([bus])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

end
