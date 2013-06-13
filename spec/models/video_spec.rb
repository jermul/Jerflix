require 'spec_helper'

describe Video do
	it { should have_many(:categories).through(:video_categories) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }

	describe 'search_by_title' do
		it 'returns an empty array for a search with an empty string' do
			futurama = Video.create(title: 'Futurama', description: 'futuristic comedy')
			south_park = Video.create(title: 'South Park', description: 'potty humor')
			expect(Video.search_by_title('')).to eq([])
		end

		it 'returns an empty array if there is no match' do
			futurama = Video.create(title: 'Futurama', description: 'futuristic comedy')
			south_park = Video.create(title: 'South Park', description: 'potty humor')
			expect(Video.search_by_title("hello")).to eq([])
		end

		it 'returns an array of one video for an exact match' do
			futurama = Video.create(title: 'Futurama', description: 'futuristic comedy')
			south_park = Video.create(title: 'South Park', description: 'potty humor')
			expect(Video.search_by_title('Futurama')).to eq([futurama])
		end

		it 'returns an array of one video for a partial match' do
			futurama = Video.create(title: 'Futurama', description: 'futuristic comedy')
			south_park = Video.create(title: 'South Park', description: 'potty humor')
			expect(Video.search_by_title('urama')).to eq([futurama])
		end

		it 'returns an array of all matches ordered by created_at' do
			futurama = Video.create(title: 'Futurama', description: 'futuristic comedy', created_at: 1.day.ago)
			south_park = Video.create(title: 'South Park', description: 'potty humor')
			expect(Video.search_by_title('u')).to eq([south_park, futurama])
		end
	end
end