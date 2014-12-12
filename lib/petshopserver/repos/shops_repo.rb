module Petshopserver
  class ShopsRepo
    def self.get_all_shops(db)
      shops = db.exec('SELECT * FROM shops').to_a
    end  
  end
end