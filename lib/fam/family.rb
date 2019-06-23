# frozen_string_literal: true

require 'fam/family/person'
require 'fam/family/relationship'

module Fam
  # IMPLEMENT ME
  # Other than the class name, everything in here gets cleared when before
  # the code is handed off to the sourcerer.
  class Family
    MAX_PARENTS = 2

    module Errors
      class Any < StandardError; end
      class DuplicatePerson < Any; end
      class NoSuchPerson < Any; end
      class ExcessParents < Any; end
    end

    def self.from_h(input_hash)
      people =
        input_hash
        .fetch(:people, [])
        .map(&Person.method(:from_h))
      relationships =
        input_hash
        .fetch(:relationships, [])
        .map(&Relationship.method(:from_h))
      new(
        people: people,
        relationships: relationships
      )
    end

    def initialize(people: [], relationships: [])
      initialize_name_to_person(people)
      @relationships = relationships
    end

    def to_h
      {
        people: people.map(&:to_h),
        relationships: @relationships.map(&:to_h),
      }
    end

    def inspect
      "#<#{self.class.name} with #{people.length} members>"
    end

    def people
      @name_to_person.values
    end

    def add_person(person)
      raise Errors::DuplicatePerson, person.name if include?(person.name)

      @name_to_person[person.name] = person
    end

    def get_person(name)
      assert_includes!(name)

      @name_to_person.fetch(name)
    end

    def include?(name)
      @name_to_person.include?(name)
    end

    def add_parent(parent:, child:)
      assert_includes!(parent.name, child.name)

      parent_relationships = get_parent_relationships(child)
      is_already_a_parent = parent_relationships.map(&:parent_name).include?(parent.name)
      return parent if is_already_a_parent
      raise Errors::ExcessParents if parent_relationships.count >= MAX_PARENTS

      @relationships << Fam::Family::Relationship.new(
        child_name: child.name,
        parent_name: parent.name
      )
      parent
    end

    def get_parents(child)
      get_parent_relationships(child).map do |relationship|
        get_person(relationship.parent_name)
      end
    end

    def get_grandparents(child, greatness: 0)
      grandparents = get_parents(child)
      (0..greatness).each do
        grandparents = grandparents.flat_map(&method(:get_parents))
      end
      grandparents
    end

    private

    def assert_includes!(*names)
      names.each do |name|
        raise Errors::NoSuchPerson, name unless include?(name)
      end
    end

    def get_parent_relationships(child)
      @relationships.select do |relationship|
        relationship.child_name == child.name
      end
    end

    def initialize_name_to_person(people)
      @name_to_person = people.to_h do |person|
        [person.name, person]
      end
    end
  end
end
