require 'rails_helper'

RSpec.describe Owner::BusesController, type: :controller do
  let(:user) { User.create(email: "admin@gmail.com", password: '123456', role: "owner", status: "approved", name:"demo") }
  let (:bus) { owner.buses.create(name: 'demo bus', registration_no: 'mp101234', source: 'dhamnod', destination: 'indore', total_seats: 4, status: 'available')}

  before(:each) do
    sign_in user
  end
  
  describe "GET index" do
    let!(:owner) { Owner.create(user: user) }

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

  describe "GET new" do
    it "assigns @bus" do
      get :new
      expect(assigns(:bus)).to be_a Bus
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET show" do
    let!(:owner) { Owner.create(user: user) }

    it "assigns @bus" do
      get :show, params: { id: bus.id }
      expect(assigns(:bus)).to eq(bus)
    end

    it "renders the show template" do
      get :show, params: { id: bus.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET edit" do
    let!(:owner) { Owner.create(user: user) }

    it "assigns @bus" do
      get :edit, params: { id: bus.id }
      expect(assigns(:bus)).to eq(bus)
    end

    it "renders the edit template" do
      get :edit, params: { id: bus.id }
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do
    let!(:owner) { Owner.create(user: user) }

    it "redirect to the index action" do
      post :create, params: { bus: {name: 'demo bus', registration_no: 'mp101234', source: 'dhamnod', destination: 'indore', total_seats: 4, status: 'available'} }
      expect(response).to redirect_to owner_buses_path
    end

    it "renders the new template" do
      post :create, params: { bus: {name: 'demo', source: 'dhamnod', destination: 'indore', total_seats: 4, status: 'available'} }
      expect(response).to render_template 'new'
    end
  end

  describe "PUT update" do
    let(:owner) { Owner.create(user: user) }
    let!(:bus) { owner.buses.create(name: 'demo bus', registration_no: 'mp101234', source: 'dhamnod', destination: 'indore', total_seats: 4, status: 'available')}

    it "redirect to the index action" do
      put :update, params: { id: bus.id, bus: {name: 'new demo bus'} }
      expect(response).to redirect_to owner_buses_path
    end

    it "renders the edit template" do
      put :update, params: { id: bus.id, bus: {name: nil} }
      expect(response).to render_template 'edit'
    end
  end

  describe "DELETE destroy" do
    let(:owner) { Owner.create(user: user) }
    let!(:bus) { owner.buses.create(name: 'demo bus', registration_no: 'mp101234', source: 'dhamnod', destination: 'indore', total_seats: 4, status: 'available')}

    it "decreases count by 1" do
      expect{
        delete :destroy, params: { id: bus.id }
      }.to change(Bus, :count).by(-2)
    end
  end
end
