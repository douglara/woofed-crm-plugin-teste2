require 'rails_helper'

RSpec.describe 'application.tailwind.css patch' do
  let(:original) { Rails.root.join('app/assets/stylesheets/application.tailwind.css').read }

  before { Plugins::FilePatch.clear_registry! }
  after  { Plugins::FilePatch.clear_registry! }

  it 'applies the light red primary colors' do
    load Rails.root.join('storage/plugins/teste2/app/assets/stylesheets/application.tailwind.css')
    result = Plugins::FilePatch.apply('app/assets/stylesheets/application.tailwind.css', original)

    expect(result).to include('--primary: oklch(0.62 0.2 27)')
    expect(result).to include('--primary-foreground: oklch(0.0 0 0)')
    expect(result).to include('--sidebar-primary: oklch(0.62 0.2 27)')
    expect(result).to include('--sidebar-primary-foreground: oklch(0.0 0 0)')
  end

  it 'does not modify the original file on disk' do
    original_content = Rails.root.join('app/assets/stylesheets/application.tailwind.css').read
    expect(original_content).not_to include('oklch(0.62 0.2 27)')
  end
end
