class User < ActiveRecord::Base
  has_many :rounds
  has_many :decks, through: :rounds

  validates :username, length: {maximum: 10}, uniqueness: true, presence: true, format: /\A[ 0-9a-z]+\z/i
  validates :password, length: {maximum: 12}

  #this is going to be our method for defining
  #how "strong" the encryption algorithm is
  def self.encrypt(pword = "")
    Digest::SHA256.hexdigest(Digest::MD5.hexdigest(pword)).slice(20..-20)
  end
  # Remember to create a migration!
  def self.authenticate(uname = "", pword = "")
    #no free ride, you pay!
    return false if uname == "" || pword == ""
    #now we encrypt it if neither are bland because it
    #would be a waste of power to do so and have it empty
    pword = encrypt(pword)
    obj   = User.where('username = ?',uname).first
    if !obj.nil?
      obj.password == pword ? true : false
    end
  end

end
