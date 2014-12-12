module Petshop
  class CatsRepo
    def self.all_from_shop(db, id)
      db.exec(%q[SELECT id, shopid, name, imageurl AS "imageUrl", adopted FROM dogs WHERE shopid = $1], [id]).to_a
    end
  end
end