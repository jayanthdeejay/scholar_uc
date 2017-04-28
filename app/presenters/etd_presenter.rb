# frozen_string_literal: true
class EtdPresenter < Sufia::WorkShowPresenter
  delegate :college, :department, :alternate_title, :time_period, :required_software, :note, :degree, :advisor, :committee_member, :geo_subject, :doi, to: :solr_document
end
