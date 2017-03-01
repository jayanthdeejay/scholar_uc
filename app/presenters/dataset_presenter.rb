# frozen_string_literal: true
class DatasetPresenter < Sufia::WorkShowPresenter
  delegate :alternate_title, :genre, :time_period, :required_software, :note, to: :solr_document
end