class User < ApplicationRecord

  has_secure_password
  has_one :pilot_logbook

  scope :sorted, lambda { order("id ASC") }

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :first_name, :presence => true,
                         :length => { in: 2..25 }
  validates :first_name, :presence => true,
                         :length => { in: 2..50 }
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true

  def name
    "#{first_name} #{last_name}"
  end
  
end
