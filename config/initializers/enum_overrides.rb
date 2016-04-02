module ActiveRecord
  module Enum
    # Replace enum with edge version.  Remove after Rails 5

    class EnumType < Type::Value
      def initialize(name, mapping)
        @name = name
        @mapping = mapping
      end

      def type_cast_from_user(value)
        return if value.blank?

        if mapping.has_key?(value)
          value.to_s
        elsif mapping.has_value?(value)
          mapping.key(value)
        else
          raise ArgumentError, "'#{value}' qis not a valid #{name}"
        end
      end

      def type_cast_from_database(value)
        return if value.nil?
        mapping.key(value)
      end

      def type_cast_for_database(value)
        mapping.fetch(value, value)
      end

      protected

      attr_reader :name, :mapping
    end

    def enum(definitions)
      klass = self
      enum_prefix = definitions.delete(:_prefix)
      enum_suffix = definitions.delete(:_suffix)

      definitions.each do |name, values|
        # statuses = { }
        enum_values = ActiveSupport::HashWithIndifferentAccess.new
        name        = name.to_sym

        # def self.statuses statuses end
        detect_enum_conflict!(name, name.to_s.pluralize, true)
        klass.singleton_class.send(:define_method, name.to_s.pluralize) { enum_values }

        detect_enum_conflict!(name, name)
        detect_enum_conflict!(name, "#{name}=")

        attribute name, EnumType.new(name, enum_values)

        _enum_methods_module.module_eval do
          pairs = values.respond_to?(:each_pair) ? values.each_pair : values.each_with_index
          pairs.each do |value, i|
            if enum_prefix == true
              prefix = "#{name}_"
            elsif enum_prefix
              prefix = "#{enum_prefix}_"
            end
            if enum_suffix == true
              suffix = "_#{name}"
            elsif enum_suffix
              suffix = "_#{enum_suffix}"
            end

            value_method_name = "#{prefix}#{value}#{suffix}"
            enum_values[value] = i

            # def active?() status == 0 end
            klass.send(:detect_enum_conflict!, name, "#{value_method_name}?")
            define_method("#{value_method_name}?") { self[name] == value.to_s }

            # def active!() update! status: :active end
            klass.send(:detect_enum_conflict!, name, "#{value_method_name}!")
            define_method("#{value_method_name}!") { update! name => value }

            # scope :active, -> { where status: 0 }
            klass.send(:detect_enum_conflict!, name, value_method_name, true)
            klass.scope value_method_name, -> { klass.where name => value }
          end
        end
        defined_enums[name.to_s] = enum_values
      end
    end
  end
end
