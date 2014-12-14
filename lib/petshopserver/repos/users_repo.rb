module Petshopserver

  class UsersRepo
    # find a user by user ID. Intended to be used when
    # someone is already authenticated. We keep their
    # user id in the cookie.
    def self.find db, user_id
      sql = %q[SELECT * FROM users WHERE id = $1]
      result = db.exec(sql, [user_id])
      result.first
    end

    # find user by username. Intended to be used when
    # someone tries to sign in.
    def self.find_by_username db, username
      sql = %q[SELECT * FROM users WHERE username = $1]
      result = db.exec(sql, [username])
      result.first
    end

    # when someone signs up use this method to save their
    # information in the db. we're not encrypting passwords.
    def self.save db, user_data
      sql = %q[INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *]
      result = db.exec(sql, [user_data[:username], user_data[:password]])
      result.first
    end

    def self.adopt db, user_data
      sql = %q[INSERT INTO userPets (type, user_id, pet_id) VALUES ($1, $2, $3) RETURNING *]
      result = db.exec(sql, [user_data[:type], user_data[:user_id], user_data[:pet_id]])

      if (user_data[:type] == "cat")
        sql = %q[UPDATE cats SET adopted = 'true' WHERE id = $1]
        result = db.exec(sql, [user_data[:pet_id]])
      end

      if (user_data[:type] == "dog")
        sql = %q[UPDATE dogs SET adopted = 'true' WHERE id = $1]
        result = db.exec(sql, [user_data[:pet_id]])
      end
      return "adopted - true"
    end

    def self.get_dog_by_id db, user_data
      sql = %q[SELECT * FROM dogs WHERE id = $1]
      db.exec(sql, [user_data]).to_a.first
    end

    def self.get_cat_by_id db, user_data
      sql = %q[SELECT * FROM cats WHERE id = $1]
      db.exec(sql, [user_data]).to_a.first
    end

    def self.get_pet_adoptions db, user_data
      user_id = user_data['id']
      sql = %q[SELECT d.id, d.name, d.imageurl AS "imageUrl" FROM userPets a JOIN dogs d ON d.id = a.pet_id WHERE user_id = $1 and type = 'dog']
      user_data["dogs"] = db.exec(sql, [user_id]).to_a
      sql = %q[SELECT c.id, c.name, c.imageurl AS "imageUrl" FROM userPets a JOIN cats c ON c.id = a.pet_id WHERE user_id = $1 and type = 'cat']
      user_data["cats"] = db.exec(sql, [user_id]).to_a
      return user_data
    end
  end
end
