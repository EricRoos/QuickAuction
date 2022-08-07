# frozen_string_literal: true

class SupportTicket
  class RequestBetaAccess < SupportTicket
    validates_uniqueness_of :user, scope: :type
  end
end
