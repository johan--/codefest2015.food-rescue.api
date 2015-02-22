require 'digest/sha1'

class Donation < ActiveRecord::Base
  belongs_to :donor
  belongs_to :driver
  belongs_to :recipient

  after_save :generate_md5hash

  private

  def generate_md5hash
    unless self.driver_to_donor_handshake && self.donor_to_recipient_handshake
      self.update_columns({
        driver_to_donor_handshake: Digest::SHA1.hexdigest(self.id.to_s + 'donor-handshake'),
        donor_to_recipient_handshake: Digest::SHA1.hexdigest(self.id.to_s + 'recipient-handshake')
      })
    end
  end
end
