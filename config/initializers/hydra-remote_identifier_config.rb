# Register and configure remote identifiers for persisted objects
Hydra::RemoteIdentifier.configure do |config|
  doi_credentials = Psych.load_file(Rails.root.join("config/doi.yml").to_s).fetch(Rails.env)
  config.remote_service(:doi, doi_credentials) do |doi|
    doi.register(GenericWork, Dataset, Article, Image, Document, Video, StudentWork, Etd) do |map|
      map.target {|obj| Curate.permanent_url_for(obj) }
      map.status :doi_status
      map.creator :creator
      map.title :title
      map.publisher {|o| Array(o.publisher).join("; ")}
      map.publicationyear {|o| o.date_uploaded.year }
      map.identifier_url :identifier_url
      # Make sure that this method both sets the identifier and persists the change!
      map.set_identifier do |o,value| 
        o.identifier = value.fetch(:identifier)
        o.identifier_url = value.fetch(:identifier_url)
        o.save
      end
    end
  end

  # doi_credentials = Psych.load_file("/path/to/doi_credentials.yml")
  # config.remote_service(:doi, doi_credentials) do |doi|
  #   doi.register(PersistedObject) do |map|
  #     map.target :url
  #     map.creator {|obj| obj.person_name }
  #     map.title :title
  #     map.publisher :publisher
  #     map.publicationyear :publicationyear
  #
  #     # Make sure that this method persists the value
  #     map.set_identifier :set_doi_identifier=
  #   end
  # end
end