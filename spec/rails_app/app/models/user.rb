# frozen_string_literal: true

class User < ApplicationRecord
  devise :rememberable, :omniauthable, omniauth_providers: [:infinum_azure]

  validates :email, uniqueness: true

  def remember_me
    true
  end

  def as_json
    {
      email: email
    }
  end
end
