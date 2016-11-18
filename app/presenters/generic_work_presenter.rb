# frozen_string_literal: true
class GenericWorkPresenter < Sufia::WorkShowPresenter
  delegate :alternate_title, :genre, :time_period, :required_software, :note, :doi, to: :solr_document
end
