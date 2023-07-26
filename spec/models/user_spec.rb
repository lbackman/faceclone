require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_content_type_of(:avatar)
    .allowing('image/png', 'image/jpeg')
    .rejecting('text/plain', 'text/xml')
  }
  
  it { is_expected.to validate_dimensions_of(:avatar)
    .width_between(80..250)
    .height_between(80..250)
  }
end
