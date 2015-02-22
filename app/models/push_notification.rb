class PushNotification

  #- PushWoosh API Documentation http://www.pushwoosh.com/programming-push-notification/pushwoosh-push-notification-remote-api/
  #- Two methods here:
  #     - PushNotification.new.notify_all(message) Notifies all with the same option
  #     - PushNotification.new.notify_devices(notification_options = {}) Notifies specific devices with custom options

  include HTTParty #Make sure to have the HTTParty gem declared in your gemfile https://github.com/jnunemaker/httparty
  format :json

  def initialize
    #- Change to your settings
    @auth = {:application  => "787CF-7C7BD", :auth => "ewTty2hGWbmXcjE8L0UHtDE2ZDs0HLe7z2jA5MyCrJgAt4Rf5ZanfUmKpCOhDsoJe0ivIM4sGuYqopiZaE4i"}
  end

  # PushNotification.new.notify_all("This is a test notification to all devices")
  def notify_all(message)
    notify_devices({:content  => message})
  end

  # PushNotification.new.notify_devices({
  #  :content  => "TEST",
  #  :data  => {:custom_data  => value},
  #  :devices  => array_of_tokens
  #})
  def notify_devices(notification_options = {})
    #- Default options, uncomment :data or :devices if needed
    default_notification_options = {
                        # YYYY-MM-DD HH:mm  OR 'now'
                        :send_date  => "now",
                        # Object( language1: 'content1', language2: 'content2' ) OR string
                        :content  => {
                            :fr  => "Test",
                            :en  => "Test"
                        },
                        # JSON string or JSON object "custom": "json data"
                        #:data  => {
                        #    :custom_data  => value
                        #},
                        # omit this field (push notification will be delivered to all the devices for the application), or provide the list of devices IDs
                        #:devices  => {}
                      }

    puts 'this happened'

    #- Merging with specific options
    final_notification_options = default_notification_options.merge(notification_options)

    #- Constructing the final call
    options = @auth.merge({:notifications  => [final_notification_options]})
    options = {:request  => options}
    #- Executing the POST API Call with HTTPARTY - :body => options.to_json allows us to send the json as an object instead of a string
    response = self.class.post("https://cp.pushwoosh.com/json/1.3/createMessage", :body  => options.to_json,:headers => { 'Content-Type' => 'application/json' })
  end
end
