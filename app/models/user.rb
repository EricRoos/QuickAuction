# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :auction_items

  has_many :notifications, as: :recipient

  after_create :agree_to_tos

  protected

  def agree_to_tos
    FinePrint.sign_contract(self, 'terms-of-use')
  end
end
