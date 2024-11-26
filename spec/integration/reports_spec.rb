require 'swagger_helper'

RSpec.describe 'Reports API', type: :request do
  path '/reports' do
    get 'Retrieves all reports' do
      tags 'Reports'
      produces 'application/json'
      parameter name: :category_id, in: :query, type: :integer, description: 'Category ID'
      parameter name: :address_id, in: :query, type: :integer, description: 'Address ID'
      parameter name: :search, in: :query, type: :string, description: 'Search term'

      response '200', 'reports found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string },
                   category_id: { type: :integer },
                   address_id: { type: :integer },
                   status: { type: :string }
                 },
                 required: %w[id title description category_id address_id status]
               }

        run_test!
      end
    end
  end

  path '/reports/{id}' do
    get 'Retrieves a report' do
      tags 'Reports'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Report ID'

      response '200', 'report found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 description: { type: :string },
                 category_id: { type: :integer },
                 address_id: { type: :integer },
                 status: { type: :string }
               },
               required: %w[id title description category_id address_id status]

        run_test!
      end

      response '404', 'report not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end