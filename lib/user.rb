class User
  # simple class to store the logged users and related infos in memory - next step: add redis

  USERS = []

  def self.find(id:)
    USERS.find{ |u| u.fetch(:id) == id }
  end

  def self.first(clef_id:)
    USERS.find{ |u| u.fetch(:clef_id) == clef_id }
  end

  def self.create(clef_id:, email:)
    user = { clef_id: clef_id, email: email, id: "USR_#{SecureRandom.hex 6}" }
    USERS << user
    user
  end
end
