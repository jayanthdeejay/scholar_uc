# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Image`
class Image < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Hyrax::BasicMetadata
  include Sufia::WorkBehavior
  include RemotelyIdentifiedByDoi::Attributes

  self.human_readable_type = 'Image'
  self.human_readable_short_description = 'Visual content: art, photographs, posters, graphics.'
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :alternate_title, predicate: ::RDF::URI.new('http://purl.org/dc/terms/title#alternative') do |index|
    index.as :stored_searchable
  end

  property :geo_subject, predicate: ::RDF::URI.new('http://purl.org/dc/terms/coverage#spatial') do |index|
    index.as :stored_searchable, :facetable
  end

  property :genre, predicate: ::RDF::URI.new('http://purl.org/dc/terms/type#genre'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :time_period, predicate: ::RDF::URI.new('http://purl.org/dc/terms/coverage#temporal') do |index|
    index.as :stored_searchable, :facetable
  end

  property :required_software, predicate: ::RDF::Vocab::DC.requires, multiple: false do |index|
    index.as :stored_searchable
  end

  property :note, predicate: ::RDF::URI.new('http://purl.org/dc/terms/description#note'), multiple: false do |index|
    index.as :stored_searchable
  end

  property :college, predicate: ::RDF::URI.new('http://purl.org/dc/terms/subject#college'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :department, predicate: ::RDF::URI.new('http://purl.org/dc/terms/subject#department'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :alt_description, predicate: ::RDF::URI.new('http://purl.org/dc/terms/description'), multiple: false do |index|
    index.as :stored_searchable
  end

  property :alt_date_created, predicate: ::RDF::URI.new('http://purl.org/dc/terms/date#created'), multiple: false do |index|
    index.as :stored_searchable
  end

  def self.to_s_u
    'image'
  end
end
