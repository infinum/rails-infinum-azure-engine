class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:infinum_azure]

  validates :email, uniqueness: true

  def as_json
    {
      email: email,
      name: name
    }
  end
end
