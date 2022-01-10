class AddTestUser < ActiveRecord::Migration[6.1]
  def up
    User.create(username: 'test', password: 'test123')
  end

  def down
    User.find_by(username: 'test')&.destroy
  end
end
