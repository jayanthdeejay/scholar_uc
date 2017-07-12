class RenameSufiaFeaturesToHyraxFeatures < ActiveRecord::Migration
  def change
    rename_table :sufia_features, :hyrax_features
  end 
end

