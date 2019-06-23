# frozen_string_literal: true

class Fam::Family
  class Relationship
    include Comparable

    def self.from_h(input_hash)
      new(
        child_name: input_hash.fetch(:child_name),
        parent_name: input_hash.fetch(:parent_name)
      )
    end

    def initialize(
      child_name:,
      parent_name:
    )
      @child_name = child_name
      @parent_name = parent_name
    end

    attr_reader :child_name,
                :parent_name

    def to_h
      {
        child_name: child_name,
        parent_name: parent_name,
      }
    end

    def <=>(other)
      [child_name, parent_name] <=>
        [other.child_name, other.parent_name]
    end
  end
end
