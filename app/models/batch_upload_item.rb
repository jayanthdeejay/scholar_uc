# frozen_string_literal: true
# This stands in for an object to be created from the BatchUploadForm.
# It should never actually be persisted in the repository.
# The properties on this form should be copied to a real work type.
class BatchUploadItem < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Hyrax::BasicMetadata
  include Hyrax::WorkBehavior

  attr_accessor :payload_concern # a Class name: what is this a batch of?

  # This mocks out the behavior of Hydra::PCDM::PcdmBehavior
  def in_collection_ids
    []
  end

  def create_or_update
    raise "This is a read only record"
  end

  property :advisor, predicate: ::RDF::URI.new('http://purl.org/dc/terms/contributor#advisor') do |index|
    index.as :stored_searchable
  end

  property :alternate_title, predicate: ::RDF::URI.new('http://purl.org/dc/terms/title#alternative') do |index|
    index.as :stored_searchable
  end

  property :geo_subject, predicate: ::RDF::URI.new('http://purl.org/dc/terms/coverage#spatial') do |index|
    index.as :stored_searchable, :facetable
  end

  property :time_period, predicate: ::RDF::URI.new('http://purl.org/dc/terms/coverage#temporal') do |index|
    index.as :stored_searchable, :facetable
  end

  property :required_software, predicate: ::RDF::Vocab::DC.requires, multiple: false do |index|
    index.as :stored_searchable
  end

  property :committee_member, predicate: ::RDF::URI.new('http://purl.org/dc/terms/contributor#committee_member') do |index|
    index.as :stored_searchable
  end

  property :etd_publisher, predicate: ::RDF::URI.new('http://purl.org/dc/terms/publisher'), multiple: false do |index|
    index.as :stored_searchable
  end

  property :degree, predicate: ::RDF::URI.new('http://purl.org/dc/terms/subject#degree'), multiple: false do |index|
    index.as :stored_searchable
  end
end
