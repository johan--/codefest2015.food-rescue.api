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

    devices = []

    if self.donor.device_id
      devices << self.donor.device_id
    end

    if devices.length > 0
      PushNotification.new.notify_devices({
        content: "#{self.driver.first_name} has delivered your donation.",
        devices: devices
      })
    end

    devices = []

    if self.driver.device_id
      devices << self.driver.device_id
    end

    if devices.length > 0
      PushNotification.new.notify_devices({
        content: "#{self.driver.first_name}! Thanks for donating your time to Food+Rescue",
        devices: devices
      })
    end

  end

  def arrived_at_donor!
    self.status = 'Arrived at Donor'
    self.save!
    devices = []

    if self.recipient.device_id
      devices << self.recipient.device_id
    end

    if devices.length > 0
      PushNotification.new.notify_devices({
        content: "#{self.driver.first_name} has picked up #{self.organization_name}'s donation.",
        devices: devices
      })
    end

  end

  def start!
    self.status = 'Driver In Progress'
    self.save!

    devices = []

    if self.donor.device_id
      devices << self.donor.device_id
    end

    if self.recipient.device_id
      devices << self.recipient.device_id
    end

    if devices.length > 0
      PushNotification.new.notify_devices({
        content: "#{self.driver.first_name} has started their journey to #{self.organization_name}.",
        devices: devices
      })
    end
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
