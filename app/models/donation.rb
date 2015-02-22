require 'digest/sha1'

class Donation < ActiveRecord::Base
  belongs_to :donor
  belongs_to :driver
  belongs_to :recipient

  after_save :generate_md5hash

  scope :has_been_completed, -> { where(completed: true) }

  def complete!
    self.status = 'Arrived at Recipient'
    self.completed = true
    self.completed_at = DateTime.now
    self.save!
  end

  def arrived_at_donor!
    self.status = 'Arrived at Donor'
    self.save!
  end

  def start!
    self.status = 'Driver In Progress'
    self.save!
  end

  private

  def generate_md5hash
    unless self.driver_to_donor_handshake && self.donor_to_recipient_handshake
      self.update_columns({
        driver_to_donor_handshake: Digest::SHA1.hexdigest(self.id.to_s + 'donor-handshake'),
        donor_to_recipient_handshake: Digest::SHA1.hexdigest(self.id.to_s + 'recipient-handshake'),
        status: 'Pending'
      })
    end
  end
end
