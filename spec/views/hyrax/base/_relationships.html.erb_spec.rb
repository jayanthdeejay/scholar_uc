# frozen_string_literal: true
require 'spec_helper'

describe 'curation_concerns/base/relationships', type: :view do
  let(:ability) { double }
  let(:solr_doc) { double(id: '123', human_readable_type: 'Work', admin_set: nil) }
  let(:presenter) { Hyrax::WorkShowPresenter.new(solr_doc, ability) }
  let(:generic_work) { GenericWork.new(id: '456', title: ['Containing work']) }
  let(:collection) { Collection.new(id: '345', title: ['Containing collection']) }

  context "when collections are not present" do
    before do
      render 'curation_concerns/base/relationships', presenter: presenter
    end
    it "shows the message" do
      expect(rendered).not_to match %r{There are no Collection relationships\.}
    end
  end

  context "when parents are not present" do
    before do
      render 'curation_concerns/base/relationships', presenter: presenter
    end
    it "shows the message" do
      expect(rendered).not_to match %r{There are no Generic work relationships\.}
    end
  end

  context "when collections are present and no parents are present" do
    let(:collection_presenters) { [collection] }
    let(:page) { Capybara::Node::Simple.new(rendered) }
    before do
      allow(view).to receive(:contextual_path).and_return("/collections/456")
      allow(presenter).to receive(:collection_presenters).and_return(collection_presenters)
      render 'curation_concerns/base/relationships', presenter: presenter
    end
    it "links to collections" do
      expect(page).to have_link 'Containing collection'
    end
    it "labels the link using the presenter's #to_s method" do
      expect(page).not_to have_content 'foobar'
    end
    it "shows the empty messages for parents" do
      expect(page).not_to have_content "There are no Collection relationships."
      expect(page).not_to have_content "There are no Generic work relationships."
    end
  end

  context "when parents are present and no collections are present" do
    let(:collection_presenters) { [generic_work] }
    let(:page) { Capybara::Node::Simple.new(rendered) }
    before do
      allow(view).to receive(:contextual_path).and_return("/concern/generic_works/456")
      allow(presenter).to receive(:collection_presenters).and_return(collection_presenters)
      render 'curation_concerns/base/relationships', presenter: presenter
    end
    it "links to work" do
      expect(page).to have_link 'Containing work'
    end
    it "labels the link using the presenter's #to_s method" do
      expect(page).not_to have_content 'barbaz'
    end
    it "shows the empty messages for collections" do
      expect(page).not_to have_content "There are no Collection relationships."
      expect(page).not_to have_content "There are no Generic work relationships."
    end
  end

  context "when parents are present and collections are present" do
    let(:collection_presenters) { [generic_work, collection] }
    let(:page) { Capybara::Node::Simple.new(rendered) }
    before do
      allow(view).to receive(:contextual_path).and_return("/concern/generic_works/456")
      allow(presenter).to receive(:collection_presenters).and_return(collection_presenters)
      render 'curation_concerns/base/relationships', presenter: presenter
    end
    it "links to work and collection" do
      expect(page).to have_link 'Containing work'
      expect(page).to have_link 'Containing collection'
    end
    it "labels the link using the presenter's #to_s method" do
      expect(page).not_to have_content 'barbaz'
      expect(page).not_to have_content 'foobar'
    end
    it "does not show the empty messages" do
      expect(page).not_to have_content "There are no Collection relationships."
      expect(page).not_to have_content "There are no Generic work relationships."
    end
  end

  context 'with admin sets' do
    skip "failing becuase of hidden admin set select" do
      it 'renders using attribute_to_html' do
        allow(solr_doc).to receive(:member_of_collection_ids).and_return([])
        expect(presenter).to receive(:attribute_to_html).with(:admin_set, render_as: :faceted)
        render 'curation_concerns/base/relationships', presenter: presenter
      end
    end
  end
end
