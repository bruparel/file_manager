module ActiveRecord
  class Errors

    # Redefine the ActiveRecord::Errors::full_messages method:
    #  Returns all the full error messages in an array. 'Base' messages are handled as usual.
    #  Non-base messages are prefixed with the attribute name as usual UNLESS they begin with '^'
    #  in which case the attribute name is omitted.
    #  E.g. validates_acceptance_of :accepted_terms, :message => '^Please accept the terms of service'
    def full_messages
      full_messages = []

      @errors.each_key do |attr|
        @errors[attr].each do |msg|
          next if msg.nil?

          if attr == "base"
            full_messages << msg
          elsif msg =~ /^\^/
            full_messages << msg[1..-1]
          else
            full_messages << @base.class.human_attribute_name(attr) + " " + msg
          end
        end
      end

      return full_messages
    end
  end
end
