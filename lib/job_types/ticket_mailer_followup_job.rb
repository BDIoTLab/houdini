module JobTypes
  class TicketMailerFollowupJob < EmailJob
    attr_reader :ticket_ids, :charge_id

    def initialize(ticket_ids, charge_id)
      @ticket_ids = ticket_ids
      @charge_id = charge_id
    end

    def perform
      TicketMailer.followup(@ticket_ids, @charge_id).deliver
    end
  end
end