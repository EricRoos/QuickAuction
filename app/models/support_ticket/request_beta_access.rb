# frozen_string_literal: true

class SupportTicket
  class RequestBetaAccess < SupportTicket
    validates_uniqueness_of :user, scope: :type

    def self.available_for?(user)
      !where(user: user).exists?
    end

    def supports_description?
      false
    end
  end
end
