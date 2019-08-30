json.extract! bus, :id, :name, :registration_no, :source, :destination, :total_seats, :owner_id, :status, :created_at, :updated_at
json.url bus_url(bus, format: :json)
