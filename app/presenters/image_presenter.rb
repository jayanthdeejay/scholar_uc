# frozen_string_literal: true
class ImagePresenter < Sufia::WorkShowPresenter
  delegate :college, :department, :alternate_title, :date_photographed, :genre, :time_period, :required_software, :note, :cultural_context, :doi, to: :solr_document
end