# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Dataset`
module CurationConcerns
  class DatasetForm < Sufia::Forms::WorkForm
    self.model_class = ::Dataset

    ## Adding custom descriptive metadata terms
    self.terms += %i(resource_type alternate_title time_period
                     required_software note geo_subject)

    ## Adding terms needed for the special DOI form tab
    self.terms += %i(doi doi_assignment_strategy existing_identifier)

    ## Adding terms college and department
    self.terms += %i(college department)

    ## Removing terms that we don't use
    self.terms -= %i(keyword source contributor)

    ## Setting custom required fields
    self.required_fields = %i(title creator college department description required_software rights)

    ## Adding above the fold on the form without making this required
    def primary_terms
      required_fields + [:publisher]
    end

    ## Overriding secondary terms to establish custom field order
    def secondary_terms
      %i(date_created alternate_title subject
         geo_subject time_period language
         note)
    end

    def self.multiple?(field)
      if %i(title description rights date_created).include? field.to_sym
        false
      else
        super
      end
    end

    ## Gymnastics to allow repeatble fields to behave as non-repeatable
    def self.model_attributes(_)
      attrs = super
      attrs[:title] = Array(attrs[:title]) if attrs[:title]
      attrs[:description] = Array(attrs[:description]) if attrs[:description]
      attrs[:date_created] = Array(attrs[:date_created]) if attrs[:date_created]
      attrs
    end

    def title
      super.first || ""
    end

    def description
      super.first || ""
    end

    def date_created
      super.first || ""
    end
  end
end