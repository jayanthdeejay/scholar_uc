# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Image`
module CurationConcerns
  module Actors
    class ImageActor < CurationConcerns::Actors::BaseActor
      private

        def save
          curation_concern.extend(RemotelyIdentifiedByDoi::MintingBehavior)
          curation_concern.apply_doi_assignment_strategy do |*|
            curation_concern.save
          end
        end
    end
  end
end
