# frozen_string_literal: true
# This gets mixed into FileSetPresenter in order to create
# a canvas on a IIIF manifest
module DisplaysImage
  extend ActiveSupport::Concern

  def display_image
    return nil unless FileSet.exists?(id) && image_modifier == true

    # TODO: this is slow, find a better way (perhaps index iiif url):

    original_file = FileSet.find(id).original_file

    # TODO: We want url to be like https://libimages1.princeton.edu/loris/plum/0c%2F48%2F3j%2F48%2F8-intermediate_file.jp2/full/!200,200/0/default.jpg
    url = display_image_url(original_file)
    IIIFManifest::DisplayImage.new(url, width: 640, height: 480, iiif_endpoint: iiif_endpoint(original_file))
  end

  private

    def image_modifier
      mime_type_file = FileSet.find(id).mime_type
      return false unless mime_type_file == 'image/jp2' || mime_type_file == 'image/tiff' || mime_type_file == 'image/png' || mime_type_file == 'image/jpeg'
      true
    end

    def display_image_url(original_file, size = '600,')
      Riiif::Engine.routes.url_helpers.image_url(original_file.id,
                                                 host: request.base_url,
                                                 size: size)
    end

    def base_image_url(original_file)
      uri = Riiif::Engine.routes.url_helpers.info_url(original_file.id, host: request.base_url)
      # TODO: There should be a riiif route for this:
      uri.sub(%r{/info\.json\Z}, '')
    end

    def iiif_endpoint(original_file)
      IIIFManifest::IIIFEndpoint.new(base_image_url(original_file), profile: "http://iiif.io/api/image/2/level2.json")
    end
end
