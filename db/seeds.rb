module GoogleBooks
	class Adapter
		attr_reader :term

		BASE_URL = "https://www.googleapis.com/books/v1/volumes"

		def initialize(term = 'ruby programming')
			@term = term
		end

		def create_books_and_authors
			# make a request to the API
			response = RestClient.get("#{BASE_URL}?q=#{self.term}")
			#iterate over all the books in that response
			data = JSON.parse(response.body)
			# create and save the book objects and associated authors
			Book.new(title: book['volumeInfo']['title'], )
			if data['items'].first['volumeinfo']['authors']
				author_name = data['items'].first['volumeinfo']['authors'].first
				author = Author.find_or_create_by(name: author_name)
			end

			book.author = author
			book.save
		end

	end
end
term = gets.chomp
GoogleBooks::Adapter.new(term).create_books_and_authors
