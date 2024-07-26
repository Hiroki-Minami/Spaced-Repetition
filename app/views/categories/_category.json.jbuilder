json.extract! category, :id, :name, :description, :is_public, :created_at, :updated_at
json.url category_url(category, format: :json)
