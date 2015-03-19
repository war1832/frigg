json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :second_title, :user_id
  json.url blog_url(blog, format: :json)
end
