class AddAttachmentToVulnerabilities < ActiveRecord::Migration
  def change
    add_column :vulnerabilities, :attachment, :string
  end
end
