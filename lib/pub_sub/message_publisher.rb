module PubSub
  module MessagePublisher
    def publish(async: false, topic: PubSub.service_identifier)
      Publisher.publish(message_json, async: async, topic: topic)
    end

    def message_type
      @message_type ||=
        begin
          klass = self.class.name.dup
          klass.replace(klass.scan(/[A-Z][a-z]*/).join('_').downcase)
        end
    end

    def message_json
      JSON.dump(sender: PubSub.service_identifier,
                origin: `whoami`.strip,
                type: message_type,
                data: message_data)
    end
  end
end
