class BooksController < ApplicationController

    before_action :set_book, only: [:edit, :show, :update, :destroy]

    def index
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true)
    end

    def new
        @book = Book.new
    end

    def create
        @book = Book.create(book_params)

        respond_to do |format|

            if @book.save
                format.html { redirect_to @book, notice: 'Book was successfully created.' }
                format.json { render :show, status: :created, location: @book }
            else
                format.html { render :new }
                format.json { render json: @book.errors, status: :unprocessable_entity }
            end
        end
    end

    def show

    end

    def update
        respond_to do |format|

            if @book.update(book_params)
                format.html { redirect_to @book, notice: 'Book was successfully updated.' }
                format.json { render :show, status: :ok, location: @book }
            else
                format.html { render :edit }
                format.json { render json: @book.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @book.destroy
        respond_to do |format|
            format.html { redirect_to books_url, notice: 'Book was successfully destroyed' }
            
        end
    end

    private
        def set_book
            @book = Book.find(params[:id])
        end

        def book_params
            params.require(:book).permit(:title, :author, :status, :borrowed_at, :returned_at)
        end
end
